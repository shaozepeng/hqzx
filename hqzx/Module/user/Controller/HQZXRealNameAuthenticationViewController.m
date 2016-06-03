//
//  HQZXRealNameAuthenticationViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/29.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define loginFormMarginRL 17
#define borderWidthForForm 1
#define Line_height 55
#define marginTxtWithIcon 5
#define marginLWithIcon 10
#define ColorForFormLine UIColorFromRGB(0xdfdfde)
#define ColorForFunctionButton UIColorFromRGB(0x5f646e)
#define ColorDownForFunctionButton ColorForFormLine

#define max_second 60

#define UD_KEY_LAST_GETVALIDATENO @"LAST_GETVALIDATENO"
#define UD_KEY_VALIDATENO_ID @"VALIDATENO_ID"
#define UD_KEY_VALIDATENO_ID_FINDPWD @"VALIDATENO_ID_FINDPWD"

#import "HQZXUserModel.h"
#import "ProgressHUD.h"
#import "NetHttpClient.h"
#import "CommonUtils.h"
#import "HQZXRealNameAuthenticationViewController.h"
#import "IQUIView+IQIgnoreGroup.h"
#import <UIView+Toast.h>
@interface HQZXRealNameAuthenticationViewController () {
    UIView *form1;
    US2ValidatorTextField *txtPhone;
    UITextField *txtValidateNo;
    UIButton *btnGetValidateNo;
    
    UIView *form2;
    UITextField *txtPassword;
    UITextField *txtDengPassword;
    UITextField *txtQuePassword;
    
    UITextField *txtGuoText;
    UITextField *txtLianText;
    
    UIButton *btnRegister;
    NSTimer *validateTimer;
    
    NSString *initPhoneNo;
    UIImageView *clickText;
    HQZXID *card;
    UIView *clickView;
    UIButton *backBtn;
}
@end

@implementation HQZXRealNameAuthenticationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LocatizedStirngForkey(@"SHIMINGRENZHENG");
    
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    [self initForm1];
    [self initRegisterButton];
}

