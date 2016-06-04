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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    self.title = LocatizedStirngForkey(@"LISHIWEITUO");
    
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
    HQZXEmptyData(self.myTableView, hqzxEmptyManager, nil);
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
        return 17;
    }else if([tableView isEqual:self.myTwoTableView]){
        return 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=nil;
    NSUInteger section = [indexPath section];
    if([tableView isEqual:self.myTableView]){
        cell =[tableView dequeueReusableCellWithIdentifier:@"CustomHeaderTwo"];
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
@end
