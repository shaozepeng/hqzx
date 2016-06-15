//
//  HQZXModifyTransactionViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/26.
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
#define UD_KEY_VALIDATENO_ID_TRANSA @"VALIDATENO_ID_Transa"

#import "HQZXUserModel.h"
#import "ProgressHUD.h"
#import "NetHttpClient.h"
#import "CommonUtils.h"
#import "HQZXModifyTransactionViewController.h"
#import "IQUIView+IQIgnoreGroup.h"
#import <UIView+Toast.h>
@interface HQZXModifyTransactionViewController () {
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
    NSString *codeType;
}
@end

@implementation HQZXModifyTransactionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor = [UIColor whiteColor];
    self.title = LocatizedStirngForkey(@"SHEZHIXIUGAIJIAOYIMIMA");
    
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    [self initForm1];
    [self setIsEnabledForBtnValidateNo];
    //    [self initForm2];
    [self initRegisterButton];
    //    [self initRemark];
    
    //    if (btnGetValidateNo.enabled) {
    //        [txtValidateNo becomeFirstResponder];
    //    } else {
    //        [txtPhone becomeFirstResponder];
    //    }
}

- (void) initForm1 {
    form1 = [[UIView alloc] initWithFrame: CGRectMake(0, TOP_HEIGHT + SCREEN_WIDTH/10, SCREEN_WIDTH , SCREEN_WIDTH/2)];
    [form1 setBackgroundColor:UIColorFromRGB(0x293035)];
    [self.view addSubview: form1];
    
    
    UIView *line = [[UIView alloc] initWithFrame: CGRectMake(0, form1.height / 4, SCREEN_WIDTH, borderWidthForForm)];
    line.backgroundColor = UIColorFromRGB(0x0C1319);
    
    UIView *line2 = [[UIView alloc] initWithFrame: CGRectMake(0, form1.height / 2, SCREEN_WIDTH, borderWidthForForm)];
    UIView *line3 = [[UIView alloc] initWithFrame: CGRectMake(0, form1.height / 4*3, SCREEN_WIDTH, borderWidthForForm)];
    line.backgroundColor = UIColorFromRGB(0x0C1319);
    line2.backgroundColor = UIColorFromRGB(0x0C1319);
    line3.backgroundColor = UIColorFromRGB(0x0C1319);
    [form1 addSubview: line];
    [form1 addSubview: line2];
    [form1 addSubview: line3];
    
    //    UIView *userNameView = [[UIView alloc] initWithFrame: CGRectMake(borderWidthForForm, borderWidthForForm, form1.width - borderWidthForForm*2, (form1.height - borderWidthForForm*2 - line.height)/2)];
    //    [form1 addSubview:userNameView];
    UIImageView *iconQuePassword = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_secret"]];
    [form1 addSubview: iconQuePassword];
    [iconQuePassword setY: (form1.height/4 - iconQuePassword.height) / 2.0 ];
    iconQuePassword.x = SCREEN_WIDTH/20;
    
    txtQuePassword = [[UITextField alloc] initWithFrame:CGRectMake(iconQuePassword.maxX + SCREEN_WIDTH/40 + 1, 0, form1.width - iconQuePassword.maxX - marginTxtWithIcon - COMMON_H_MARGIN, form1.height/4 )];
    [form1 addSubview: txtQuePassword];
    txtQuePassword.secureTextEntry = YES;
    txtQuePassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtQuePassword.textColor = UIColorFromRGB(0x767D85);
    txtQuePassword.font = [UIFont systemFontOfSize:TRANTFONTONE];
//    txtQuePassword.placeholder = LocatizedStirngForkey(@"JIAOYIMIMA");
//    [txtQuePassword setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
//    [txtQuePassword setValue:[UIFont systemFontOfSize:TRANTFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style = [txtQuePassword.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = txtQuePassword.font.lineHeight - (txtQuePassword.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtQuePassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"JIAOYIMIMA")
                                                                          attributes:@{
                                                                                       NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                       NSFontAttributeName : [UIFont systemFontOfSize:TRANTFONTONE],
                                                                                       NSParagraphStyleAttributeName : style
                                                                                       }];
    
    UIImageView *iconDengPassword = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_secret"]];
    [form1 addSubview: iconDengPassword];
    [iconDengPassword setY: (form1.height /4 - iconDengPassword.height) / 2.0 + line.maxY];
    iconDengPassword.x = SCREEN_WIDTH/20;
    
    txtDengPassword = [[UITextField alloc] initWithFrame:CGRectMake(iconQuePassword.maxX + SCREEN_WIDTH/40 + 1, line.maxY + 1, form1.width - iconQuePassword.maxX - marginTxtWithIcon - COMMON_H_MARGIN,form1.height/4 - 1)];
    [form1 addSubview: txtDengPassword];
    txtDengPassword.secureTextEntry = YES;
    txtDengPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtDengPassword.textColor = UIColorFromRGB(0x767D85);
    txtDengPassword.font = [UIFont systemFontOfSize:TRANTFONTONE];