- (void) initForm1 {
    form1 = [[UIView alloc] initWithFrame: CGRectMake(0, TOP_HEIGHT + SCREEN_WIDTH/10, SCREEN_WIDTH , SCREEN_WIDTH/2*0.75)];
    [form1 setBackgroundColor:UIColorFromRGB(0x293035)];
    [self.view addSubview: form1];
    
    
    UIView *line = [[UIView alloc] initWithFrame: CGRectMake(0, form1.height / 3, SCREEN_WIDTH, borderWidthForForm)];
    line.backgroundColor = UIColorFromRGB(0x0C1319);
    
    UIView *line2 = [[UIView alloc] initWithFrame: CGRectMake(0, form1.height / 3*2, SCREEN_WIDTH, borderWidthForForm)];
    line.backgroundColor = UIColorFromRGB(0x0C1319);
    line.backgroundColor = UIColorFromRGB(0x0C1319);
    line2.backgroundColor = UIColorFromRGB(0x0C1319);
    [form1 addSubview: line];
    [form1 addSubview: line2];
    
    
    
    UIImageView *iconPassword = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lock"]];
    [form1 addSubview: iconPassword];
    form1.IQIgnoreGroup = YES;
    [iconPassword setY: (form1.height/3 - iconPassword.height) / 2.0 ];
    iconPassword.x = SCREEN_WIDTH/20;
    
    
    txtValidateNo = [[UITextField alloc] initWithFrame:CGRectMake(iconPassword.maxX + SCREEN_WIDTH/40 + 1, 1, form1.width - iconPassword.maxX - marginTxtWithIcon - COMMON_H_MARGIN, form1.height/3 - 1)];
    [form1 addSubview: txtValidateNo];
    txtValidateNo.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtValidateNo.textColor = UIColorFromRGB(0x767D85);
    txtValidateNo.font = [UIFont systemFontOfSize:MODIFYTFONTONE];
    if ([HQZXUserModel sharedInstance].isAuthen) {
        txtValidateNo.text = _username;
        txtValidateNo.enabled = NO;
    }
    txtValidateNo.text = _username;
    //    txtValidateNo.placeholder = LocatizedStirngForkey(@"XINMIMA");
    //    [txtValidateNo setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
    //    [txtValidateNo setValue:[UIFont systemFontOfSize:MODIFYTFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style2 = [txtValidateNo.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style2.minimumLineHeight = txtValidateNo.font.lineHeight - (txtValidateNo.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtValidateNo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"QINGSHURUXINGMING")
                                                                          attributes:@{
                                                                                       NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                       NSFontAttributeName : [UIFont systemFontOfSize:MODIFYTFONTONE],
                                                                                       NSParagraphStyleAttributeName : style2
                                                                                       }];
    
    txtValidateNo.delegate = self;
    
    
    UIImageView *iconLianText = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lock"]];
    [form1 addSubview: iconLianText];
    [iconLianText setY: (form1.height/3 - iconLianText.height) / 2.0 +line.maxY];
    iconLianText.x = SCREEN_WIDTH/20;
    
    txtLianText = [[UITextField alloc] initWithFrame:CGRectMake(iconLianText.maxX + SCREEN_WIDTH/40 + 1, line.maxY+1, form1.width - iconLianText.maxX -SCREEN_WIDTH/30- SCREEN_WIDTH/8, form1.height/3 - 1)];
    [form1 addSubview: txtLianText];
    [txtLianText setEnabled:NO];
    
    txtLianText.textColor = UIColorFromRGB(0x767D85);
    txtLianText.font = [UIFont systemFontOfSize:MODIFYTFONTONE];
    txtLianText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    txtLianText.placeholder = LocatizedStirngForkey(@"GUOJIA");
    //    [txtLianText setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
    //    [txtLianText setValue:[UIFont systemFontOfSize:REGISTERFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style = [txtLianText.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = txtLianText.font.lineHeight - (txtLianText.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtLianText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"XUANZEZHENGJIANLEIXING")
                                                                        attributes:@{
                                                                                     NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:MODIFYTFONTONE],
                                                                                     NSParagraphStyleAttributeName : style
                                                                                     }];
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(txtLianText.maxX, line.maxY, SCREEN_WIDTH/8, form1.height/3);
    [backBtn setTintColor:[UIColor whiteColor]];
    [backBtn setTitleColor:UIColorFromRGB(0x293035) forState:UIControlStateNormal];
    UIImage *leftBtnImage = [UIImage imageNamed:@"icon_jt_bo_bl"];
    [backBtn setImage:leftBtnImage forState:UIControlStateNormal];
    [form1 addSubview: backBtn];
    
    clickView = [[UIView alloc]initWithFrame:CGRectMake(iconLianText.maxX + SCREEN_WIDTH/30, line.maxY , form1.width - iconLianText.maxX - SCREEN_WIDTH/30, form1.height/3-1)];
    clickView.userInteractionEnabled = YES;
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCard)];
    
    [clickView addGestureRecognizer:tapGesture];
    [form1 addSubview: clickView];
    if ([HQZXUserModel sharedInstance].isAuthen) {
        txtLianText.text = _cardTyoe;
        backBtn.hidden = YES;
        clickView.userInteractionEnabled = NO;
    }
    
    
    UIImageView *iconDengPasswords = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lock"]];
    [form1 addSubview: iconDengPasswords];
    [iconDengPasswords setY: (form1.height /3 - iconDengPasswords.height) / 2.0 + line2.maxY];
    iconDengPasswords.x = SCREEN_WIDTH/20;
    
    txtDengPassword = [[UITextField alloc] initWithFrame:CGRectMake(iconDengPasswords.maxX + SCREEN_WIDTH/40 + 1, line2.maxY + 1, form1.width - iconDengPasswords.maxX - marginTxtWithIcon - COMMON_H_MARGIN,form1.height/3 - 1)];
    [form1 addSubview: txtDengPassword];
    txtDengPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtDengPassword.textColor = UIColorFromRGB(0x767D85);
    txtDengPassword.font = [UIFont systemFontOfSize:MODIFYTFONTONE];
    //    txtDengPassword.placeholder = LocatizedStirngForkey(@"QUERENXINMIMA");
    //    [txtDengPassword setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
    //    [txtDengPassword setValue:[UIFont systemFontOfSize:MODIFYTFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style3 = [txtDengPassword.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style3.minimumLineHeight = txtDengPassword.font.lineHeight - (txtDengPassword.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtDengPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"QINGSHURUSHENFENZHENGHAOMA")
                                                                            attributes:@{
                                                                                         NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                         NSFontAttributeName : [UIFont systemFontOfSize:MODIFYTFONTONE],
                                                                                         NSParagraphStyleAttributeName : style3
                                                                                         }];
    if ([HQZXUserModel sharedInstance].isAuthen) {
        txtDengPassword.text = _cardId;
        txtDengPassword.enabled = NO;
    }
    
}
-(void)selectCard{
    HQZXSelectIDForm *selectCardForm = [[HQZXSelectIDForm alloc] initWithPlaceHolder: LocatizedStirngForkey(@"XUANZEZHENGJIANLEIXING")];
    __weak typeof(selectCardForm) weakSelectForm = selectCardForm;
    weakSelectForm.beSureComp = HQZXSelectIDComp() {
        [weakSelectForm hideAction:^{
            card = CARD;
            NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
            if([language isEqualToString:@"zh-Hans"]){
                txtLianText.text = CARD.card_name;
            }else if([language isEqualToString:@"en"]){
                txtLianText.text = CARD.card_ename;
            }
            
        }];
    };
    [weakSelectForm showAction];
}

