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
//    self.navigationController.navigationBar.frame = CGRectMake(0, 20, SCREEN_WIDTH, 20);
    
    _datas = [NSMutableArray array];
    isTouch =YES;
    [self createBarButton:LocatizedStirngForkey(@"LANGUAGE")];
    
    self.tabBarController.title = LocatizedStirngForkey(@"SUBMIT_BTN_TITLE");
    temporaryBarButtonItem.title = LocatizedStirngForkey(@"ONE");
    [self.view setBackgroundColor:UIColorFromRGB(0x0C1319)];
    
    [self initPicScroller];
    [self createTabView];
    [self refData];
    WEAK_SELF
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself refData];
    }];
//    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [weakself refData];
//    }];
    HQZXEmptyData(self.myTableView, hqzxEmptyManager, nil);
}
-(void)refData{
    NSString *autokey;
    if ([HQZXUserModel sharedInstance].isLogined) {
        autokey = [HQZXUserModel sharedInstance].currentUser.auth_key;
    }else{
        autokey = @"0";
    }
    [[NetHttpClient sharedHTTPClient] request: @"/index.json" parameters:@{@"auth_key":autokey} completion:^(id obj) {
        [self.myTableView.mj_header endRefreshing];
        if (obj==nil) {
            [self.view makeToast: @"查询服务器失败，请检查网络连接" duration: 0.5 position: CSToastPositionCenter];
            return;
        }
        if (![@"0" isEqualToString: StrValueFromDictionary(obj, ApiKey_ErrorCode)]) {
            [self.view makeToast: [obj objectForKey:@"message"] duration: 0.5 position: CSToastPositionCenter];
            return;
        }
        
        [_datas removeAllObjects];
        if ([obj objectForKey: @"items"] == nil) {
            
        } else {
            [_datas addObjectsFromArray: [obj objectForKey: @"items"]];
        }
        [self.myTableView reloadData];
    }];
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
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_HEIGHT+SCREEN_WIDTH * 0.35 , SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT-SCREEN_WIDTH * 0.35 - self.tabBarController.tabBar.height) style:UITableViewStyleGrouped];
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
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _datas.count;;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *huoCellIdentifier = @"wohuoCell";
    XQZXFirstPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: huoCellIdentifier];
    cell.wocanyudehuopanxiangqingBlock = ^() {

    };
    id btbData;
    if(_datas.count>0){
        btbData = [_datas objectAtIndex:indexPath.section];
    }
    
    if(btbData){
        cell.rowNum = indexPath.section;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageUrl = StrValueFromDictionary(btbData, @"img");
        NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
        if([language isEqualToString:@"zh-Hans"]){
            cell.title1 = StrValueFromDictionary(btbData, @"name");
        }else if([language isEqualToString:@"en"]){
            cell.title1 = StrValueFromDictionary(btbData, @"ename");
        }
        NSString *price = StrValueFromDictionary(btbData, @"price");
        NSString *price2;
        if(price.length>0){
            price2 = price;
        }else{
            price2 = @"0.0000";
        }
        cell.title3 = [NSString stringWithFormat:@"￥%@",price2];
        //        [StrValueFromDictionary(btbData, @"price") intValue]*100
        
        cell.title2 = StrValueFromDictionary(btbData, @"ratio");
        NSString *turnover = StrValueFromDictionary(btbData, @"turnover");
        NSString *turnover2;
        if([turnover floatValue]>0){
            turnover2 = turnover;
        }else{
            turnover2 = @"0.0000";
        }
        
        cell.toubiaozhuangtai = turnover2;
        NSString *min_price = StrValueFromDictionary(btbData, @"min_price");
        NSString *min_price2;
        if([min_price floatValue]>0){
            min_price2 = min_price;
        }else{
            min_price2 = @"0.0000";
        }
        cell.toubiaoshu = [NSString stringWithFormat:@"￥%@",min_price2];
        cell.kaibiaohaisheng = StrValueFromDictionary(btbData, @"volume");
        NSString *max_price = StrValueFromDictionary(btbData, @"max_price");
        NSString *max_price2;
        if([max_price floatValue]>0){
            max_price2 = max_price;
        }else{
            max_price2 = @"0.0000";
        }
        cell.zhuangzaigang = [NSString stringWithFormat:@"￥%@",max_price2];
    }

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //push后cell选中效果消失,又动画
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id btbData;
    if(_datas.count>0){
        btbData = [_datas objectAtIndex:indexPath.section];
    }
    
    TransactionFlowViewController *tranView=[[TransactionFlowViewController alloc] init];
    tranView.symbol = StrValueFromDictionary(btbData, @"symbol");
    HQZXNeedLoginController *wodetran = [[HQZXNeedLoginController alloc] initWithController: tranView];
    [wodetran pushFrom: self inNavigationController: rootNav animated: YES];
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
