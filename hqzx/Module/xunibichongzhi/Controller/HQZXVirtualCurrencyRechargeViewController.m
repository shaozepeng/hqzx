//
//  HQZXVirtualCurrencyRechargeViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/16.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXVirtualCurrencyRechargeViewController.h"

@implementation HQZXVirtualCurrencyRechargeViewController{
    UILabel *surplus;
    UILabel *surplusData;
    UILabel *frozen;
    UILabel *frozenData;
    UIView *walletView;
    UILabel *addressTitle;
    UILabel *address;
    NSMutableDictionary *dataDict;
    UILabel *pointValue;
    UILabel *huValue;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
    if([language isEqualToString:@"zh-Hans"]){
        self.title = [NSString stringWithFormat:@"%@%@",_sysName,LocatizedStirngForkey(@"CHONGZHI")];
    }else if([language isEqualToString:@"en"]){
        self.title = [NSString stringWithFormat:@"%@ %@",_sysName,LocatizedStirngForkey(@"CHONGZHI")];
    }
    
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    UIButton *zhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zhuBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/6, 44);
    [zhuBtn setTintColor:[UIColor whiteColor]];
    [zhuBtn setTitle:LocatizedStirngForkey(@"CHONGZHIJILU") forState:UIControlStateNormal];
    zhuBtn.titleLabel.font = [UIFont systemFontOfSize: LISHIFONT];
    [zhuBtn setTitleColor:UIColorFromRGB(0x439AFE) forState:UIControlStateNormal];
    [zhuBtn addTarget:self action:@selector(history) forControlEvents:UIControlEventTouchUpInside];
    
    [temporaryBarButtonItem setCustomView:zhuBtn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -12;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, temporaryBarButtonItem, nil];
    
    [self createTopView];
    [self reData];
    [self createWalletView];
}
-(void)reData{
    [[NetHttpClient sharedHTTPClient] request: @"/coins_paycheck.json" parameters: @{@"symbol": _sysId,@"auth_key":[HQZXUserModel sharedInstance].currentUser.auth_key} completion:^(id obj) {
        if (obj==nil) {
            [self.view makeToast: LocatizedStirngForkey(@"LIANJIEFUWUQISHIBAI") duration: 0.5 position: CSToastPositionCenter];
            return;
        }
        if (![@"0" isEqualToString: StrValueFromDictionary(obj, ApiKey_ErrorCode)]) {
//            [self.navigationController popViewControllerAnimated: YES];
            [self.view makeToast: [obj objectForKey:@"message"] duration: 0.5 position: CSToastPositionCenter];
            return;
        }
        dataDict = [[NSMutableDictionary alloc]initWithDictionary:obj];
        address.text = StrValueFromDictionary(dataDict, @"wallet");
        [address sizeToFit];
        surplusData.text = StrValueFromDictionary(dataDict, @"amount");
        NSString *forzen;
        if(StrValueFromDictionary(dataDict, @"frozen").length==0){
            forzen = @"0";
        }else{
            forzen = StrValueFromDictionary(dataDict, @"frozen");
        }
        frozenData.text = forzen;
        [surplusData sizeToFit];
        [frozenData sizeToFit];
        [address sizeToFit];
    }];
}
-(void)createTopView{
    surplus = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/20,TOP_HEIGHT+SCREEN_WIDTH/15, 1, 1)];
    surplus.text = [NSString stringWithFormat:@"%@ %@：",LocatizedStirngForkey(@"KESELL"),_sysName ];
    surplus.font = [UIFont systemFontOfSize: TRANSACTIONFONT];
    surplus.textColor = UIColorFromRGB(0xF4F4F4);
    [self.view addSubview: surplus];
    [surplus sizeToFit];
    
    surplusData = [[UILabel alloc] initWithFrame: CGRectMake(surplus.maxX, surplus.y, 1, 1)];
    surplusData.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
    surplusData.font = [UIFont systemFontOfSize: TRANSACTIONFONT];
    surplusData.textColor = UIColorFromRGB(0x3177E0);
    [self.view addSubview: surplusData];
    [surplusData sizeToFit];
    
    frozen = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/20, surplus.maxY+SCREEN_WIDTH/50, 1, 1)];
    frozen.text = [NSString stringWithFormat:@"%@ %@：",LocatizedStirngForkey(@"DONGJIE"),_sysName ];
    frozen.font = [UIFont systemFontOfSize: TRANSACTIONFONT];
    frozen.textColor = UIColorFromRGB(0xF4F4F4);
    [self.view addSubview: frozen];
    [frozen sizeToFit];
    
    frozenData = [[UILabel alloc] initWithFrame: CGRectMake(frozen.maxX, frozen.y, 1, 1)];
    frozenData.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
    frozenData.font = [UIFont systemFontOfSize: TRANSACTIONFONT];
    frozenData.textColor = UIColorFromRGB(0xFC2408);
    [self.view addSubview: frozenData];
    [frozenData sizeToFit];
}
-(void)createWalletView{
    walletView = [[UIView alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/20, frozen.maxY+SCREEN_WIDTH/20, SCREEN_WIDTH-SCREEN_WIDTH/10, SCREEN_WIDTH/5)];
    [walletView setBackgroundColor:UIColorFromRGB(0x1E232A)];
    [self.view addSubview:walletView];
    
    addressTitle = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/35, walletView.height/6, 1, 1)];
    addressTitle.text = LocatizedStirngForkey(@"QIANBAODIZHI");
    addressTitle.font = [UIFont systemFontOfSize: TRANSACTIONFTWO];
    addressTitle.textColor = [UIColor whiteColor];
    [walletView addSubview: addressTitle];
    [addressTitle sizeToFit];
    
    address = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/35, addressTitle.maxY+SCREEN_WIDTH/30, 1, 1)];
    address.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
    address.font = [UIFont systemFontOfSize: TRANSACTIONFONT];
    address.textColor = UIColorFromRGB(0x008000);
    [walletView addSubview: address];
    [address sizeToFit];
    address.userInteractionEnabled=YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureTop:)];
    
    [address addGestureRecognizer:labelTapGestureRecognizer];
    
