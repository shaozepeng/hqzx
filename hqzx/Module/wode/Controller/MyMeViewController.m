//
//  MyMeViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/19.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "MyMeViewController.h"

@implementation MyMeViewController{
    UIBarButtonItem *temporaryBarButtonItem;
    BOOL isTouch;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    
    temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = LocatizedStirngForkey(@"THREE");
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
    
    
    //    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self createTabView];
}
-(void)viewWillAppear:(BOOL)animated {
    self.tabBarController.title = LocatizedStirngForkey(@"THREE");
    self.tabBarController.navigationItem.backBarButtonItem = temporaryBarButtonItem;
}
-(void)createTabView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_HEIGHT+8, SCREEN_WIDTH, SCREEN_HEIGHT - TOP_HEIGHT - self.tabBarController.tabBar.height-28) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
//    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    // 设置tableView的数据源
    tableView.dataSource = self;
    // 设置tableView的委托
    tableView.delegate = self;
    tableView.backgroundColor = UIColorFromRGB(0x0C1319);
    // 设置tableView的背景图
    //tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];
    self.myTableView = tableView;
    [self.myTableView registerClass:[XQZXWodeTableViewCell class] forCellReuseIdentifier:@"CustomHeader"];
    //[self.myTableView deselectRowAtIndexPath:[self.myTableView indexPathForSelectedRow] animated:YES];
    [self.view addSubview:self.myTableView];