//    txtDengPassword.placeholder = LocatizedStirngForkey(@"QUERENJIAOYIMIMA");
//    [txtDengPassword setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
//    [txtDengPassword setValue:[UIFont systemFontOfSize:TRANTFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style2 = [txtDengPassword.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style2.minimumLineHeight = txtDengPassword.font.lineHeight - (txtDengPassword.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtDengPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"QUERENJIAOYIMIMA")
                                                                           attributes:@{
                                                                                        NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                        NSFontAttributeName : [UIFont systemFontOfSize:TRANTFONTONE],
                                                                                        NSParagraphStyleAttributeName : style2
                                                                                        }];
    
    UIImageView *iconPhone = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_phone"]];
    [form1 addSubview: iconPhone];
    [iconPhone setY: (form1.height/4 - iconPhone.height) / 2.0+ line2.maxY];
    iconPhone.x = SCREEN_WIDTH/20;
    
    btnGetValidateNo = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 1, 1)];
    btnGetValidateNo.enabled = NO;
    [btnGetValidateNo setTitle:LocatizedStirngForkey(@"HUOQUYANZHENGMA") forState: UIControlStateNormal];
    btnGetValidateNo.titleLabel.font = [UIFont systemFontOfSize: TRANFONTTWO];
    [form1 addSubview: btnGetValidateNo];
    [btnGetValidateNo sizeToFit];
    [btnGetValidateNo setH:btnGetValidateNo.height*0.8];
    [btnGetValidateNo adjustW: 22 andH: 8];
    [btnGetValidateNo.layer setBorderWidth:1.0];
    [btnGetValidateNo.layer setCornerRadius:5.0];
    [btnGetValidateNo.layer setBorderColor:UIColorFromRGB(0x3E87FA).CGColor];
    [btnGetValidateNo setX: (form1.width - btnGetValidateNo.width - 6)];
    [btnGetValidateNo setY: (form1.height/4 -btnGetValidateNo.height) / 2.0+line2.maxY ];
    [btnGetValidateNo setTitleColor: UIColorFromRGB(0x3E87FA) forState:UIControlStateDisabled];
    [btnGetValidateNo setTitleColor: UIColorFromRGB(0x87CEFA) forState:UIControlStateNormal];
    [btnGetValidateNo setTitleColor: UIColorFromRGB(0x2254A6) forState:UIControlStateHighlighted];
    UIImage *btnGetValidateNoImage = [[UIImage imageNamed:@"user_login_form_validatebg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [btnGetValidateNo setBackgroundImage: btnGetValidateNoImage forState: UIControlStateNormal];
    btnGetValidateNo.adjustsImageWhenHighlighted=NO;
    [btnGetValidateNo addTarget: self action: @selector(getValidateNo:) forControlEvents:UIControlEventTouchUpInside];
    
    txtPhone = [[US2ValidatorTextField alloc] initWithFrame:CGRectMake(iconQuePassword.maxX + SCREEN_WIDTH/40 + 1, line2.maxY+1, form1.width -(form1.width - btnGetValidateNo.x)- iconQuePassword.maxX - marginTxtWithIcon - 2, form1.height/4 - 1)];
    txtPhone.clearButtonMode = UITextFieldViewModeWhileEditing;
    US2Validator *validator = [[US2Validator alloc] init];
    US2ConditionNumeric *numCondition = [[US2ConditionNumeric alloc] init];
    US2ConditionRange *rangeCondition = [[US2ConditionRange alloc] init];
    rangeCondition.range = NSMakeRange(11, 11);
    US2ConditionAnd *phoneCondition = [[US2ConditionAnd alloc] initWithConditionOne:numCondition two: rangeCondition];
    [validator addCondition:phoneCondition];
    txtPhone.validator = validator;
    phoneCondition.shouldAllowViolation = YES;
    txtPhone.shouldAllowViolations   = YES;
    txtPhone.validateOnFocusLossOnly = NO;
    txtPhone.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtPhone.validatorUIDelegate = self;
    if ([initPhoneNo isNotEmpty]) {
        txtPhone.text = initPhoneNo;
    }
    
    [form1 addSubview: txtPhone];
    txtPhone.keyboardType = UIKeyboardTypeNumberPad;
    txtPhone.textColor = UIColorFromRGB(0x767D85);
    txtPhone.font = [UIFont systemFontOfSize:TRANTFONTONE];
//    txtPhone.placeholder = @"18888888888";
//    [txtPhone setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
//    [txtPhone setValue:[UIFont systemFontOfSize:TRANTFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style3 = [txtPhone.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style3.minimumLineHeight = txtPhone.font.lineHeight - (txtPhone.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtPhone.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"SHOUJIHAOMA")
                                                                            attributes:@{
                                                                                         NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                         NSFontAttributeName : [UIFont systemFontOfSize:TRANTFONTONE],
                                                                                         NSParagraphStyleAttributeName : style3
                                                                                         }];
    
    
    //    UIView *validateView = [[UIView alloc] initWithFrame: CGRectMake(borderWidthForForm, userNameView.maxY + line.height, userNameView.width, userNameView.height)];
    //    [form1 addSubview:validateView];
    NSString *remindUserName = [USER_DEFAULT objectForKey:lastLoginUserNameKey];
    if (remindUserName != nil && [remindUserName isNotEmpty]) {
        txtPhone.text = remindUserName;
    }
    
    
    UIImageView *iconPassword = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_yam"]];
    [form1 addSubview: iconPassword];
    form1.IQIgnoreGroup = YES;
    [iconPassword setY: (form1.height/4 - iconPassword.height) / 2.0 + line3.maxY];
    iconPassword.x = SCREEN_WIDTH/20;
    
    txtValidateNo = [[UITextField alloc] initWithFrame:CGRectMake(iconQuePassword.maxX + SCREEN_WIDTH/40 + 1, line3.maxY + 1, form1.width - iconQuePassword.maxX - marginTxtWithIcon - COMMON_H_MARGIN, form1.height/4 - 1)];
    [form1 addSubview: txtValidateNo];
    txtValidateNo.keyboardType = UIKeyboardTypeNumberPad;
    txtValidateNo.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtValidateNo.textColor = UIColorFromRGB(0x767D85);
    txtValidateNo.font = [UIFont systemFontOfSize:TRANTFONTONE];
//    txtValidateNo.placeholder = LocatizedStirngForkey(@"QINGSHURUYANZHENGMA");
//    [txtValidateNo setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
//    [txtValidateNo setValue:[UIFont systemFontOfSize:TRANTFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style4 = [txtValidateNo.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style4.minimumLineHeight = txtValidateNo.font.lineHeight - (txtValidateNo.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtValidateNo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"QINGSHURUYANZHENGMA")
                                                                     attributes:@{
                                                                                  NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                  NSFontAttributeName : [UIFont systemFontOfSize:TRANTFONTONE],
                                                                                  NSParagraphStyleAttributeName : style4
                                                                                  }];
    
    txtValidateNo.delegate = self;

}

