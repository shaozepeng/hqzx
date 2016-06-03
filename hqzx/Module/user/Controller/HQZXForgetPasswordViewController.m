//
//  HQZXForgetPasswordViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/25.
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
#import "HQZXForgetPasswordViewController.h"
#import "IQUIView+IQIgnoreGroup.h"
#import <UIView+Toast.h>

@interface HQZXForgetPasswordViewController () {
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

@implementation HQZXForgetPasswordViewController
//-(NSString *)pageName {
//    return self.isFindPwd ? @"找回密码" : @"注册";
//}

-(instancetype)initWithPhoneNo:(NSString*) phoneNo {
    self = [super init];
    if (self) {
        initPhoneNo = phoneNo;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor = [UIColor whiteColor];
    self.title = LocatizedStirngForkey(@"WANGJIMIMA");
    _isFindPwd  = NO;
    
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    UIButton *zhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zhuBtn.frame = CGRectMake(0, 0, 60, 44);
    [zhuBtn setTintColor:[UIColor whiteColor]];
    [zhuBtn setTitle:LocatizedStirngForkey(@"DENGLU") forState:UIControlStateNormal];
    zhuBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [zhuBtn setTitleColor:UIColorFromRGB(0x439AFE) forState:UIControlStateNormal];
    [zhuBtn addTarget:self action:@selector(userLoginBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [temporaryBarButtonItem setCustomView:zhuBtn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -12;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, temporaryBarButtonItem, nil];
    
    
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
    line.backgroundColor = UIColorFromRGB(0x0C1319);
    
    UIView *line3 = [[UIView alloc] initWithFrame: CGRectMake(0, form1.height / 4 *3, SCREEN_WIDTH, borderWidthForForm)];
    line.backgroundColor = UIColorFromRGB(0x0C1319);
    line2.backgroundColor = UIColorFromRGB(0x0C1319);
    line3.backgroundColor = UIColorFromRGB(0x0C1319);
    [form1 addSubview: line];
    [form1 addSubview: line2];
    [form1 addSubview: line3];
    
    //    UIView *userNameView = [[UIView alloc] initWithFrame: CGRectMake(borderWidthForForm, borderWidthForForm, form1.width - borderWidthForForm*2, (form1.height - borderWidthForForm*2 - line.height)/2)];
    //    [form1 addSubview:userNameView];
    
    btnGetValidateNo = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 1, 1)];
    btnGetValidateNo.enabled = NO;
    [btnGetValidateNo setTitle:LocatizedStirngForkey(@"HUOQUYANZHENGMA") forState: UIControlStateNormal];
    btnGetValidateNo.titleLabel.font = [UIFont systemFontOfSize: FORGETFONTTWO];
    [form1 addSubview: btnGetValidateNo];
    [btnGetValidateNo sizeToFit];
    [btnGetValidateNo setH:btnGetValidateNo.height*0.8];
    [btnGetValidateNo adjustW: 22 andH: 8];
    [btnGetValidateNo.layer setBorderWidth:1.0];
    [btnGetValidateNo.layer setCornerRadius:5.0];
    [btnGetValidateNo.layer setBorderColor:UIColorFromRGB(0x3E87FA).CGColor];
    [btnGetValidateNo setX: (form1.width - btnGetValidateNo.width - 6)];
    [btnGetValidateNo setY: (form1.height/4 -btnGetValidateNo.height) / 2.0 ];
    [btnGetValidateNo setTitleColor: UIColorFromRGB(0x3E87FA) forState:UIControlStateDisabled];
    [btnGetValidateNo setTitleColor: UIColorFromRGB(0x87CEFA) forState:UIControlStateNormal];
    [btnGetValidateNo setTitleColor: UIColorFromRGB(0x2254A6) forState:UIControlStateHighlighted];
    UIImage *btnGetValidateNoImage = [[UIImage imageNamed:@"user_login_form_validatebg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [btnGetValidateNo setBackgroundImage: btnGetValidateNoImage forState: UIControlStateNormal];
    btnGetValidateNo.adjustsImageWhenHighlighted=NO;
    [btnGetValidateNo addTarget: self action: @selector(getValidateNo:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *iconPhone = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_phone"]];
    [form1 addSubview: iconPhone];
    [iconPhone setY: (form1.height/4 - iconPhone.height) / 2.0];
    iconPhone.x = SCREEN_WIDTH/20;
    
    txtPhone = [[US2ValidatorTextField alloc] initWithFrame:CGRectMake(iconPhone.maxX + SCREEN_WIDTH/40 + 1, 1, form1.width -(form1.width - btnGetValidateNo.x)- iconPhone.maxX - marginTxtWithIcon - 2, form1.height/4 - 1)];
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
    txtPhone.font = [UIFont systemFontOfSize:FORGETFONTONE];
//    txtPhone.placeholder = LocatizedStirngForkey(@"SHOUJIHAOMA");
//    [txtPhone setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
//    [txtPhone setValue:[UIFont systemFontOfSize:FORGETFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style = [txtPhone.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = txtPhone.font.lineHeight - (txtPhone.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtPhone.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"SHOUJIHAOMA")
                                                                       attributes:@{
                                                                                    NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                    NSFontAttributeName : [UIFont systemFontOfSize:FORGETFONTONE],
                                                                                    NSParagraphStyleAttributeName : style
                                                                                    }];
    
    //    UIView *validateView = [[UIView alloc] initWithFrame: CGRectMake(borderWidthForForm, userNameView.maxY + line.height, userNameView.width, userNameView.height)];
    //    [form1 addSubview:validateView];
    
    
    UIImageView *iconPassword = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lock"]];
    [form1 addSubview: iconPassword];
    form1.IQIgnoreGroup = YES;
    [iconPassword setY: (form1.height/4 - iconPassword.height) / 2.0 + line.maxY];
    iconPassword.x = SCREEN_WIDTH/20;
    
    
    txtValidateNo = [[UITextField alloc] initWithFrame:CGRectMake(iconPhone.maxX + SCREEN_WIDTH/40 + 1, line.maxY + 1, form1.width  - iconPassword.maxX - marginTxtWithIcon - COMMON_H_MARGIN, form1.height/4 - 1)];
    [form1 addSubview: txtValidateNo];
    txtValidateNo.keyboardType = UIKeyboardTypeNumberPad;
    txtValidateNo.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtValidateNo.textColor = UIColorFromRGB(0x767D85);
    txtValidateNo.font = [UIFont systemFontOfSize:FORGETFONTONE];
//    txtValidateNo.placeholder = LocatizedStirngForkey(@"QINGSHURUYANZHENGMA");
//    [txtValidateNo setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
//    [txtValidateNo setValue:[UIFont systemFontOfSize:FORGETFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style2 = [txtValidateNo.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style2.minimumLineHeight = txtValidateNo.font.lineHeight - (txtValidateNo.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtValidateNo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"QINGSHURUYANZHENGMA")
                                                                     attributes:@{
                                                                                  NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                  NSFontAttributeName : [UIFont systemFontOfSize:FORGETFONTONE],
                                                                                  NSParagraphStyleAttributeName : style2
                                                                                  }];
    
    txtValidateNo.delegate = self;
    
    UIImageView *iconDengPassword = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lock"]];
    [form1 addSubview: iconDengPassword];
    [iconDengPassword setY: (form1.height /4 - iconDengPassword.height) / 2.0 + line2.maxY];
    iconDengPassword.x = SCREEN_WIDTH/20;
    
    txtDengPassword = [[UITextField alloc] initWithFrame:CGRectMake(iconPhone.maxX + SCREEN_WIDTH/40 + 1, line2.maxY + 1, form1.width - iconDengPassword.maxX - marginTxtWithIcon - COMMON_H_MARGIN,form1.height/4 - 1)];
    [form1 addSubview: txtDengPassword];
    txtDengPassword.secureTextEntry = YES;
    txtDengPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtDengPassword.textColor = UIColorFromRGB(0x767D85);
    txtDengPassword.font = [UIFont systemFontOfSize:FORGETFONTONE];
//    txtDengPassword.placeholder = LocatizedStirngForkey(@"DENGLUMIMA");
//    [txtDengPassword setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
//    [txtDengPassword setValue:[UIFont systemFontOfSize:FORGETFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style3 = [txtDengPassword.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style3.minimumLineHeight = txtDengPassword.font.lineHeight - (txtDengPassword.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtDengPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"DENGLUMIMA")
                                                                          attributes:@{
                                                                                       NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                       NSFontAttributeName : [UIFont systemFontOfSize:FORGETFONTONE],
                                                                                       NSParagraphStyleAttributeName : style3
                                                                                       }];
    
    UIImageView *iconQuePassword = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lock"]];
    [form1 addSubview: iconQuePassword];
    [iconQuePassword setY: (form1.height/4 - iconQuePassword.height) / 2.0 + line3.maxY];
    iconQuePassword.x = SCREEN_WIDTH/20;
    
    txtQuePassword = [[UITextField alloc] initWithFrame:CGRectMake(iconPhone.maxX + SCREEN_WIDTH/40 + 1, line3.maxY + 1, form1.width - iconQuePassword.maxX - marginTxtWithIcon - COMMON_H_MARGIN, form1.height/4 - 1)];
    [form1 addSubview: txtQuePassword];
    txtQuePassword.secureTextEntry = YES;
    txtQuePassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtQuePassword.textColor = UIColorFromRGB(0x767D85);
    txtQuePassword.font = [UIFont systemFontOfSize:FORGETFONTONE];
//    txtQuePassword.placeholder = LocatizedStirngForkey(@"QUERENMIMA");
//    [txtQuePassword setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
//    [txtQuePassword setValue:[UIFont systemFontOfSize:FORGETFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style4 = [txtQuePassword.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style4.minimumLineHeight = txtQuePassword.font.lineHeight - (txtQuePassword.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtQuePassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"QUERENMIMA")
                                                                            attributes:@{
                                                                                         NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                         NSFontAttributeName : [UIFont systemFontOfSize:FORGETFONTONE],
                                                                                         NSParagraphStyleAttributeName : style4
                                                                                         }];
}


- (void) initRegisterButton {
    btnRegister = [[UIButton alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/20, form1.maxY + SCREEN_WIDTH/7, SCREEN_WIDTH-SCREEN_WIDTH/10, SCREEN_WIDTH/8)];
    [btnRegister setTitle: LocatizedStirngForkey(@"QUEREN") forState: UIControlStateNormal];
    btnRegister.titleLabel.font = [UIFont systemFontOfSize: FORGETFONTBUTONE];
    [btnRegister.layer setMasksToBounds:YES];
    [btnRegister.layer setCornerRadius:5.0];
    [btnRegister setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [btnRegister setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3178E3)] forState:UIControlStateNormal];
    [btnRegister setBackgroundImage:[CommonUtils createImageWithColor: COL_BLUE] forState:UIControlStateHighlighted];
    
    [btnRegister addTarget: self action: @selector(userRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btnRegister];
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
    NSString *stype = @"2";
    
    WEAK_SELF
    [[NetHttpClient sharedHTTPClient] request: @"/send_authcode.json" parameters:@{@"mobile": mobile, @"stype": stype} completion:^(id obj) {
        [ProgressHUD dismiss];
        if (obj) {
            if ([StrValueFromDictionary(obj, ApiKey_ErrorCode) isEqualToString: @"0"]) {
                [self.view makeToast: LocatizedStirngForkey(@"YANZHENGMAFASONGCHENGGONG") duration: 0.5 position: CSToastPositionCenter];
                id codeid = [obj objectForKey: @"codeid"];
                codeType = StrValueFromDictionary(obj, @"codetype");
                NSString *codeidStr = [NSString stringWithFormat: @"%@", codeid];
                [USER_DEFAULT setObject: codeidStr forKey: UD_KEY_VALIDATENO_ID_FINDPWD];
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
    NSString *phoneNo = txtPhone.text;
    NSString *validateNo = txtValidateNo.text;
    NSString *password = txtDengPassword.text;
    NSString *passwordQue= txtQuePassword.text;
    NSString *codeid = [USER_DEFAULT objectForKey: UD_KEY_VALIDATENO_ID_FINDPWD];
    VALIDATE_NOT_NULL(phoneNo, LocatizedStirngForkey(@"QINGTIANXIESHOUJIHAOMA"));
    VALIDATE_NOT_NULL(validateNo, LocatizedStirngForkey(@"QINGSHURUYANZHENGMA"));
    VALIDATE_NOT_NULL(codeid, LocatizedStirngForkey(@"YANZHENGMASHIXIAO"));
    VALIDATE_NOT_NULL(password, LocatizedStirngForkey(@"QINGSHURUXINMIMA"));
    VALIDATE_REGEX(phoneNo, VALREG_MOBILE_PHONE, LocatizedStirngForkey(@"SHOUJIHAOMAGESHIBUZHENGQUE"));
    VALIDATE_REGEX(validateNo, @"\\d{4}", LocatizedStirngForkey(@"YANZHENGMAGESHIBUZHENGQUE"));
    VALIDATE_REGEX(password, @"^[\\@A-Za-z0-9\\!\\#\\$\\%\\^\\&\\*\\.\\~]{6,16}$", LocatizedStirngForkey(@"MIMABAOHANXIAHUAXIANDENG"));
    if(![password isEqualToString:passwordQue]){
        [self.view makeToast: LocatizedStirngForkey(@"LIANGCIMIMABUYIZHI") duration: 0.5 position: CSToastPositionCenter];
        return;
    }
        // 找回密码
    [ProgressHUD show: [NSString stringWithFormat:@"%@...",LocatizedStirngForkey(@"QINGDENGDAI")] Interaction: NO];
    [[NetHttpClient sharedHTTPClient] request: @"/find_pwd.json" parameters:@{@"mobile":phoneNo, @"newpwd":password, @"new2pwd":passwordQue, @"code": validateNo, @"codetype": codeType} completion:^(id obj) {
        [ProgressHUD dismiss];
        if (obj) {
            if ([@"0" isEqualToString:StrValueFromDictionary(obj, ApiKey_ErrorCode)]) {
                [USER_DEFAULT removeObjectForKey: UD_KEY_VALIDATENO_ID_FINDPWD];
                [self.navigationController popViewControllerAnimated: YES];
                if (self.success) {
                    self.success(txtPhone.text);
                }
                return;
            } else {
                [self.view makeToast:[NSString stringWithFormat:@"%@", [obj objectForKey:@"message"]] duration: 0.5 position:CSToastPositionCenter];
            }
        } else {
            [self.view makeToast:LocatizedStirngForkey(@"LIANJIEFUWUQISHIBAI") duration: 0.5 position:CSToastPositionCenter];
        }
    }];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == txtPhone || textField == txtValidateNo) {
        if (![string isEqualToString: @""]) {
            if (![string isMatch: RX(@"\\d+")]) {
                [self.view makeToast: LocatizedStirngForkey(@"ZIFUBUZHENGQUE") duration: 0.5 position: CSToastPositionCenter];
                return NO;
            }
        }
    }
    if (textField == txtPhone) {
        NSString *phone = [textField.text stringByReplacingCharactersInRange: range withString: string];
        if (phone.length <= 11) {
            return YES;
        } else {
            return NO;
        }
    } else if (textField == txtValidateNo) {
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