//    [self.myTableView setSeparatorColor:[UIColor clearColor]];

    self.myTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refTable];
    }];
}
-(void)refTable{
    [self.myTableView.header endRefreshing];
}
// 设置块的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0){
        return CGFLOAT_MIN;
    }
    return 8.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 7) {
        return 20;
    }
    return CGFLOAT_MIN;
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        return WOCONTROLLERPROPO;
    }
    return WOCONTROLLEEIGHT;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }
    else if(section==1){
        return 1;
    }
    else if(section==2){
        return 4;
    }
    else if(section==3){
        return 2;
    }
    else if(section==4){
        return 2;
    }
    else if(section==5){
        return 3;
    }
    else if(section==6){
        return 1;
    }
    else if(section==7){
        return 1;
    }
    else if(section==8){
        return 1;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView setSeparatorColor:[UIColor clearColor]];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell=nil;
    if (indexPath.section!=0) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell==nil){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
    } else {
        cell =[tableView dequeueReusableCellWithIdentifier:@"CustomHeader"];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSUInteger row=[indexPath row];
    if(indexPath.section==0){
        XQZXWodeTableViewCell *cellwode = (XQZXWodeTableViewCell*) cell;
 
        cellwode.title1 = @"13213414232";
        cellwode.rowNum = indexPath.row;
        cellwode.imageUrl = @"customerservice";
        cellwode.title2 = @"李奎";
        cellwode.state = @"UID：173833";
    }
    [cell.contentView removeSubviews];
    cell.detailTextLabel.text=@"";
    if(indexPath.section==1){
        if(row==0){
            cell.textLabel.text=LocatizedStirngForkey(@"ZONGZICHAN");
            cell.detailTextLabel.text = @"88888.88";
            cell.detailTextLabel.textColor = [UIColor redColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:WOCONTDETAILFONT];
            cell.imageView.image=[UIImage imageNamed:@"icon_price"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    if(indexPath.section==2){
        if(row==0){
            cell.textLabel.text=LocatizedStirngForkey(@"RENMINBICHONGZHI");
            cell.imageView.image=[UIImage imageNamed:@"icon_lock"];
            UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/9, WOCONTROLLEEIGHT-1 , SCREEN_WIDTH-SCREEN_WIDTH/9, 1)];
            separator.backgroundColor = UIColorFromRGB(0x1B2026);
            [cell.contentView addSubview:separator];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if(row==1){
            cell.textLabel.text=LocatizedStirngForkey(@"RENMINBITIXIAN");
            cell.imageView.image=[UIImage imageNamed:@"icon_lock"];
            UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/9, WOCONTROLLEEIGHT-1 , SCREEN_WIDTH-SCREEN_WIDTH/9, 1)];
            separator.backgroundColor = UIColorFromRGB(0x1B2026);
            [cell.contentView addSubview:separator];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if(row==2){
            cell.textLabel.text=LocatizedStirngForkey(@"XUNIBICHONGZHI");
            cell.imageView.image=[UIImage imageNamed:@"icon_lock"];
            UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/9, WOCONTROLLEEIGHT-1 , SCREEN_WIDTH-SCREEN_WIDTH/9, 1)];
            separator.backgroundColor = UIColorFromRGB(0x1B2026);
            [cell.contentView addSubview:separator];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if(row==3){
            cell.textLabel.text=LocatizedStirngForkey(@"XUNIBITIXIAN");
            cell.imageView.image=[UIImage imageNamed:@"icon_lock"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    if(indexPath.section==3){
        if(row==0){
            cell.textLabel.text=LocatizedStirngForkey(@"WEITUOGUANLI");
            cell.imageView.image=[UIImage imageNamed:@"icon_phone"];
            UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/9, WOCONTROLLEEIGHT-1 , SCREEN_WIDTH-SCREEN_WIDTH/9, 1)];
            separator.backgroundColor = UIColorFromRGB(0x1B2026);
            [cell.contentView addSubview:separator];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if(row==1){
            cell.textLabel.text=LocatizedStirngForkey(@"JIAOYILIUSHUI");
            cell.imageView.image=[UIImage imageNamed:@"icon_phone"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    if(indexPath.section==4){
        if(row==0){
            cell.textLabel.text=LocatizedStirngForkey(@"WOYAOSHOUKUAN");
            UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/9, WOCONTROLLEEIGHT-1 , SCREEN_WIDTH-SCREEN_WIDTH/9, 1)];
            separator.backgroundColor = UIColorFromRGB(0x1B2026);
            [cell.contentView addSubview:separator];
            cell.imageView.image=[UIImage imageNamed:@"icon_lock"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if(row==1){
            cell.textLabel.text=LocatizedStirngForkey(@"WOYAOFUKUAN");
            cell.imageView.image=[UIImage imageNamed:@"icon_lock"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    if(indexPath.section==5){
        if(row==0){
            cell.textLabel.text=LocatizedStirngForkey(@"SHIMINGRENZHENG");
            UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/9, WOCONTROLLEEIGHT-1 , SCREEN_WIDTH-SCREEN_WIDTH/9, 1)];
            separator.backgroundColor = UIColorFromRGB(0x1B2026);
            [cell.contentView addSubview:separator];
            cell.detailTextLabel.text = LocatizedStirngForkey(@"YIRENZHENG");
            cell.detailTextLabel.textColor = [UIColor greenColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:WOCONTDETAILFONT];
            cell.imageView.image=[UIImage imageNamed:@"icon_lock"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if(row==1){
            cell.textLabel.text=LocatizedStirngForkey(@"XIUGAIDENGLUMIMA");
            cell.imageView.image=[UIImage imageNamed:@"icon_phone"];
            UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/9, WOCONTROLLEEIGHT-1 , SCREEN_WIDTH-SCREEN_WIDTH/9, 1)];
            separator.backgroundColor = UIColorFromRGB(0x1B2026);
            [cell.contentView addSubview:separator];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if(row==2){
            cell.textLabel.text=LocatizedStirngForkey(@"XIUGAIJIAOYIMIMA");
            cell.imageView.image=[UIImage imageNamed:@"icon_phone"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    if(indexPath.section==6){
        if(row==0){
            cell.textLabel.text=LocatizedStirngForkey(@"XIAOXIZHONGXIN");
            cell.imageView.image=[UIImage imageNamed:@"icon_lock"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    if(indexPath.section==7){
        if(row==0){
            cell.textLabel.text=LocatizedStirngForkey(@"GUANYUWOMEN");
            cell.imageView.image=[UIImage imageNamed:@"icon_phone"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    if(indexPath.section==8){
        if(row==0){
            cell.textLabel.text=@"";
            cell.imageView.image=[UIImage imageNamed:@""];
            
            UILabel *signOut=[[UILabel alloc] init];
            signOut.text=LocatizedStirngForkey(@"ANQUANZHONGXIN");
            signOut.textAlignment = NSTextAlignmentRight;
            signOut.textColor=UIColorFromRGB(0x4B5156);
            signOut.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            [signOut sizeToFit];
            [signOut setX:(SCREEN_WIDTH-signOut.width)/2];
            [signOut setY:(40-signOut.height)/2];
            [cell.contentView addSubview: signOut];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0){
        if(indexPath.row==0){
            
        }
    }
    if(indexPath.section==1){
        if(indexPath.row==0){
            UINavigationController *login = [HQZXLoginViewController getLoginController];
            [[rootNav.viewControllers objectAtIndex: 0] presentViewController: login animated: YES completion:nil];
//            WEAK_SELF
//            UINavigationController *login = [HQZXLoginViewController getLoginController];
//            [rootNav presentViewController: login animated: YES completion:^{
//                HQZXLoginViewController *loginView = [login.viewControllers objectAtIndex: 0];
//                if (weakself.loginSuccess != nil) {
//                    loginView.successBlock = ^() {
//                        weakself.loginSuccess();
//                    };
//                }
//            }];
//            HQZXLoginViewController *wodechuanbiao = [[HQZXLoginViewController alloc] init];
//            [self.navigationController pushViewController:wodechuanbiao animated: YES];
        }
    }
    if(indexPath.section==2){
        if(indexPath.row==0){
//            JHTWodeHuoBiaoViewController *wodehuobiao=[[JHTWodeHuoBiaoViewController alloc]init];
//            //            LivePlayPushs *wodehuobiao=[[LivePlayPushs alloc]init];
//            [self.navigationController pushViewController:wodehuobiao animated:YES];
        } else if (indexPath.row == 1) {
//            JHTWodeChuanBiaoViewController *wodechuanbiao = [[JHTWodeChuanBiaoViewController alloc] init];
//            [self.navigationController pushViewController:wodechuanbiao animated: YES];
        } else if(indexPath.row==2){
//            JHTWoDeChuanBoViewController *wodechuanbo=[[JHTWoDeChuanBoViewController alloc]init];
//            [self.navigationController pushViewController:wodechuanbo animated:YES];
        } else if(indexPath.row==3){
//            JHTChuanboDiaoduViewController *chuanboDiaodu=[[JHTChuanboDiaoduViewController alloc]init];
//            [self.navigationController pushViewController:chuanboDiaodu animated:YES];
        }
    }
    if(indexPath.section==3){
        if(indexPath.row==0){
//            JHTWodeDingdanWrapperViewController *wodedingdan=[[JHTWodeDingdanWrapperViewController alloc]init];
//            [self.navigationController pushViewController:wodedingdan animated:YES];
        }
        if(indexPath.row==1){
//            JHTWoDeGuanZhuDingDanViewController *guanlidingdan=[[JHTWoDeGuanZhuDingDanViewController alloc]init];
//            [self.navigationController pushViewController:guanlidingdan animated:YES];
        }
    }
    if(indexPath.section==4){
        if(indexPath.row==0){
            
        }
        if(indexPath.row==1){
            
        }
    }
    if(indexPath.section==5){
        if(indexPath.row==0){
            HQZXModifyLoginViewController *wocanyudetoubiao=[[HQZXModifyLoginViewController alloc] init];
            [rootNav pushViewController:wocanyudetoubiao animated:YES];
            
        }
        if(indexPath.row==1){
            HQZXModifyLoginViewController *wocanyudetoubiao=[[HQZXModifyLoginViewController alloc] init];
            [rootNav pushViewController:wocanyudetoubiao animated:YES];
            
        }
        if(indexPath.row==2){
            HQZXModifyTransactionViewController *wodexinyongpingjia=[[HQZXModifyTransactionViewController alloc] init];
            [rootNav pushViewController:wodexinyongpingjia animated:YES];
        }
    }
    if(indexPath.section==6){
        if (indexPath.row == 0) {
//            JHTWoDeXiaoXiViewController *xiaoxi = [[JHTWoDeXiaoXiViewController alloc] init];
//            [self.navigationController pushViewController:xiaoxi animated: YES];
        }
    }
    if(indexPath.section==7){
        if (indexPath.row == 0) {
            //            JHTWoDeXiaoXiViewController *xiaoxi = [[JHTWoDeXiaoXiViewController alloc] init];
            //            [self.navigationController pushViewController:xiaoxi animated: YES];
        }
    }
    if(indexPath.section==8){
       if(indexPath.row==0){
           UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退出吗?" preferredStyle: UIAlertControllerStyleAlert];
           
           [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               //点击按钮的响应事件；
           }]];
           [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               //点击按钮的响应事件；
               HQZXLoginViewController *vc = [[HQZXLoginViewController alloc] init];
               UINavigationController *textNav = [[UINavigationController alloc] initWithRootViewController: vc];
               [CommonUtils setNavigationControllerStyle: textNav];
               [self presentViewController: textNav animated: YES completion:nil];
           }]];
           
           //弹出提示框；
           [[rootNav.viewControllers objectAtIndex: 0] presentViewController:alert animated:true completion:nil];
        }
    }
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
