//
//  HQZXHistoryEntrustManagementViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/4.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXHistoryEntrustManagementViewController.h"

@implementation HQZXHistoryEntrustManagementViewController{
    UIScrollView *_scroll;
    HQZXEmptyManager *hqzxEmptyManager;
    NSString *nextId;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    self.title = LocatizedStirngForkey(@"LISHIWEITUO");
    
    _datas = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSDictionary *dataDic = [rootDict objectForKey:@"data"];
    
    //x方向数据
    _arrX = [dataDic objectForKey:@"table_titles"];
    
    //y方向数据
    _arrY = [dataDic objectForKey:@"list_datas"];
    
    [self createScrollView];
    [self createTableTwoView];
    [self createTableView];
    WEAK_SELF
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself refData:^{
            [weakself.myTableView.mj_header endRefreshing];
            [weakself.myTableView.mj_footer resetNoMoreData];
        }];
    }];
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if([nextId isEqualToString:@"0"]==NO){
            [weakself moreWithCompletion:^(BOOL value) {
                [weakself.myTableView.mj_footer endRefreshing];
                if (value) {
                    [weakself.myTableView.mj_footer resetNoMoreData];
                } else {
                    [weakself.myTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }];
        }else{
            [weakself.myTableView.mj_footer endRefreshingWithNoMoreData];
            [weakself.view makeToast:LocatizedStirngForkey(MJRefreshBackFooterNoMoreDataText) duration:1 position:CSToastPositionCenter];
        }
        
    }];
    [self.myTableView.mj_header beginRefreshing];
    HQZXEmptyData(self.myTableView, hqzxEmptyManager, nil);
}
- (void) moreWithCompletion:(Bool_Block) completion {
    [[NetHttpClient sharedHTTPClient] request: @"/coins_entrust_record.json" parameters: @{@"types":@"1",@"next_id":nextId?nextId:@"0", @"symbol": _sysId,@"auth_key":[HQZXUserModel sharedInstance].currentUser.auth_key} completion:^(id obj) {
        if (obj==nil) {
            [self.view makeToast: LocatizedStirngForkey(@"LIANJIEFUWUQISHIBAI") duration: 0.5 position: CSToastPositionCenter];
            if (completion) {
                completion(YES);
            }
            return;
        }
        NSString *errorCode = StrValueFromDictionary(obj, ApiKey_ErrorCode);
        if (![@"0" isEqualToString: errorCode]) {
            [self.view makeToast: [obj objectForKey:@"message"] duration: 0.5 position: CSToastPositionCenter];
            if (completion) {
                completion(YES);
            }
            return;
        }
        NSString *nextIdServer = StrValueFromDictionary(obj, @"next_id");
        NSArray *dataArray = [obj objectForKey: @"record_list"];
        
        if (nextIdServer != nil) {
            nextId = nextIdServer;
        }
        
        if(dataArray!=nil && dataArray.count>0){
            [_datas addObjectsFromArray: dataArray];
        }
        
        [self.myTableView reloadData];
        if (completion) {
            if (nextIdServer) {
                completion(YES);
            } else {
                completion(NO);
            }
        }
    }];
}
- (void) refData:(Void_Block) completion{
    [[NetHttpClient sharedHTTPClient] request: @"/coins_entrust_record.json" parameters:@{@"types":@"1",@"next_id":@"0", @"symbol": _sysId,@"auth_key":[HQZXUserModel sharedInstance].currentUser.auth_key} completion:^(id obj) {
        if (obj==nil) {
            [self.view makeToast: LocatizedStirngForkey(@"LIANJIEFUWUQISHIBAI") duration: 0.5 position: CSToastPositionCenter];
            if (completion) {
                completion();
            }
            return;
        }
        NSString *errorCode = StrValueFromDictionary(obj, ApiKey_ErrorCode);
        if (![@"0" isEqualToString: errorCode]) {
            [self.view makeToast: [obj objectForKey:@"message"] duration: 0.5 position: CSToastPositionCenter];
            if (completion) {
                completion();
            }
            return;
        }
        
        NSString *nextIdServer = StrValueFromDictionary(obj, @"next_id");
        
        if (nextIdServer != nil) {
            nextId = nextIdServer;
        }
        
        [_datas removeAllObjects];
        if ([obj objectForKey: @"record_list"] == nil) {
            
        } else {
            [_datas addObjectsFromArray: [obj objectForKey: @"record_list"]];
            //1 竞标中 2中标
        }
        [self.myTableView reloadData];
        if (completion) {
            completion();
        }
    }];
}
-(void)createScrollView{
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT) ];
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH*2.2, SCREEN_HEIGHT-TOP_HEIGHT);
    //    _scroll.showsHorizontalScrollIndicator = NO;
    //    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.bounces = NO;
    _scroll.delegate = self;
    _scroll.backgroundColor = UIColorFromRGB(0x0C1319);
    //设置边框，形成表格
    _scroll.layer.borderWidth = .5f;
    _scroll.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.view addSubview:_scroll];
}
-(void)createTableTwoView{
    UITableView *tableTwoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH*2.2, SCREEN_WIDTH/8) style:UITableViewStyleGrouped];
    tableTwoView.scrollEnabled = NO;
    tableTwoView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableTwoView.dataSource = self;
    // 设置tableView的委托
    tableTwoView.delegate = self;
    tableTwoView.backgroundColor = UIColorFromRGB(0x0F151A);
    self.myTwoTableView = tableTwoView;
    [self.myTwoTableView registerClass:[HQZXHistoryEntrustTableCell class] forCellReuseIdentifier:@"CustomHeaderOne"];
    [_scroll addSubview:self.myTwoTableView];
}
-(void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.myTwoTableView.maxY , SCREEN_WIDTH*2.2, SCREEN_HEIGHT-TOP_HEIGHT - SCREEN_WIDTH/8) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableView.dataSource = self;
    // 设置tableView的委托
    tableView.delegate = self;
    tableView.backgroundColor = UIColorFromRGB(0x0F151A);
    self.myTableView = tableView;
    
    [self.myTableView registerClass:[HQZXHistoryDataEnTableCell class] forCellReuseIdentifier:@"CustomHeaderTwo"];
    [_scroll addSubview:self.myTableView];
}
// 设置块的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH/8;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([tableView isEqual:self.myTableView]){
        return _datas.count;
    }else if([tableView isEqual:self.myTwoTableView]){
        return 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=nil;
    NSUInteger section = [indexPath section];
    id btbData;
    if(_datas.count>0){
        btbData = [_datas objectAtIndex:section];
    }
    if([tableView isEqual:self.myTableView]){
        cell =[tableView dequeueReusableCellWithIdentifier:@"CustomHeaderTwo"];
        HQZXHistoryDataEnTableCell *cellen = (HQZXHistoryDataEnTableCell*) cell;
        if(btbData){
            cellen.time = StrValueFromDictionary(btbData, @"time");
            cellen.tradetype = StrValueFromDictionary(btbData, @"tradetype");
            cellen.number = StrValueFromDictionary(btbData, @"number");
            cellen.price = StrValueFromDictionary(btbData, @"price");
            cellen.fee = StrValueFromDictionary(btbData, @"fee");
            cellen.volume = StrValueFromDictionary(btbData, @"volume");
            cellen.dealmoney = StrValueFromDictionary(btbData, @"dealmoney");
            cellen.status = StrValueFromDictionary(btbData, @"status");
        }
        
    }else if([tableView isEqual:self.myTwoTableView]){
        cell =[tableView dequeueReusableCellWithIdentifier:@"CustomHeaderOne"];
    }
    
    //    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if(cell==nil){
    //        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    //    }
    //    cell.backgroundColor = UIColorFromRGB(0x0F151A);
    //    cell.textLabel.text = @"sdkahskfhaks";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //push后cell选中效果消失,又动画
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentYoffset = scrollView.contentOffset.y;
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
    NSLog(@"height:%f contentYoffset:%f frame.y:%f",height,contentYoffset,scrollView.frame.origin.y);
    if (distanceFromBottom < height) {
        if(height>SCREEN_HEIGHT-TOP_HEIGHT){
            if(![nextId isEqualToString:@"0"]){
                [self.view makeToast:LocatizedStirngForkey(MJRefreshBackFooterIdleText) duration:1 position:CSToastPositionCenter];
            }
        }
    }
}
@end
