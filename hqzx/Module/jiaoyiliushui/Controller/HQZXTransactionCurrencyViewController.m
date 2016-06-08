//
//  HQZXTransactionCurrencyViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/4.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXTransactionCurrencyViewController.h"

@implementation HQZXTransactionCurrencyViewController{
    UIScrollView *_scroll;
    HQZXEmptyManager *hqzxEmptyManager;
    UIScrollView *_accscroll;
    HQZXEmptyManager *hqzxEmptyManagers;
    UIView *buyView;
    UIView *sellView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    self.title = LocatizedStirngForkey(@"JIAOYILIUSHUI");
    
    [self clickButton];
    
    [self createScrollView];
    [self createAccScrollView];
    [self createTableTwoView];
    [self createTableView];
    [self createAccTableTwoView];
    [self createAccTableView];
    HQZXEmptyData(self.myAccTableView, hqzxEmptyManager, nil);
    HQZXEmptyData(self.myAccDataTableView, hqzxEmptyManagers, nil);
}
-(void)clickButton{
    buyView = [[UIView alloc] initWithFrame: CGRectMake(0, TOP_HEIGHT+8, (SCREEN_WIDTH-2)/2, SCREEN_WIDTH/10)];
    buyView.backgroundColor = UIColorFromRGB(0x192834);
    [self.view addSubview:buyView];
    
    buyView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buyGe:)];
    [buyView addGestureRecognizer:tapGesture];
    
    UILabel *buylable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    buylable.text = LocatizedStirngForkey(@"JIAOYI");
    buylable.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    buylable.textColor = [UIColor whiteColor];
    [buyView addSubview: buylable];
    [buylable sizeToFit];
    [buylable setX:(buyView.width-buylable.width)/2];
    [buylable setY:(buyView.height-buylable.height)/2];
    
    
    UIView *buyhenglineoneView = [[UIView alloc] initWithFrame: CGRectMake(0, TOP_HEIGHT+7, (SCREEN_WIDTH-2)/2, 1)];
    buyhenglineoneView.backgroundColor = UIColorFromRGB(0x141D25);
    [self.view addSubview:buyhenglineoneView];
    
    UIView *buylineoneView = [[UIView alloc] initWithFrame: CGRectMake(buyView.maxX, buyView.y, 1, SCREEN_WIDTH/10)];
    buylineoneView.backgroundColor = UIColorFromRGB(0x141D25);
    [self.view addSubview:buylineoneView];
    
    UIView *buylinetwoView = [[UIView alloc] initWithFrame: CGRectMake(buylineoneView.maxX, buyView.y, 1, SCREEN_WIDTH/10)];
    buylinetwoView.backgroundColor = UIColorFromRGB(0x0D1318);
    [self.view addSubview:buylinetwoView];
    
    sellView = [[UIView alloc] initWithFrame: CGRectMake(buylinetwoView.maxX, buyView.y, (SCREEN_WIDTH-2)/2, SCREEN_WIDTH/10)];
    sellView.backgroundColor = UIColorFromRGB(0x0F151A);
    [self.view addSubview:sellView];
    
    sellView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sellGe:)];
    [self.view addGestureRecognizer:tapGesture2];
    
    UILabel *selllable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    selllable.text = LocatizedStirngForkey(@"ZHUANGZHANG");
    selllable.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    selllable.textColor = [UIColor whiteColor];
    [sellView addSubview: selllable];
    [selllable sizeToFit];
    [selllable setX:(sellView.width-selllable.width)/2];
    [selllable setY:(sellView.height-selllable.height)/2];
    
    UIView *buyhenglinetwoView = [[UIView alloc] initWithFrame: CGRectMake(buylinetwoView.maxX, TOP_HEIGHT+7, (SCREEN_WIDTH-2)/2, 1)];
    buyhenglinetwoView.backgroundColor = UIColorFromRGB(0x141D25);
    [self.view addSubview:buyhenglinetwoView];
}
-(void)createScrollView{
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TOP_HEIGHT+SCREEN_WIDTH/10+16, SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT-SCREEN_WIDTH/10-16) ];
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH*1.6, SCREEN_HEIGHT-TOP_HEIGHT-SCREEN_WIDTH/10-16);
    //    _scroll.showsHorizontalScrollIndicator = NO;
    //    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.bounces = NO;
    _scroll.delegate = self;
    _scroll.backgroundColor = UIColorFromRGB(0x0F151B);
    //设置边框，形成表格
    _scroll.layer.borderWidth = .5f;
    _scroll.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.view addSubview:_scroll];
    _scroll.hidden = NO;
}
-(void)createAccScrollView{
    _accscroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TOP_HEIGHT+SCREEN_WIDTH/10+16, SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT-SCREEN_WIDTH/10-16) ];
    _accscroll.contentSize = CGSizeMake(SCREEN_WIDTH*1.5, SCREEN_HEIGHT-TOP_HEIGHT-SCREEN_WIDTH/10-16);
    //    _scroll.showsHorizontalScrollIndicator = NO;
    //    _scroll.showsVerticalScrollIndicator = NO;
    _accscroll.bounces = NO;
    _accscroll.delegate = self;
    _accscroll.backgroundColor = UIColorFromRGB(0x0F151B);
    //设置边框，形成表格
    _accscroll.layer.borderWidth = .5f;
    _accscroll.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.view addSubview:_accscroll];
    _accscroll.hidden = YES;
}
-(void)createTableTwoView{
    UITableView *tableTwoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH*1.6, SCREEN_WIDTH/8) style:UITableViewStyleGrouped];
    tableTwoView.scrollEnabled = NO;
    tableTwoView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableTwoView.dataSource = self;
    // 设置tableView的委托
    tableTwoView.delegate = self;
    tableTwoView.backgroundColor = UIColorFromRGB(0x0F151A);
    self.myAccTwoTableView = tableTwoView;
    [self.myAccTwoTableView registerClass:[HQZXTransactionTableCell class] forCellReuseIdentifier:@"CustomHeaderOne"];
    [_scroll addSubview:self.myAccTwoTableView];
}
-(void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.myAccTwoTableView.maxY , SCREEN_WIDTH*1.6, SCREEN_HEIGHT-TOP_HEIGHT - SCREEN_WIDTH/8) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableView.dataSource = self;
    // 设置tableView的委托
    tableView.delegate = self;
    tableView.backgroundColor = UIColorFromRGB(0x0F151A);
    self.myAccTableView = tableView;
    
    [self.myAccTableView registerClass:[HQZXDataTranTableCell class] forCellReuseIdentifier:@"CustomHeaderTwo"];
    [_scroll addSubview:self.myAccTableView];
}
-(void)createAccTableTwoView{
    UITableView *tableAccTwoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH*1.5, SCREEN_WIDTH/8) style:UITableViewStyleGrouped];
    tableAccTwoView.scrollEnabled = NO;
    tableAccTwoView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableAccTwoView.dataSource = self;
    // 设置tableView的委托
    tableAccTwoView.delegate = self;
    tableAccTwoView.backgroundColor = UIColorFromRGB(0x0F151A);
    self.myAccDataTwoTableView = tableAccTwoView;
    [self.myAccDataTwoTableView registerClass:[HQZXTransferAccountsTableCell class] forCellReuseIdentifier:@"CustomAccHeaderOne"];
    [_accscroll addSubview:self.myAccDataTwoTableView];
}
-(void)createAccTableView{
    UITableView *tableAccView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.myAccDataTwoTableView.maxY , SCREEN_WIDTH*1.5, SCREEN_HEIGHT-TOP_HEIGHT - SCREEN_WIDTH/8) style:UITableViewStyleGrouped];
    tableAccView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableAccView.dataSource = self;
    // 设置tableView的委托
    tableAccView.delegate = self;
    tableAccView.backgroundColor = UIColorFromRGB(0x0F151A);
    self.myAccDataTableView = tableAccView;
    
    [self.myAccDataTableView registerClass:[HQZXDataAccTableCell class] forCellReuseIdentifier:@"CustomAccHeaderTwo"];
    [_accscroll addSubview:self.myAccDataTableView];
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
    if([tableView isEqual:self.myAccTableView]){
        return 17;
    }else if([tableView isEqual:self.myAccTwoTableView]){
        return 1;
    }else if([tableView isEqual:self.myAccDataTableView]){
        return 17;
    }else if([tableView isEqual:self.myAccDataTwoTableView]){
        return 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=nil;
    NSUInteger section = [indexPath section];
    if([tableView isEqual:self.myAccTableView]){
        cell =[tableView dequeueReusableCellWithIdentifier:@"CustomHeaderTwo"];
    }else if([tableView isEqual:self.myAccTwoTableView]){
        cell =[tableView dequeueReusableCellWithIdentifier:@"CustomHeaderOne"];
    }else if([tableView isEqual:self.myAccDataTableView]){
        cell =[tableView dequeueReusableCellWithIdentifier:@"CustomAccHeaderTwo"];
    }else if([tableView isEqual:self.myAccDataTwoTableView]){
        cell =[tableView dequeueReusableCellWithIdentifier:@"CustomAccHeaderOne"];
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
- (void)buyGe:(UITapGestureRecognizer *)gesture {
    buyView.backgroundColor = UIColorFromRGB(0x192834);
    sellView.backgroundColor = UIColorFromRGB(0x0F151A);
    _scroll.hidden = NO;
    _accscroll.hidden = YES;
    
}
- (void)sellGe:(UITapGestureRecognizer *)gesture {
    buyView.backgroundColor = UIColorFromRGB(0x0F151A);
    sellView.backgroundColor = UIColorFromRGB(0x192834);
    _scroll.hidden = YES;
    _accscroll.hidden = NO;
}
@end
