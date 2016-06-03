//
//  MyContactsViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/19.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "MyContactsViewController.h"

@implementation MyContactsViewController{
    UIBarButtonItem *temporaryBarButtonItem;
    BOOL isTouch;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = LocatizedStirngForkey(@"TWO");
    [self.view setBackgroundColor:UIColorFromRGB(0x0C1319)];
    
    isTouch =YES;
    temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 60, 44);
    [backBtn setTintColor:[UIColor whiteColor]];
    [backBtn setTitle:LocatizedStirngForkey(@"LANGUAGE") forState:UIControlStateNormal];
    [backBtn setTitleColor:UIColorFromRGB(0x439AFE) forState:UIControlStateNormal];
    UIImage *leftBtnImage = [UIImage imageNamed:@"icon_jt_bottom"];
    [backBtn setImage:leftBtnImage forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake((backBtn.frame.size.height-leftBtnImage.size.height)/2+2,50,(backBtn.frame.size.height-leftBtnImage.size.height)/2-2,2);
    //icon_tann_pressed incomingletter
    
    [backBtn addTarget:self action:@selector(createCover) forControlEvents:UIControlEventTouchUpInside];
    
    [temporaryBarButtonItem setCustomView:backBtn];
    self.tabBarController.navigationItem.rightBarButtonItem = temporaryBarButtonItem;
    
    [self createTabView];
    
    WEAK_SELF
    self.myTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself refData];
    }];
    self.myTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakself refData];
    }];
}
-(void)refData{
    [self.myTableView.header endRefreshing];
}
-(void)createTabView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableView.dataSource = self;
    // 设置tableView的委托
    tableView.delegate = self;
    tableView.backgroundColor = UIColorFromRGB(0x0C1319);
    [tableView registerClass:[XQZXJiaoYiDaTingTableCell class] forCellReuseIdentifier:@"wohuoCell"];
    self.myTableView = tableView;
    //[self.myTableView registerClass:[JHWodeCustomTableViewCell class] forCellReuseIdentifier:@"CustomHeader"];
    [self.view addSubview:self.myTableView];
}
// 设置块的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FIRSTSECIONHEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return FIRSTHEIGHTONE;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *huoCellIdentifier = @"wohuoCell";
    XQZXJiaoYiDaTingTableCell *cell = [tableView dequeueReusableCellWithIdentifier: huoCellIdentifier];
    cell.wocanyudehuopanxiangqingBlock = ^() {
        
    };
    //    id huobiao;
    
    //    if (huobiao) {
    cell.rowNum = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        cell.imageUrl = [huobiao objectForKey:@"bid_head_img"];
    cell.title1 = @"比特币(BTC)";
    cell.title3 = @"￥0.888";
    cell.title2 = @"+0.250%";
    cell.toubiaozhuangtai = @"1888.88万";
    cell.toubiaoshu = @"3999";
    cell.kaibiaohaisheng = @"￥0.666";
    cell.zhuangzaigang = @"￥0.999";
    //    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //push后cell选中效果消失,又动画
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TransactionFlowViewController *tranView=[[TransactionFlowViewController alloc] init];
    HQZXNeedLoginController *wodetran = [[HQZXNeedLoginController alloc] initWithController: tranView];
    [wodetran pushFrom: self inNavigationController: rootNav animated: YES];
    
//    TransactionFlowViewController *tranView = [[TransactionFlowViewController alloc]init];
//    [rootNav pushViewController: tranView animated: YES];
}

-(void)viewWillAppear:(BOOL)animated {
    self.tabBarController.title = LocatizedStirngForkey(@"TWO");
    self.tabBarController.navigationItem.backBarButtonItem = temporaryBarButtonItem;
}
- (void)createCover{
    for (UIView *subView in self.tabBarController.view.subviews) {
        if ([subView isKindOfClass:[HRCoverView class]]) {
            isTouch = NO;
        }else{
            isTouch = YES;
        }
    }
    if(isTouch){
        NSLog(@"创建了一个遮盖");
        //创建遮盖
        HRCoverView *cover = [[HRCoverView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        //跳转
        cover.jump = ^(UIViewController *vc){
            
            //        self.iconBtn.hidden = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        [self.tabBarController.view addSubview:cover];
        isTouch = NO;
    }else{
        for (UIView *subView in self.tabBarController.view.subviews) {
            if ([subView isKindOfClass:[HRCoverView class]]) {
                [UIView animateWithDuration:0.5 animations:^{
                    subView.transform = CGAffineTransformMakeScale(0.01, 0.01);
                    //缩小到指定的位置
                    subView.center = CGPointMake(SCREEN_WIDTH-20,64);
                    
                }completion:^(BOOL finished) {
                    [subView removeFromSuperview];
                    isTouch = YES;
                }];
            }
        }
    }
}


@end
