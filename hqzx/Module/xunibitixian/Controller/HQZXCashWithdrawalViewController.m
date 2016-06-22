//
//  HQZXCashWithdrawalViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/16.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXCashWithdrawalViewController.h"

@implementation HQZXCashWithdrawalViewController{
    UILabel *surplus;
    UILabel *surplusData;
    UILabel *frozen;
    UILabel *frozenData;
    UIView *walletView;
    UILabel *addressTitle;
    UILabel *address;
    NSMutableDictionary *dataDict;
    UIImageView *iconTwoBankId;
    UITextField *bankTwoId;
    UIImageView *cmIconTwoBankId;
    UITextField *cmBankTwoId;
    UIImageView *iconTwoName;
    UITextField *nameTwoText;
    UIButton *drawButton;
    UILabel *pointValue;
    UILabel *huValue;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
    if([language isEqualToString:@"zh-Hans"]){
        self.title = [NSString stringWithFormat:@"%@%@",_sysName,LocatizedStirngForkey(@"TIXIAN")];
    }else if([language isEqualToString:@"en"]){
        self.title = [NSString stringWithFormat:@"%@ %@",_sysName,LocatizedStirngForkey(@"TIXIAN")];
    }
    
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    UIButton *zhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zhuBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/6, 44);
    [zhuBtn setTintColor:[UIColor whiteColor]];
    [zhuBtn setTitle:LocatizedStirngForkey(@"TIXIANJILU") forState:UIControlStateNormal];
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
            [self.view makeToast: [obj objectForKey:@"message"] duration: 0.5 position: CSToastPositionCenter];
            return;
        }
        dataDict = [[NSMutableDictionary alloc]initWithDictionary:obj];
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
    walletView = [[UIView alloc] initWithFrame: CGRectMake(0, frozen.maxY + SCREEN_WIDTH/20, SCREEN_WIDTH, SCREEN_HEIGHT*0.195)];
    [walletView setBackgroundColor:UIColorFromRGB(0x293035)];
    [self.view addSubview: walletView];
    
    float lineHeight = (walletView.height-2)/3;
    UIView *line = [[UIView alloc] initWithFrame: CGRectMake(0, lineHeight, SCREEN_WIDTH, 1)];
    UIView *line1 = [[UIView alloc] initWithFrame: CGRectMake(0, lineHeight*2+1, SCREEN_WIDTH, 1)];
    line.backgroundColor = UIColorFromRGB(0x0C1319);
    line1.backgroundColor = UIColorFromRGB(0x0C1319);
    [walletView addSubview: line];
    [walletView addSubview: line1];
    
    //钱包地址
    iconTwoBankId = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_price_dz"]];
    [walletView addSubview: iconTwoBankId];
    [iconTwoBankId setY: (lineHeight - iconTwoBankId.height) / 2.0];
    iconTwoBankId.x = SCREEN_WIDTH/30;
    
    bankTwoId = [[UITextField alloc] initWithFrame:CGRectMake(iconTwoBankId.maxX+SCREEN_WIDTH/30 , 0, SCREEN_WIDTH- iconTwoBankId.maxX - SCREEN_WIDTH/15, lineHeight)];
    [walletView addSubview: bankTwoId];
    bankTwoId.textColor = UIColorFromRGB(0x767D85);
    bankTwoId.font = [UIFont systemFontOfSize:WITHFONTTWO];
    bankTwoId.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    NSMutableParagraphStyle *style = [bankTwoId.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = bankTwoId.font.lineHeight - (bankTwoId.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    bankTwoId.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"QIANBAODIZHI")
                                                                      attributes:@{
                                                                                   NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                   NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                   NSParagraphStyleAttributeName : style
                                                                                   }];
    
    //转出数量
    cmIconTwoBankId = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_bi_num"]];
    [walletView addSubview: cmIconTwoBankId];
    [cmIconTwoBankId setY: (lineHeight - cmIconTwoBankId.height) / 2.0 +line.maxY];
    cmIconTwoBankId.x = SCREEN_WIDTH/30;
    
    cmBankTwoId = [[UITextField alloc] initWithFrame:CGRectMake(iconTwoBankId.maxX+SCREEN_WIDTH/30 , line.maxY, SCREEN_WIDTH- cmIconTwoBankId.maxX - SCREEN_WIDTH/15, lineHeight)];
    [walletView addSubview: cmBankTwoId];
    cmBankTwoId.textColor = UIColorFromRGB(0x767D85);
    cmBankTwoId.font = [UIFont systemFontOfSize:WITHFONTTWO];
    cmBankTwoId.clearButtonMode = UITextFieldViewModeWhileEditing;
    cmBankTwoId.keyboardType = UIKeyboardTypeDecimalPad;
    
    NSMutableParagraphStyle *style1 = [cmBankTwoId.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style1.minimumLineHeight = cmBankTwoId.font.lineHeight - (cmBankTwoId.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    cmBankTwoId.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"ZHUANCHUSHULIANG")
                                                                        attributes:@{
                                                                                     NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                     NSParagraphStyleAttributeName : style1
                                                                                     }];
    //交易密码
    iconTwoName = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_secret"]];
    [walletView addSubview: iconTwoName];
    [iconTwoName setY: (lineHeight - iconTwoName.height) / 2.0 +line1.maxY];
    iconTwoName.x = SCREEN_WIDTH/30;
    
    nameTwoText = [[UITextField alloc] initWithFrame:CGRectMake(iconTwoBankId.maxX+SCREEN_WIDTH/30 , line1.maxY, SCREEN_WIDTH- iconTwoName.maxX - SCREEN_WIDTH/15, lineHeight)];
    [walletView addSubview: nameTwoText];
    nameTwoText.textColor = UIColorFromRGB(0x767D85);
    nameTwoText.font = [UIFont systemFontOfSize:WITHFONTTWO];
    nameTwoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTwoText.secureTextEntry = YES;
    
    NSMutableParagraphStyle *style2 = [nameTwoText.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style2.minimumLineHeight = nameTwoText.font.lineHeight - (nameTwoText.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    nameTwoText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"JIAOYIMIMA")
                                                                        attributes:@{
                                                                                     NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                     NSParagraphStyleAttributeName : style2
                                                                                     }];
    
    drawButton = [[UIButton alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/20, walletView.maxY + SCREEN_WIDTH/20, SCREEN_WIDTH-SCREEN_WIDTH/10, SCREEN_WIDTH/8)];
    [drawButton setTitle: LocatizedStirngForkey(@"TIXIAN") forState: UIControlStateNormal];
    drawButton.titleLabel.font = [UIFont systemFontOfSize: LOGINFONTBUTONE];
    [drawButton.layer setMasksToBounds:YES];
    [drawButton.layer setCornerRadius:5.0];
    [drawButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [drawButton setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3178E3)] forState:UIControlStateNormal];
    [drawButton setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3A5FCD)] forState:UIControlStateHighlighted];
    
    [drawButton addTarget: self action: @selector(yTixian) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: drawButton];
    
    CGRect pointValueRect = CGRectMake(SCREEN_WIDTH/24, drawButton.maxY+SCREEN_WIDTH/10 ,1, 1);
    pointValue = [[UILabel alloc] initWithFrame:pointValueRect];
    pointValue.font = [UIFont systemFontOfSize:TRANFONTTWO];
    pointValue.textColor = [UIColor whiteColor];
    pointValue.text = LocatizedStirngForkey(@"TIXIANSHUOMING");
    [pointValue sizeToFit];
    [self.view addSubview: pointValue];
    NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
    float heighttwo = 0.0;
    if([language isEqualToString:@"zh-Hans"]){
        heighttwo = SCREEN_WIDTH/5;
    }else if([language isEqualToString:@"en"]){
        heighttwo = SCREEN_WIDTH/2.5;
    }
    CGRect huValueRect = CGRectMake(SCREEN_WIDTH/24, pointValue.maxY+5 ,SCREEN_WIDTH-SCREEN_WIDTH/12, heighttwo);
    
    huValue = [[UILabel alloc] initWithFrame:huValueRect];
    huValue.font = [UIFont systemFontOfSize:WITHFONTONE];
    huValue.textColor = UIColorFromRGB(0x666B70);
    huValue.lineBreakMode = NSLineBreakByCharWrapping;
    huValue.numberOfLines = 0;//上面两行设置多行显示
    huValue.text = LocatizedStirngForkey(@"XINIBITIXIANGUIZE");
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
-(void)yTixian{
    NSString *buyTexts = bankTwoId.text;
    NSString *sellTexts = cmBankTwoId.text;
    NSString *names = nameTwoText.text;
    VALIDATE_NOT_NULL(buyTexts, LocatizedStirngForkey(@"QIANBAODIZHIBUNENGWEIKONG"));
    VALIDATE_NOT_NULL(sellTexts, LocatizedStirngForkey(@"ZHUANCHUSHULIANGBUNENGWEIKONG"));
    VALIDATE_NOT_NULL(names, LocatizedStirngForkey(@"JIAOYIMIMABUNENGWEIKONG"));
    [ProgressHUD show: [NSString stringWithFormat:@"%@...",LocatizedStirngForkey(@"QINGDENGDAI")] Interaction: NO];
    [[NetHttpClient sharedHTTPClient] request: @"/coins_extract.json" parameters:@{@"symbol":_sysId, @"wallet":buyTexts, @"quantity": sellTexts,@"trade_pwd": names, @"auth_key":[HQZXUserModel sharedInstance].currentUser.auth_key} completion:^(id obj) {
        [ProgressHUD dismiss];
        if (obj) {
            if ([@"0" isEqualToString:StrValueFromDictionary(obj, ApiKey_ErrorCode)]) {
                [self.view makeToast: LocatizedStirngForkey(@"CAOZUOCHENGGONG") duration: 0.5 position: CSToastPositionCenter];
                [self reData];
                bankTwoId.text = @"";
                cmBankTwoId.text = @"";
                nameTwoText.text = @"";
            } else {
                [self.view makeToast:[NSString stringWithFormat:@"%@", [obj objectForKey:@"message"]] duration: 0.5 position:CSToastPositionCenter];
            }
        } else {
            [self.view makeToast:LocatizedStirngForkey(@"LIANJIEFUWUQISHIBAI") duration: 0.5 position:CSToastPositionCenter];
        }
    }];
}
-(void)history{
    HQZXCashViewController *historyView=[[HQZXCashViewController alloc]init];
    historyView.sysid = _sysId;
    [self.navigationController pushViewController:historyView animated:YES];
}
@end
