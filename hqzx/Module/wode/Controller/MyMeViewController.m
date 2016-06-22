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
    NSDictionary *dataDict;
    NSDictionary *dataDictTwo;
    NSString *realName;
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
    [self refData];
    WEAK_SELF
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself refData];
    }];
}
-(void)refData{
    [[NetHttpClient sharedHTTPClient] request:@"/account_detail.json" parameters: @{@"auth_key":[HQZXUserModel sharedInstance].currentUser.auth_key} completion:^(id obj) {
        [self.myTableView.mj_header endRefreshing];
        NSString *errorCode = StrValueFromDictionary(obj, ApiKey_ErrorCode);
        if ([@"0" isEqualToString: errorCode]) {
            dataDict = [[NSDictionary alloc]init];
            dataDictTwo = [[NSDictionary alloc]init];
            dataDict = [obj objectForKey:@"account_detail"];
            dataDictTwo = [obj objectForKey:@"identity_info"];
            realName = StrValueFromDictionary(dataDictTwo, @"name");
            [self.myTableView reloadData];
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated {
    self.tabBarController.title = LocatizedStirngForkey(@"THREE");
    self.tabBarController.navigationItem.backBarButtonItem = temporaryBarButtonItem;
}
-(void)createTabView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_HEIGHT+8, SCREEN_WIDTH, SCREEN_HEIGHT - TOP_HEIGHT - self.tabBarController.tabBar.height-8) style:UITableViewStyleGrouped];
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

    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refTable];
    }];
}
-(void)refTable{
    [self.myTableView.mj_header endRefreshing];
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
//    else if(section==6){
//        return 1;
//    }
    else if(section==6){
        return 1;
    }
    else if(section==7){
        return 1;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
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
 
        cellwode.title1 = StrValueFromDictionary(dataDict, @"account");
        cellwode.rowNum = indexPath.row;
        cellwode.imageUrl = @"customerservice";
        cellwode.title2 = realName;
        cellwode.state = [NSString stringWithFormat:@"UID：%@",StrValueFromDictionary(dataDict, @"uid")];
    }
    [cell.contentView removeSubviews];
    cell.detailTextLabel.text=@"";
    if(indexPath.section==1){
        if(row==0){
            cell.textLabel.text=LocatizedStirngForkey(@"ZONGZICHAN");
            cell.detailTextLabel.text = StrValueFromDictionary(dataDict, @"account_balance");
            cell.detailTextLabel.textColor = [UIColor redColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:WOCONTDETAILFONT];
            cell.imageView.image=[UIImage imageNamed:@"icon_price"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
//            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    if(indexPath.section==2){
        if(row==0){
            cell.textLabel.text=LocatizedStirngForkey(@"RENMINBICHONGZHI");
            cell.imageView.image=[UIImage imageNamed:@"icon_monIn"];
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
            cell.imageView.image=[UIImage imageNamed:@"icon_monOut"];
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
            cell.imageView.image=[UIImage imageNamed:@"icon_biIn"];
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
            cell.imageView.image=[UIImage imageNamed:@"icon_biOut"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    if(indexPath.section==3){
        if(row==0){
            cell.textLabel.text=LocatizedStirngForkey(@"WEITUOGUANLI");
            cell.imageView.image=[UIImage imageNamed:@"icon_weituo"];
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
            cell.imageView.image=[UIImage imageNamed:@"icon_bus"];
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
            cell.imageView.image=[UIImage imageNamed:@"icon_turnIn"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if(row==1){
            cell.textLabel.text=LocatizedStirngForkey(@"WOYAOFUKUAN");
            cell.imageView.image=[UIImage imageNamed:@"icon_turnOut"];
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
            cell.imageView.image=[UIImage imageNamed:@"icon_sfzNum"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if(row==1){
            cell.textLabel.text=LocatizedStirngForkey(@"XIUGAIDENGLUMIMA");
            cell.imageView.image=[UIImage imageNamed:@"icon_mima"];
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
            cell.imageView.image=[UIImage imageNamed:@"icon_mima"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
//    if(indexPath.section==6){
//        if(row==0){
//            cell.textLabel.text=LocatizedStirngForkey(@"XIAOXIZHONGXIN");
//            cell.imageView.image=[UIImage imageNamed:@"icon_tishi"];
//            cell.textLabel.textColor = [UIColor whiteColor];
//            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
//            cell.backgroundColor = UIColorFromRGB(0x0E151B);
//            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//        }
//    }
    if(indexPath.section==6){
        if(row==0){
            cell.textLabel.text=LocatizedStirngForkey(@"GUANYUWOMEN");
            cell.imageView.image=[UIImage imageNamed:@"icon_about"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:WOCONTROLLERFONT];
            cell.backgroundColor = UIColorFromRGB(0x0E151B);
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    if(indexPath.section==7){
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
//            UINavigationController *login = [HQZXLoginViewController getLoginController];
//            [[rootNav.viewControllers objectAtIndex: 0] presentViewController: login animated: YES completion:nil];
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
            HQZXRMBCongZhiViewController *chongzhi=[[HQZXRMBCongZhiViewController alloc]init];
            //            LivePlayPushs *wodehuobiao=[[LivePlayPushs alloc]init];
            [rootNav pushViewController:chongzhi animated:YES];
        } else if (indexPath.row == 1) {
            HQZXRMBWithdrawalsViewController *rmbtixian = [[HQZXRMBWithdrawalsViewController alloc] init];
            [rootNav pushViewController:rmbtixian animated: YES];
        } else if(indexPath.row==2){
            HQZXChooseVirtualViewController *xnchong=[[HQZXChooseVirtualViewController alloc]init];
            [rootNav pushViewController:xnchong animated:YES];
        } else if(indexPath.row==3){
            HQZXChooseCaseWithVewController *tixina=[[HQZXChooseCaseWithVewController alloc]init];
            [rootNav pushViewController:tixina animated:YES];
        }
    }
    if(indexPath.section==3){
        if(indexPath.row==0){
            HQZXChooseCurViewController *weituo=[[HQZXChooseCurViewController alloc]init];
            [rootNav pushViewController:weituo animated:YES];
        }
        if(indexPath.row==1){
            HQZXChooseCurrencyViewController *liushui=[[HQZXChooseCurrencyViewController alloc]init];
            [rootNav pushViewController:liushui animated:YES];
        }
    }
    if(indexPath.section==4){
        if(indexPath.row==0){
            HQZXChooseReceViewController *shoukuan=[[HQZXChooseReceViewController alloc]init];
            [rootNav pushViewController:shoukuan animated:YES];
        }
        if(indexPath.row==1){
            SYQrCodeScanne *VC = [[SYQrCodeScanne alloc]init];
            VC.scanneScusseBlock = ^(SYCodeType codeType, NSString *url){
                NSData *jsonData = [url dataUsingEncoding:NSUTF8StringEncoding];
                NSError *err;
                NSDictionary *jsondic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                          options:NSJSONReadingMutableContainers
                                                            error:&err];
                if (SYCodeTypeUnknow == codeType) {
                    [self.view makeToast:LocatizedStirngForkey(@"ERWEIMAWUFASHIBIE") duration:1 position:CSToastPositionCenter];
                }else if (SYCodeTypeString == codeType) {
                    HQZXPaymentViewController *fukuan=[[HQZXPaymentViewController alloc]init];
                    fukuan.sysId = StrValueFromDictionary(jsondic, @"sysid");
                    fukuan.sysName = StrValueFromDictionary(jsondic, @"sysname");
                    fukuan.userId = StrValueFromDictionary(jsondic, @"userid");
                    [rootNav pushViewController:fukuan animated:YES];
                }else{
                    
                }
            };
            [VC scanning];
//            HQZXPaymentViewController *fukuan=[[HQZXPaymentViewController alloc]init];
//            [rootNav pushViewController:fukuan animated:YES];
            
        }
    }
    if(indexPath.section==5){
        if(indexPath.row==0){
            HQZXRealNameAuthenticationViewController *wocanyudetoubiao=[[HQZXRealNameAuthenticationViewController alloc] init];
            wocanyudetoubiao.username = realName;
//            dataDictTwo
            wocanyudetoubiao.cardId = StrValueFromDictionary(dataDictTwo, @"identityno");
            NSString *type = StrValueFromDictionary(dataDictTwo, @"identitytype");
            NSString *typename;
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString *path=[paths objectAtIndex:0];
            NSString *filename=[path stringByAppendingPathComponent:countryKey];
            NSDictionary* dicPorts = [NSDictionary dictionaryWithContentsOfFile:filename];
            if(dicPorts.count>0){
                NSDictionary *allDict =[dicPorts objectForKey:@"config"];
                NSArray *cards = [allDict objectForKey:@"card_type_list"];
                for(NSDictionary *cardDic in cards){
                    if([type isEqualToString:StrValueFromDictionary(cardDic, @"id")]){
                        NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
                        if([language isEqualToString:@"zh-Hans"]){
                            typename = StrValueFromDictionary(cardDic, @"name");
                        }else if([language isEqualToString:@"en"]){
                            typename = StrValueFromDictionary(cardDic, @"ename");
                        }
                        
                    }
                }
            }
            wocanyudetoubiao.cardTyoe = typename;
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
//    if(indexPath.section==6){
//        if (indexPath.row == 0) {
//            JHTWoDeXiaoXiViewController *xiaoxi = [[JHTWoDeXiaoXiViewController alloc] init];
//            [self.navigationController pushViewController:xiaoxi animated: YES];
//        }
//    }
    if(indexPath.section==6){
        if (indexPath.row == 0) {
            HQZXAboutMeViewController *women = [[HQZXAboutMeViewController alloc] init];
            [rootNav pushViewController:women animated: YES];
        }
    }
    if(indexPath.section==7){
       if(indexPath.row==0){
           UIAlertController *alert = [UIAlertController alertControllerWithTitle:LocatizedStirngForkey(@"TISHI") message:LocatizedStirngForkey(@"NINYAOTUICHUMA") preferredStyle: UIAlertControllerStyleAlert];
           
           [alert addAction:[UIAlertAction actionWithTitle:LocatizedStirngForkey(@"QUXIAO") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               //点击按钮的响应事件；
           }]];
           [alert addAction:[UIAlertAction actionWithTitle:LocatizedStirngForkey(@"QUEDING") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               //点击按钮的响应事件；
               if ([HQZXUserModel sharedInstance].isLogined) {
                   [[HQZXUserModel sharedInstance] logout];
                   HQZXLoginViewController *vc = [[HQZXLoginViewController alloc] init];
//                   WEAK_SELF
                   vc.cancellationBlock = ^{
                       NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
                       [parameter setValue:@"2" forKey:@"selectPlu"];
                       [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLanguage"
                                                                           object:self
                                                                         userInfo:parameter];
                   };
                   UINavigationController *textNav = [[UINavigationController alloc] initWithRootViewController: vc];
                   [CommonUtils setNavigationControllerStyle: textNav];
                   [self presentViewController: textNav animated: YES completion:nil];
               }
               
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