- (void) initRegisterButton {
    btnRegister = [[UIButton alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/20, form1.maxY + SCREEN_WIDTH/7, SCREEN_WIDTH-SCREEN_WIDTH/10, SCREEN_WIDTH/8)];
    [btnRegister setTitle: LocatizedStirngForkey(@"QUEDING") forState: UIControlStateNormal];
    btnRegister.titleLabel.font = [UIFont systemFontOfSize: TRANFONTBUTONE];
    [btnRegister.layer setMasksToBounds:YES];
    [btnRegister.layer setCornerRadius:5.0];
    [btnRegister setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [btnRegister setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3178E3)] forState:UIControlStateNormal];
    [btnRegister setBackgroundImage:[CommonUtils createImageWithColor: COL_BLUE] forState:UIControlStateHighlighted];
    
    [btnRegister addTarget: self action: @selector(userRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btnRegister];
    
    
    //初始化UILabel
    CGRect pointValueRect = CGRectMake(SCREEN_WIDTH/24, btnRegister.maxY+SCREEN_WIDTH/TRANFONTHEIGHT ,SCREEN_WIDTH-SCREEN_WIDTH/12, 100);
    UILabel *pointValue = [[UILabel alloc] initWithFrame:pointValueRect];
    pointValue.font = [UIFont systemFontOfSize:TRANFONTLABEL];
    pointValue.textColor = UIColorFromRGB(0x666B70);
    pointValue.lineBreakMode = NSLineBreakByCharWrapping;
    pointValue.numberOfLines = 0;//上面两行设置多行显示
    pointValue.text = LocatizedStirngForkey(@"KAIFATISHIDENGLUXIUGAI");
    [self.view addSubview: pointValue];
}


