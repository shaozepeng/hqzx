//
//  HQZXRMBWithdrawalsViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/5.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXRMBWithdrawalsViewController.h"
@interface HQZXRMBWithdrawalsViewController (){
    UIView *topLineView;
    UIView *topView;
    UIView *bottomLineView;
    UILabel *seceltLab;
    UIButton *backBtn;
    UIView *clickView;
    HQZXBank *commBank;
    UIView *form;
    UIImageView *iconBankId;
    UITextField *bankId;
    UIImageView *cmIconBankId;
    UITextField *cmBankId;
    UIImageView *iconName;
    UITextField *nameText;
    UIImageView *iconBranch;
    UITextField *branchText;
    UIImageView *iconMoney;
    UITextField *moneyText;
    UIImageView *iconPassword;
    UITextField *passwordText;
    UIButton *drawButton;
}
@end

@implementation HQZXRMBWithdrawalsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    self.title = LocatizedStirngForkey(@"RENMINBITIXIAN");
    
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
    
    [self createTopBody];
    [self createFillBody];
}

-(void)createTopBody{
    topLineView = [[UIView alloc] initWithFrame: CGRectMake(0, TOP_HEIGHT+8, SCREEN_WIDTH, 1)];
    topLineView.backgroundColor = UIColorFromRGB(0x192631);
    [self.view addSubview:topLineView];
    
    topView = [[UIView alloc] initWithFrame: CGRectMake(0, topLineView.maxY, SCREEN_WIDTH, SCREEN_WIDTH/10)];
    topView.backgroundColor = UIColorFromRGB(0x0F151B);
    [self.view addSubview:topView];
    
    seceltLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/25, 0, 1, 1)];
    seceltLab.text = LocatizedStirngForkey(@"XUANZEYINHANGKALEIXING");
    seceltLab.font = [UIFont systemFontOfSize: WITHFONTTWO];
    seceltLab.textColor = UIColorFromRGB(0x6F7579);
    [topView addSubview: seceltLab];
    [seceltLab sizeToFit];
    [seceltLab setY:(topView.height-seceltLab.height)/2];
    
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/8 , 0, SCREEN_WIDTH/8, topView.height);
    [backBtn setTintColor:[UIColor whiteColor]];
    [backBtn setTitleColor:UIColorFromRGB(0x293035) forState:UIControlStateNormal];
    UIImage *leftBtnImage = [UIImage imageNamed:@"icon_jt_bo_bl"];
    [backBtn setImage:leftBtnImage forState:UIControlStateNormal];
    [topView addSubview: backBtn];
    
    clickView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, topView.height)];
    clickView.userInteractionEnabled = YES;
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBank)];
    
    [clickView addGestureRecognizer:tapGesture];
    [topView addSubview: clickView];
    
    bottomLineView = [[UIView alloc] initWithFrame: CGRectMake(0, topView.maxY, SCREEN_WIDTH, 1)];
    bottomLineView.backgroundColor = UIColorFromRGB(0x192631);
    [self.view addSubview:bottomLineView];
}
-(void)createFillBody{
    form = [[UIView alloc] initWithFrame: CGRectMake(0, bottomLineView.maxY + SCREEN_WIDTH/30, SCREEN_WIDTH, SCREEN_HEIGHT*0.44)];
    [form setBackgroundColor:UIColorFromRGB(0x293035)];
    [self.view addSubview: form];
    
    float lineHeight = (form.height-4-SCREEN_WIDTH/36)/6;
    UIView *line = [[UIView alloc] initWithFrame: CGRectMake(0, lineHeight, SCREEN_WIDTH, 1)];
    UIView *line1 = [[UIView alloc] initWithFrame: CGRectMake(0, lineHeight*2+1, SCREEN_WIDTH, 1)];
    UIView *line2 = [[UIView alloc] initWithFrame: CGRectMake(0, lineHeight*3+2, SCREEN_WIDTH, 1)];
    UIView *line3 = [[UIView alloc] initWithFrame: CGRectMake(0, lineHeight*4+3, SCREEN_WIDTH, SCREEN_WIDTH/36)];
    UIView *line4 = [[UIView alloc] initWithFrame: CGRectMake(0, lineHeight*5+3+SCREEN_WIDTH/36, SCREEN_WIDTH, 1)];
    line.backgroundColor = UIColorFromRGB(0x0C1319);
    line1.backgroundColor = UIColorFromRGB(0x0C1319);
    line2.backgroundColor = UIColorFromRGB(0x0C1319);
    line3.backgroundColor = UIColorFromRGB(0x0C1319);
    line4.backgroundColor = UIColorFromRGB(0x0C1319);
    [form addSubview: line];
    [form addSubview: line1];
    [form addSubview: line2];
    [form addSubview: line3];
    [form addSubview: line4];
    
    //银行卡号
    iconBankId = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_price_dz"]];
    [form addSubview: iconBankId];
    [iconBankId setY: (lineHeight - iconBankId.height) / 2.0];
    iconBankId.x = SCREEN_WIDTH/30;
    
    bankId = [[UITextField alloc] initWithFrame:CGRectMake(iconBankId.maxX+SCREEN_WIDTH/30 , 0, SCREEN_WIDTH- iconBankId.maxX - SCREEN_WIDTH/15, lineHeight)];
    [form addSubview: bankId];
    bankId.textColor = UIColorFromRGB(0x767D85);
    bankId.font = [UIFont systemFontOfSize:WITHFONTTWO];
    bankId.clearButtonMode = UITextFieldViewModeWhileEditing;
    bankId.keyboardType = UIKeyboardTypeNumberPad;
    
    NSMutableParagraphStyle *style = [bankId.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = bankId.font.lineHeight - (bankId.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    bankId.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"QINGSHURENYINHANGKAHAO")
                                                                        attributes:@{
                                                                                     NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                     NSParagraphStyleAttributeName : style
                                                                                     }];
    
    //确认银行卡号
    cmIconBankId = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_price_dz"]];
    [form addSubview: cmIconBankId];
    [cmIconBankId setY: (lineHeight - cmIconBankId.height) / 2.0 +line.maxY];
    cmIconBankId.x = SCREEN_WIDTH/30;
    
    cmBankId = [[UITextField alloc] initWithFrame:CGRectMake(iconBankId.maxX+SCREEN_WIDTH/30 , line.maxY, SCREEN_WIDTH- cmIconBankId.maxX - SCREEN_WIDTH/15, lineHeight)];
    [form addSubview: cmBankId];
    cmBankId.textColor = UIColorFromRGB(0x767D85);
    cmBankId.font = [UIFont systemFontOfSize:WITHFONTTWO];
    cmBankId.clearButtonMode = UITextFieldViewModeWhileEditing;
    cmBankId.keyboardType = UIKeyboardTypeNumberPad;
    
    NSMutableParagraphStyle *style1 = [cmBankId.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style1.minimumLineHeight = cmBankId.font.lineHeight - (cmBankId.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    cmBankId.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"QUERENYINHANGKAHAO")
                                                                   attributes:@{
                                                                                NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                NSParagraphStyleAttributeName : style1
                                                                                }];
    //收款人姓名
    iconName = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_men"]];
    [form addSubview: iconName];
    [iconName setY: (lineHeight - iconName.height) / 2.0 +line1.maxY];
    iconName.x = SCREEN_WIDTH/30;
    
    nameText = [[UITextField alloc] initWithFrame:CGRectMake(iconBankId.maxX+SCREEN_WIDTH/30 , line1.maxY, SCREEN_WIDTH- iconName.maxX - SCREEN_WIDTH/15, lineHeight)];
    [form addSubview: nameText];
    nameText.textColor = UIColorFromRGB(0x767D85);
    nameText.font = [UIFont systemFontOfSize:WITHFONTTWO];
    nameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    NSMutableParagraphStyle *style2 = [nameText.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style2.minimumLineHeight = nameText.font.lineHeight - (nameText.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    nameText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"SHOUKUANRENXINGMING")
                                                                     attributes:@{
                                                                                  NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                  NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                  NSParagraphStyleAttributeName : style2
                                                                                  }];
    
    //开户支行
    iconBranch = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_kaihuzh"]];
    [form addSubview: iconBranch];
    [iconBranch setY: (lineHeight - iconBranch.height) / 2.0 +line2.maxY];
    iconBranch.x = SCREEN_WIDTH/30;
    
    branchText = [[UITextField alloc] initWithFrame:CGRectMake(iconBankId.maxX+SCREEN_WIDTH/30 , line2.maxY, SCREEN_WIDTH- iconBranch.maxX - SCREEN_WIDTH/15, lineHeight)];
    [form addSubview: branchText];
    branchText.textColor = UIColorFromRGB(0x767D85);
    branchText.font = [UIFont systemFontOfSize:WITHFONTTWO];
    branchText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    NSMutableParagraphStyle *style3 = [branchText.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style3.minimumLineHeight = branchText.font.lineHeight - (branchText.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    branchText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"QINGSHURUKAIHUZHIHANG")
                                                                     attributes:@{
                                                                                  NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                  NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                  NSParagraphStyleAttributeName : style3
                                                                                  }];
    
    //提现金额
    iconMoney = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_monIn"]];
    [form addSubview: iconMoney];
    [iconMoney setY: (lineHeight - iconMoney.height) / 2.0 +line3.maxY];
    iconMoney.x = SCREEN_WIDTH/30;
    
    moneyText = [[UITextField alloc] initWithFrame:CGRectMake(iconBankId.maxX+SCREEN_WIDTH/30 , line3.maxY, SCREEN_WIDTH- iconMoney.maxX - SCREEN_WIDTH/15, lineHeight)];
    [form addSubview: moneyText];
    moneyText.textColor = UIColorFromRGB(0x767D85);
    moneyText.font = [UIFont systemFontOfSize:WITHFONTTWO];
    moneyText.clearButtonMode = UITextFieldViewModeWhileEditing;
    moneyText.keyboardType = UIKeyboardTypeDecimalPad;
    
    NSMutableParagraphStyle *style4 = [moneyText.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style4.minimumLineHeight = moneyText.font.lineHeight - (moneyText.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    moneyText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"TIXIANJINE")
                                                                       attributes:@{
                                                                                    NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                    NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                    NSParagraphStyleAttributeName : style4
                                                                                    }];
    
    //交易密码
    iconPassword = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_secret"]];
    [form addSubview: iconPassword];
    [iconPassword setY: (lineHeight - iconPassword.height) / 2.0 +line4.maxY];
    iconPassword.x = SCREEN_WIDTH/30;
    
    passwordText = [[UITextField alloc] initWithFrame:CGRectMake(iconBankId.maxX+SCREEN_WIDTH/30 , line4.maxY, SCREEN_WIDTH- iconPassword.maxX - SCREEN_WIDTH/15, lineHeight)];
    [form addSubview: passwordText];
    passwordText.secureTextEntry = YES;
    passwordText.textColor = UIColorFromRGB(0x767D85);
    passwordText.font = [UIFont systemFontOfSize:WITHFONTTWO];
    passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    NSMutableParagraphStyle *style5 = [passwordText.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style5.minimumLineHeight = passwordText.font.lineHeight - (passwordText.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    passwordText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"JIAOYIMIMA")
                                                                      attributes:@{
                                                                                   NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                   NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                   NSParagraphStyleAttributeName : style5
                                                                                   }];
    
    drawButton = [[UIButton alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/20, form.maxY + SCREEN_WIDTH/20, SCREEN_WIDTH-SCREEN_WIDTH/10, SCREEN_WIDTH/8)];
    [drawButton setTitle: LocatizedStirngForkey(@"TIXIAN") forState: UIControlStateNormal];
    drawButton.titleLabel.font = [UIFont systemFontOfSize: LOGINFONTBUTONE];
    [drawButton.layer setMasksToBounds:YES];
    [drawButton.layer setCornerRadius:5.0];
    [drawButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [drawButton setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3178E3)] forState:UIControlStateNormal];
    [drawButton setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3A5FCD)] forState:UIControlStateHighlighted];
    
    [drawButton addTarget: self action: @selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: drawButton];
    
    CGRect pointValueRect = CGRectMake(SCREEN_WIDTH/24, drawButton.maxY+SCREEN_WIDTH/20 ,1, 1);
    UILabel *pointValue = [[UILabel alloc] initWithFrame:pointValueRect];
    pointValue.font = [UIFont systemFontOfSize:TRANFONTTWO];
    pointValue.textColor = [UIColor whiteColor];
    pointValue.text = LocatizedStirngForkey(@"JIAOYITIXING");
    [pointValue sizeToFit];
    [self.view addSubview: pointValue];
    NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
    float heighttwo = 0.0;
    if([language isEqualToString:@"zh-Hans"]){
        heighttwo = SCREEN_WIDTH/8;
    }else if([language isEqualToString:@"en"]){
        heighttwo = SCREEN_WIDTH/5;
    }
    CGRect huValueRect = CGRectMake(SCREEN_WIDTH/24, pointValue.maxY+5 ,SCREEN_WIDTH-SCREEN_WIDTH/12, heighttwo);
    UILabel *huValue = [[UILabel alloc] initWithFrame:huValueRect];
    huValue.font = [UIFont systemFontOfSize:WITHFONTONE];
    huValue.textColor = UIColorFromRGB(0x666B70);
    huValue.lineBreakMode = NSLineBreakByCharWrapping;
    huValue.numberOfLines = 0;//上面两行设置多行显示
    huValue.text = LocatizedStirngForkey(@"ZUIGAOXIANE");
    [self.view addSubview: huValue];
    
