//
//  MyRecentViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/19.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "MyRecentViewController.h"

@implementation MyRecentViewController{
    UIBarButtonItem *temporaryBarButtonItem;
    SDCycleScrollView *adView;
    BOOL isTouch;
    UIButton *backBtn;
    HQZXEmptyManager *hqzxEmptyManager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[[UIView alloc] init]];
    
    isTouch =YES;
    [self createBarButton:LocatizedStirngForkey(@"LANGUAGE")];
    
    self.tabBarController.title = LocatizedStirngForkey(@"SUBMIT_BTN_TITLE");
    temporaryBarButtonItem.title = LocatizedStirngForkey(@"ONE");
    [self.view setBackgroundColor:UIColorFromRGB(0x0C1319)];
    
    [self initPicScroller];
    [self createTabView];
    
    WEAK_SELF
    self.myTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself refData];
    }];
    self.myTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakself refData];
    }];
    HQZXEmptyData(self.myTableView, hqzxEmptyManager, nil);
}
-(void)refData{
    [self.myTableView.header endRefreshing];
}
-(void)createBarButton:(NSString *)barTitle{
    temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 60, 44);
    [backBtn setTintColor:[UIColor whiteColor]];
    [backBtn setTitle:barTitle forState:UIControlStateNormal];
    [backBtn setTitleColor:UIColorFromRGB(0x439AFE) forState:UIControlStateNormal];
    UIImage *leftBtnImage = [UIImage imageNamed:@"icon_jt_bottom"];
    [backBtn setImage:leftBtnImage forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake((backBtn.frame.size.height-leftBtnImage.size.height)/2+2,50,(backBtn.frame.size.height-leftBtnImage.size.height)/2-2,2);
    
    [backBtn addTarget:self action:@selector(createCover) forControlEvents:UIControlEventTouchUpInside];
    
    [temporaryBarButtonItem setCustomView:backBtn];
    self.tabBarController.navigationItem.rightBarButtonItem = temporaryBarButtonItem;
}
-(void)createTabView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_HEIGHT+SCREEN_WIDTH * 0.35 , SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT-SCREEN_WIDTH * 0.35) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableView.dataSource = self;
    // 设置tableView的委托
    tableView.delegate = self;
    tableView.backgroundColor = UIColorFromRGB(0x0C1319);
    [tableView registerClass:[XQZXFirstPageTableViewCell class] forCellReuseIdentifier:@"wohuoCell"];
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
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *huoCellIdentifier = @"wohuoCell";
    XQZXFirstPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: huoCellIdentifier];
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
        cover.changeButBlock = ^(NSInteger NUM) {
        };
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
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.title = LocatizedStirngForkey(@"SUBMIT_BTN_TITLE");
    self.tabBarController.navigationItem.backBarButtonItem = temporaryBarButtonItem;
}
- (void)initPicScroller {
    // 情景一：采用本地图片实现
    NSArray *images = @[[UIImage imageNamed:@"img_banner"],
                        [UIImage imageNamed:@"img_banner"],
                        [UIImage imageNamed:@"img_banner"]
                        
                        ];
    
    // 本地加载 --- 创建不带标题的图片轮播器
    adView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, TOP_HEIGHT, SCREEN_WIDTH, SCREEN_WIDTH * 0.35) imagesGroup:images];
    adView.delegate = self;
    adView.infiniteLoop = YES;
    adView.showPageControl=YES;
    adView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.view addSubview:adView];
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
}
@end
