//
//  HQZXPresentRecordViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/13.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXPresentRecordViewController.h"

@implementation HQZXPresentRecordViewController{
    UIScrollView *_scroll;
    HQZXEmptyManager *hqzxEmptyManager;
    UILabel *zuijin;
    NSString *nextId;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    self.title = LocatizedStirngForkey(@"TIXIANJILU");
    
    _datas = [NSMutableArray array];
    
    zuijin = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    zuijin.text = LocatizedStirngForkey(@"ERSHIBITIXIANJILU");
    zuijin.textColor = [UIColor whiteColor];
    zuijin.font = [UIFont systemFontOfSize: FIRSTFONTONE];
    [self.view addSubview: zuijin];
    [zuijin sizeToFit];
    [zuijin setX:SCREEN_WIDTH/20];
    [zuijin setY:TOP_HEIGHT+SCREEN_WIDTH/25];
    
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
    
    [self.myTableView.mj_header beginRefreshing];
    HQZXEmptyData(self.myTableView, hqzxEmptyManager, nil);

}
- (void) refData:(Void_Block) completion{
    [[NetHttpClient sharedHTTPClient] request: @"/rmb_extract_record.json" parameters:@{@"next_id":@"0",@"auth_key":[HQZXUserModel sharedInstance].currentUser.auth_key} completion:^(id obj) {
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
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, zuijin.maxY+SCREEN_WIDTH/25, SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT) ];
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH*2, SCREEN_HEIGHT-TOP_HEIGHT);
    //    _scroll.showsHorizontalScrollIndicator = YES;
    //    _scroll.showsVerticalScrollIndicator = YES;
    _scroll.bounces = NO;
    _scroll.delegate = self;
    _scroll.backgroundColor = UIColorFromRGB(0x0C1319);
    //设置边框，形成表格
    _scroll.layer.borderWidth = .5f;
    _scroll.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.view addSubview:_scroll];
}
-(void)createTableTwoView{
    UITableView *tableTwoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH*2, SCREEN_WIDTH/8) style:UITableViewStyleGrouped];
    tableTwoView.scrollEnabled = NO;
    tableTwoView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableTwoView.dataSource = self;
    // 设置tableView的委托
    tableTwoView.delegate = self;
    tableTwoView.backgroundColor = UIColorFromRGB(0x0F151A);
    self.myTwoTableView = tableTwoView;
    [self.myTwoTableView registerClass:[HQZXPresentTableCell class] forCellReuseIdentifier:@"CustomHeaderOne"];
    [_scroll addSubview:self.myTwoTableView];
}
-(void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.myTwoTableView.maxY , SCREEN_WIDTH*2, SCREEN_HEIGHT-zuijin.maxY-SCREEN_WIDTH/25 - SCREEN_WIDTH/8) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableView.dataSource = self;
    // 设置tableView的委托
    tableView.delegate = self;
    tableView.backgroundColor = UIColorFromRGB(0x0F151A);
    self.myTableView = tableView;
    [self.myTableView registerClass:[HQZXDataPreTableCell class] forCellReuseIdentifier:@"CustomHeaderTwo"];
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
        HQZXDataPreTableCell *cellen = (HQZXDataPreTableCell*) cell;
        if(btbData){
            cellen.create_time = StrValueFromDictionary(btbData, @"create_time");
            cellen.name = StrValueFromDictionary(btbData, @"name");
            cellen.bank = StrValueFromDictionary(btbData, @"bank");
            cellen.bank_card = StrValueFromDictionary(btbData, @"bank_card");
            cellen.fee = StrValueFromDictionary(btbData, @"fee");
            cellen.money = StrValueFromDictionary(btbData, @"money");
            cellen.fee = StrValueFromDictionary(btbData, @"fee");
            cellen.state = StrValueFromDictionary(btbData, @"state");
        }
        
    }else if([tableView isEqual:self.myTwoTableView]){
        cell =[tableView dequeueReusableCellWithIdentifier:@"CustomHeaderOne"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //push后cell选中效果消失,又动画
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