//    CGRect dihuValueRect = CGRectMake(SCREEN_WIDTH/24, huValue.maxY+5 ,SCREEN_WIDTH-SCREEN_WIDTH/12, SCREEN_WIDTH/14);
//    UILabel *dihuValue = [[UILabel alloc] initWithFrame:dihuValueRect];
//    dihuValue.font = [UIFont systemFontOfSize:WITHFONTONE];
//    dihuValue.textColor = UIColorFromRGB(0x666B70);
//    dihuValue.lineBreakMode = NSLineBreakByCharWrapping;
//    dihuValue.numberOfLines = 0;//上面两行设置多行显示
//    dihuValue.text = LocatizedStirngForkey(@"ZUIDIXIANE");
//    [self.view addSubview: dihuValue];
//    
//    CGRect yanValueRect = CGRectMake(SCREEN_WIDTH/24, dihuValue.maxY+5 ,SCREEN_WIDTH-SCREEN_WIDTH/12, SCREEN_WIDTH/14);
//    UILabel *yanValue = [[UILabel alloc] initWithFrame:yanValueRect];
//    yanValue.font = [UIFont systemFontOfSize:WITHFONTONE];
//    yanValue.textColor = UIColorFromRGB(0x666B70);
//    yanValue.lineBreakMode = NSLineBreakByCharWrapping;
//    yanValue.numberOfLines = 0;//上面两行设置多行显示
//    yanValue.text = LocatizedStirngForkey(@"YOUSUOYANSHI");
//    [self.view addSubview: yanValue];
}
-(void)tijiao{
    NSString *kahao = bankId.text;
    NSString *quekahao = cmBankId.text;
    NSString *xingming = nameText.text;
    NSString *zhihang = branchText.text;
    NSString *tijine = moneyText.text;
    NSString *password = passwordText.text;
    VALIDATE_NOT_NULL(commBank.bank_id, LocatizedStirngForkey(@"XUANZEYINHANGKALEIXING"));
    VALIDATE_NOT_NULL(kahao, LocatizedStirngForkey(@"YINGHANGKABUNENGWEIKONG"));
    VALIDATE_NOT_NULL(quekahao, LocatizedStirngForkey(@"QUEYINGHANGKABUNENGWEIKONG"));
    if(![kahao isEqualToString:quekahao]){
        [self.view makeToast: LocatizedStirngForkey(@"LIANGCIYINHANGKAHAOBUYIZHI") duration: 0.5 position: CSToastPositionCenter];
        return;
    }
    VALIDATE_NOT_NULL(xingming, LocatizedStirngForkey(@"SHOUKUANRENXINGMINGBUNENGWEIKONG"));
    VALIDATE_NOT_NULL(zhihang, LocatizedStirngForkey(@"KAIHUZHIHANGBUNENGWEIKONG"));
    VALIDATE_NOT_NULL(tijine, LocatizedStirngForkey(@"TIXIANJINEBUNENGWEIKONG"));
    VALIDATE_NOT_NULL(password, LocatizedStirngForkey(@"JIAOYIMIMABUNENGWEIKONG"));
    
    [ProgressHUD show: [NSString stringWithFormat:@"%@...",LocatizedStirngForkey(@"QINGDENGDAI")] Interaction: NO];
    [[NetHttpClient sharedHTTPClient] request: @"/rmb_extract_apply.json" parameters:@{@"bank":commBank.bank_id, @"bank_card1":kahao, @"bank_card2": quekahao,@"name": xingming,@"bank_name": zhihang,@"amount": tijine,@"trade_pwd": password,@"auth_key":[HQZXUserModel sharedInstance].currentUser.auth_key} completion:^(id obj) {
        [ProgressHUD dismiss];
        if (obj) {
            if ([@"0" isEqualToString:StrValueFromDictionary(obj, ApiKey_ErrorCode)]) {
                [self.view makeToast: LocatizedStirngForkey(@"CAOZUOCHENGGONG") duration: 0.5 position: CSToastPositionCenter];
                bankId.text = @"";
                cmBankId.text = @"";
                nameText.text = @"";
                branchText.text = @"";
                moneyText.text = @"";
                passwordText.text = @"";
                seceltLab.text = LocatizedStirngForkey(@"XUANZEYINHANGKALEIXING");
            } else {
                [self.view makeToast: [obj objectForKey:@"message"] duration: 0.5 position: CSToastPositionCenter];
            }
        } else {
            [self.view makeToast:LocatizedStirngForkey(@"LIANJIEFUWUQISHIBAI") duration: 0.5 position:CSToastPositionCenter];
        }
    }];
}
-(void)selectBank{
    HQZXSelectBankForm *selectCountForm = [[HQZXSelectBankForm alloc] initWithPlaceHolder: LocatizedStirngForkey(@"XUANZEYINHANGKALEIXING")];
    __weak typeof(selectCountForm) weakSelectForm = selectCountForm;
    weakSelectForm.beSureComp = HQZXSelectBankComp() {
        [weakSelectForm hideAction:^{
            commBank = BANK;
            NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
            if([language isEqualToString:@"zh-Hans"]){
                seceltLab.text = BANK.bank_name;
            }else if([language isEqualToString:@"en"]){
                seceltLab.text = BANK.bank_ename;
            }
        }];
    };
    [weakSelectForm showAction];
}
-(void)history{
    HQZXPresentRecordViewController *historyView=[[HQZXPresentRecordViewController alloc]init];
    [self.navigationController pushViewController:historyView animated:YES];
}
@end