-(void) labelTouchUpInside{
    //    JHTYongHuXieYiViewController *xiaoxi = [[JHTYongHuXieYiViewController alloc] init];
    //    [self.navigationController pushViewController:xiaoxi animated: YES];
}
-(IBAction)getValidateNo:(id)sender {
    
    NSString *lastGetValidateNoTime = [USER_DEFAULT objectForKey: UD_KEY_LAST_GETVALIDATENO];
    NSTimeInterval ins = [[NSDate date] timeIntervalSince1970] * 1000;
    if (lastGetValidateNoTime != nil) {
        long second = (ins - [lastGetValidateNoTime longLongValue]) / 1000;
        if (second <= max_second) {
            [self.view makeToast:[NSString stringWithFormat:@"%@%ld%@",LocatizedStirngForkey(@"QINGDENGDAI"), max_second - second,LocatizedStirngForkey(@"MIAOHOUZAIHUOQU")]
                        duration:1.0
                        position:CSToastPositionCenter];
            return;
        }
    }
    
    NSString *phoneNo = txtPhone.text;
    if([CommonUtils checkTelNumber: phoneNo] == NO) {
        [self.view makeToast:LocatizedStirngForkey(@"SHOUJIHAOMAGESHICUOWU")
                    duration:1.0
                    position:CSToastPositionCenter];
        return;
    }
    [ProgressHUD show: [NSString stringWithFormat:@"%@,%@...",LocatizedStirngForkey(@"ZHENGZAIHUOQUYANZHENG"),LocatizedStirngForkey(@"QINGDENGDAI")] Interaction: NO];
    // 请求服务器接口获取验证码
    NSString *mobile = txtPhone.text;
    NSString *stype = @"3";
    
    WEAK_SELF
    [[NetHttpClient sharedHTTPClient] request: @"/send_authcode.json" parameters:@{@"mobile": mobile, @"stype": stype} completion:^(id obj) {
        [ProgressHUD dismiss];
        if (obj) {
            if ([StrValueFromDictionary(obj, ApiKey_ErrorCode) isEqualToString: @"0"]) {
                [self.view makeToast: LocatizedStirngForkey(@"YANZHENGMAFASONGCHENGGONG") duration: 0.5 position: CSToastPositionCenter];
                id codeid = [obj objectForKey: @"codeid"];
                codeType = StrValueFromDictionary(obj, @"codetype");
                NSString *codeidStr = [NSString stringWithFormat: @"%@", codeid];
                [USER_DEFAULT setObject: codeidStr forKey:UD_KEY_VALIDATENO_ID_TRANSA];
                btnGetValidateNo.enabled = NO;
                NSTimeInterval ins = [[NSDate date] timeIntervalSince1970] * 1000;
                NSString *lastGetValidateNoTime = [NSString stringWithFormat: @"%.0f", ins];
                [USER_DEFAULT setObject:lastGetValidateNoTime forKey: UD_KEY_LAST_GETVALIDATENO];
                validateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakself selector:@selector(refValidateBtnTitle:) userInfo:nil repeats:YES];
            } else {
                [self.view makeToast:[NSString stringWithFormat: @"%@：%@", LocatizedStirngForkey(@"HUOQUYANZHENGMASHIBAI"),[obj objectForKey: @"message"]] duration: 0.5 position:CSToastPositionCenter];
            }
        } else {
            [self.view makeToast:LocatizedStirngForkey(@"LIANJIEFUWUQISHIBAI") duration: 0.5 position:CSToastPositionCenter];
        }
    }];
}
-(IBAction)refValidateBtnTitle:(id)sender {
    NSString *lastGetValidateNoTime = [USER_DEFAULT objectForKey: UD_KEY_LAST_GETVALIDATENO];
    if (lastGetValidateNoTime == nil) {
        if (validateTimer) {
            [validateTimer invalidate];
            validateTimer = nil;
            [self setIsEnabledForBtnValidateNo];
            return;
        }
    }
    NSTimeInterval ins = [[NSDate date] timeIntervalSince1970] * 1000;
    long second = (ins - [lastGetValidateNoTime longLongValue]) / 1000;
    if (second > max_second) {
        if (validateTimer) {
            [USER_DEFAULT removeObjectForKey: UD_KEY_LAST_GETVALIDATENO];
            [validateTimer invalidate];
            validateTimer = nil;
            [btnGetValidateNo setTitle:nil forState:UIControlStateDisabled];
            [self setIsEnabledForBtnValidateNo];
        }
        return;
    } else {
        btnGetValidateNo.enabled = NO;
        [btnGetValidateNo setTitle: [NSString stringWithFormat:@"%ld s", max_second - second] forState: UIControlStateDisabled];
    }
    
}