- (void) initRegisterButton {
    btnRegister = [[UIButton alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/20, form1.maxY + SCREEN_WIDTH/7, SCREEN_WIDTH-SCREEN_WIDTH/10, SCREEN_WIDTH/8)];
    [btnRegister setTitle: LocatizedStirngForkey(@"TIJIAO") forState: UIControlStateNormal];
    btnRegister.titleLabel.font = [UIFont systemFontOfSize: MODIFYFONTBUTONE];
    [btnRegister.layer setMasksToBounds:YES];
    [btnRegister.layer setCornerRadius:5.0];
    [btnRegister setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [btnRegister setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3178E3)] forState:UIControlStateNormal];
    [btnRegister setBackgroundImage:[CommonUtils createImageWithColor: COL_BLUE] forState:UIControlStateHighlighted];
    
    [btnRegister addTarget: self action: @selector(userRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btnRegister];
    if ([HQZXUserModel sharedInstance].isAuthen) {
        btnRegister.hidden=YES;
    }
}


-(void) labelTouchUpInside{
    //    JHTYongHuXieYiViewController *xiaoxi = [[JHTYongHuXieYiViewController alloc] init];
    //    [self.navigationController pushViewController:xiaoxi animated: YES];
}


-(IBAction)userRegister:(id)sender {
//    HQZXCertificationSuccessViewController *certificationSuccess = [[HQZXCertificationSuccessViewController alloc]init];
//    [self.navigationController pushViewController:certificationSuccess animated: YES];

    NSString *username = txtValidateNo.text;
    NSString *cardNo = txtDengPassword.text;
    VALIDATE_NOT_NULL(username, LocatizedStirngForkey(@"QINGTIANXIEZHENSHIXINGMING"));
    VALIDATE_NOT_NULL(cardNo, LocatizedStirngForkey(@"QINGTIANXIEZHENGJIANHAOMA"));
    if(!card.card_id){
        [self.view makeToast: LocatizedStirngForkey(@"QINGXUANZEZHENGJIANHAOMA") duration: 0.5 position: CSToastPositionCenter];
        return;
    }
    
    //实名认证
    WEAK_SELF
    [ProgressHUD show: [NSString stringWithFormat:@"%@...",LocatizedStirngForkey(@"QINGDENGDAI")] Interaction: NO];
    [[NetHttpClient sharedHTTPClient] request: @"/identify_auth.json" parameters:@{@"name":username, @"card_id": cardNo, @"card_type": card.card_id,@"auth_key":[HQZXUserModel sharedInstance].currentUser.auth_key} completion:^(id obj) {
        [ProgressHUD dismiss];
        if (obj) {
            if ([@"0" isEqualToString:StrValueFromDictionary(obj, ApiKey_ErrorCode)]) {
                NSData *arc = [NSKeyedArchiver archivedDataWithRootObject: obj];
                [USER_DEFAULT setObject: arc forKey: CURRENT_USER_KEY];
                
                if (weakself.successBlock) {
                    [weakself dismissViewControllerAnimated: YES completion:^{
                        weakself.successBlock();
                    }];

                }else{
                    HQZXCertificationSuccessViewController *certificationSuccess = [[HQZXCertificationSuccessViewController alloc]init];
                    certificationSuccess.name = username;
                    certificationSuccess.cardId = cardNo;
                    certificationSuccess.cardType = card.card_name;
                    [self.navigationController pushViewController:certificationSuccess animated: YES];
                }
                [self.view makeToast:LocatizedStirngForkey(@"RENZHENGCHENGGONG") duration: 0.5 position:CSToastPositionCenter];
            } else {
                [self.view makeToast:[NSString stringWithFormat:@"%@", [obj objectForKey:@"message"]] duration: 0.5 position:CSToastPositionCenter];
            }
        } else {
            [self.view makeToast:LocatizedStirngForkey(@"LIANJIEFUWUQISHIBAI") duration: 0.5 position:CSToastPositionCenter];
        }
    }];
}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if (textField == txtPhone || textField == txtValidateNo) {
//        if (![string isEqualToString: @""]) {
//            if (![string isMatch: RX(@"\\d+")]) {
//                [self.view makeToast: @"字符不正确" duration: 0.5 position: CSToastPositionCenter];
//                return NO;
//            }
//        }
//    }
//    if (textField == txtPhone) {
//        NSString *phone = [textField.text stringByReplacingCharactersInRange: range withString: string];
//        if (phone.length <= 11) {
//            return YES;
//        } else {
//            return NO;
//        }
//    } else if (textField == txtValidateNo) {
//        NSString *phone = [textField.text stringByReplacingCharactersInRange: range withString: string];
//        if (phone.length <= 4) {
//            return YES;
//        } else {
//            return NO;
//        }
//    }
//    return YES;
//}

//页面将要进入前台，开启定时器
-(void)viewWillAppear:(BOOL)animated
{
    
}

//页面消失，进入后台不显示该页面，关闭定时器
-(void)viewDidDisappear:(BOOL)animated {
    //关闭定时器
    
}
-(void)setUsername:(NSString *)value{
    _username = NilToEmpty(value);
}
-(void)setCardId:(NSString *)value{
    _cardId = NilToEmpty(value);
}
-(void)setCardTyoe:(NSString *)value{
    _cardTyoe = NilToEmpty(value);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction) userLoginBack:(id) sender{
    HQZXLoginViewController *userLogin= [[HQZXLoginViewController alloc] init];
    [self.navigationController pushViewController: userLogin animated: YES];
}
@end