//    NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
    
    CGRect pointValueRect = CGRectMake(SCREEN_WIDTH/24, walletView.maxY+SCREEN_WIDTH/10 ,1, 1);
    pointValue = [[UILabel alloc] initWithFrame:pointValueRect];
    pointValue.font = [UIFont systemFontOfSize:TRANFONTTWO];
    pointValue.textColor = [UIColor whiteColor];
    pointValue.text = LocatizedStirngForkey(@"CHONGZHISHUOMING");
    [pointValue sizeToFit];
    [self.view addSubview: pointValue];
//    float heighttwo = 0.0;
//    if([language isEqualToString:@"zh-Hans"]){
//        heighttwo = SCREEN_WIDTH/5;
//    }else if([language isEqualToString:@"en"]){
//        heighttwo = SCREEN_WIDTH/2.5;
//    }
    CGRect huValueRect = CGRectMake(SCREEN_WIDTH/24, pointValue.maxY+5 ,SCREEN_WIDTH-SCREEN_WIDTH/12, SCREEN_WIDTH/8);
    
    huValue = [[UILabel alloc] initWithFrame:huValueRect];
    huValue.font = [UIFont systemFontOfSize:WITHFONTONE];
    huValue.textColor = UIColorFromRGB(0x666B70);
    huValue.lineBreakMode = NSLineBreakByCharWrapping;
    huValue.numberOfLines = 0;//上面两行设置多行显示
    huValue.text = LocatizedStirngForkey(@"CHONGZHICHAIYAO");
    [self.view addSubview: huValue];
}
-(IBAction)panGestureTop:(UIGestureRecognizer *)longPress
{
    [self becomeFirstResponder];
    UIMenuItem * itemPase = [[UIMenuItem alloc] initWithTitle:LocatizedStirngForkey(@"FUZHI") action:@selector(copys)];
    UIMenuController * menuController = [UIMenuController sharedMenuController];
    [menuController setMenuItems: @[itemPase]];
    CGPoint location = [longPress locationInView:[longPress view]];
    CGRect menuLocation = CGRectMake(location.x, location.y, 0, 0);
    [menuController setTargetRect:menuLocation inView:[longPress view]];
    menuController.arrowDirection = UIMenuControllerArrowDown;
    [menuController setMenuVisible:YES animated:YES];
}
-(BOOL)canBecomeFirstResponder{
    
    return YES;
    
}
// 用于UIMenuController显示，缺一不可
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    if (action == @selector(copys))
        return YES;
    return NO;
}
-(void)copys{
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    [pab setString:StrValueFromDictionary(dataDict, @"wallet")];
    if (pab == nil) {
        [self.view makeToast: LocatizedStirngForkey(@"FUZHISHIBAI") duration: 0.5 position: CSToastPositionCenter];
        
    }else
    {
        [self.view makeToast: LocatizedStirngForkey(@"YIFUZHI") duration: 0.5 position: CSToastPositionCenter];
    }
}
-(void)history{
    HQZXVirtualRecordViewController *historyView=[[HQZXVirtualRecordViewController alloc]init];
    historyView.sysid = _sysId;
    [self.navigationController pushViewController:historyView animated:YES];
}
@end