- (void) setIsEnabledForBtnValidateNo {
    if([CommonUtils checkTelNumber: txtPhone.text] == YES) {
        btnGetValidateNo.enabled = YES;
    } else {
        btnGetValidateNo.enabled = NO;
    }
}

-(IBAction)userRegister:(id)sender {
    NSString *jiaopwd = txtQuePassword.text;
    NSString *quepwd = txtDengPassword.text;
    NSString *yanzm = txtValidateNo.text;
//    NSString *codeid = [USER_DEFAULT objectForKey: UD_KEY_VALIDATENO_ID_TRANSA];
    VALIDATE_NOT_NULL(jiaopwd, LocatizedStirngForkey(@"QINGSHURUJIAOYIMIMA"));
    VALIDATE_REGEX(jiaopwd, @"^[\\@A-Za-z0-9\\!\\#\\$\\%\\^\\&\\*\\.\\~]{6,16}$", LocatizedStirngForkey(@"MIMABAOHANXIAHUAXIANDENG"));
    VALIDATE_NOT_NULL(quepwd, LocatizedStirngForkey(@"QINGSHURUQUERENMIMA"));
    VALIDATE_NOT_NULL(yanzm, LocatizedStirngForkey(@"QINGSHURUYANZHENGMA"));
    if(![jiaopwd isEqualToString:quepwd]){
        [self.view makeToast: LocatizedStirngForkey(@"LIANGCIMIMABUYIZHI") duration: 0.5 position: CSToastPositionCenter];
        return;
    }
    
    [ProgressHUD show: [NSString stringWithFormat:@"%@...",LocatizedStirngForkey(@"QINGDENGDAI")] Interaction: NO];
    [[NetHttpClient sharedHTTPClient] request: @"/upt_trade_pwd.json" parameters:@{@"new_pwd1":jiaopwd, @"new_pwd2":quepwd, @"code": yanzm, @"codetype": codeType,@"auth_key":[HQZXUserModel sharedInstance].currentUser.auth_key} completion:^(id obj) {
        [ProgressHUD dismiss];
        if (obj) {
            if ([@"0" isEqualToString:StrValueFromDictionary(obj, ApiKey_ErrorCode)]) {
                [USER_DEFAULT removeObjectForKey: UD_KEY_VALIDATENO_ID_FINDPWD];
                [self.navigationController popViewControllerAnimated: YES];
                if (self.success) {
                    self.success(txtPhone.text);
                }
                [self.view makeToast:LocatizedStirngForkey(@"XIUGAICHENGGONG") duration: 0.5 position:CSToastPositionCenter];
            } else {
                [self.view makeToast:[NSString stringWithFormat:@"%@", [obj objectForKey:@"message"]] duration: 0.5 position:CSToastPositionCenter];
            }
        } else {
            [self.view makeToast:LocatizedStirngForkey(@"LIANJIEFUWUQISHIBAI") duration: 0.5 position:CSToastPositionCenter];
        }
    }];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == txtValidateNo) {
        NSString *phone = [textField.text stringByReplacingCharactersInRange: range withString: string];
        if (phone.length <= 6) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}

- (void)validatorUI:(id <US2ValidatorUIProtocol>)validatorUI changedValidState:(BOOL)isValid {
    if (validatorUI == txtPhone && validateTimer == nil) {
        btnGetValidateNo.enabled = isValid;
    }
}

-(void)validatorUI:(id<US2ValidatorUIProtocol>)validatorUI violatedConditions:(US2ConditionCollection *)conditions {
}
//页面将要进入前台，开启定时器
-(void)viewWillAppear:(BOOL)animated
{
    if (validateTimer) {
        [validateTimer setFireDate:[NSDate distantFuture]];
        validateTimer = nil;
    }
    validateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refValidateBtnTitle:) userInfo:nil repeats:YES];
}

//页面消失，进入后台不显示该页面，关闭定时器
-(void)viewDidDisappear:(BOOL)animated {
    //关闭定时器
    [validateTimer setFireDate:[NSDate distantFuture]];
    validateTimer = nil;
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
