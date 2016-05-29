//
//  JHTRegisterViewController.m
//  jht
//
//  Created by 孙泽山 on 15/6/24.
//  Copyright (c) 2015年 zthz. All rights reserved.
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

#import "JHTUserModel.h"
#import "ProgressHUD.h"
#import "NetHttpClient.h"
#import "CommonUtils.h"
#import "JHTRegisterViewController.h"
#import "IQUIView+IQIgnoreGroup.h"
#import <UIView+Toast.h>

@interface JHTRegisterViewController () {
    UIView *form1;
    US2ValidatorTextField *txtPhone;
    UITextField *txtValidateNo;
    UIButton *btnGetValidateNo;
    
    UIView *form2;
    UITextField *txtPassword;
    
    UIButton *btnRegister;
    NSTimer *validateTimer;
    
    NSString *initPhoneNo;

}
@end

@implementation JHTRegisterViewController

-(NSString *)pageName {
    return self.isFindPwd ? @"找回密码" : @"注册";
}

-(instancetype)initWithPhoneNo:(NSString*) phoneNo {
    self = [super init];
    if (self) {
        initPhoneNo = phoneNo;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _isFindPwd ? @"忘记密码" :  @"注册江海通";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    self.view.backgroundColor = UIColorFromRGB(0xEEEFF1);
    [self initForm1];
    [self setIsEnabledForBtnValidateNo];
    [self initForm2];
    [self initRegisterButton];
    [self initRemark];
    
//    if (btnGetValidateNo.enabled) {
//        [txtValidateNo becomeFirstResponder];
//    } else {
//        [txtPhone becomeFirstResponder];
//    }
}

- (void) initForm1 {
    int rowCount = 2;
    form1 = [[UIView alloc] initWithFrame: CGRectMake(loginFormMarginRL, TOP_HEIGHT + 25, SCREEN_WIDTH - loginFormMarginRL*2, Line_height*rowCount + (rowCount-1)*borderWidthForForm)];
    
    UIImage *formBackgroundImage = [[UIImage imageNamed:@"user_login_formbg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, form1.width, form1.height)];
    bgView.image = formBackgroundImage;
    [form1 addSubview: bgView];
    [form1 sendSubviewToBack: bgView];
    [self.view addSubview: form1];
    
    
    UIView *line = [[UIView alloc] initWithFrame: CGRectMake(borderWidthForForm, form1.height / 2, form1.width-2, borderWidthForForm)];
    line.backgroundColor = ColorForFormLine;
    [form1 addSubview: line];
    
//    UIView *userNameView = [[UIView alloc] initWithFrame: CGRectMake(borderWidthForForm, borderWidthForForm, form1.width - borderWidthForForm*2, (form1.height - borderWidthForForm*2 - line.height)/2)];
//    [form1 addSubview:userNameView];
    
    UIImageView *iconPhone = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_login_icon_phone"]];
    [form1 addSubview: iconPhone];
    [iconPhone setY: (form1.height - line.y - iconPhone.height) / 2.0];
    iconPhone.x = marginLWithIcon;
    
    txtPhone = [[US2ValidatorTextField alloc] initWithFrame:CGRectMake(iconPhone.maxX + marginTxtWithIcon + 1, 1, form1.width - iconPhone.maxX - marginTxtWithIcon - 2, form1.height - line.y - 2)];
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
    txtPhone.placeholder = @"请使用手机号注册";

//    UIView *validateView = [[UIView alloc] initWithFrame: CGRectMake(borderWidthForForm, userNameView.maxY + line.height, userNameView.width, userNameView.height)];
//    [form1 addSubview:validateView];
    
    
    UIImageView *iconPassword = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_login_icon_password"]];
    [form1 addSubview: iconPassword];
    form1.IQIgnoreGroup = YES;
    [iconPassword setY: (form1.height - line.maxY - iconPassword.height) / 2.0 + line.maxY];
    iconPassword.x = marginLWithIcon;
    
    btnGetValidateNo = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 1, 1)];
    btnGetValidateNo.enabled = NO;
    [btnGetValidateNo setTitle:@"获取验证码" forState: UIControlStateNormal];
    btnGetValidateNo.titleLabel.font = [UIFont systemFontOfSize: 15];
    [form1 addSubview: btnGetValidateNo];
    [btnGetValidateNo sizeToFit];
    [btnGetValidateNo adjustW: 22 andH: 8];
    [btnGetValidateNo setX: (form1.width - btnGetValidateNo.width - 6)];
    [btnGetValidateNo setY: (form1.height - line.maxY - btnGetValidateNo.height) / 2.0 + line.maxY];
    [btnGetValidateNo setTitleColor: UIColorFromRGB(0xaaaaaa) forState:UIControlStateDisabled];
    [btnGetValidateNo setTitleColor: UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    [btnGetValidateNo setTitleColor: ColorForFunctionButton forState:UIControlStateHighlighted];
    UIImage *btnGetValidateNoImage = [[UIImage imageNamed:@"user_login_form_validatebg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [btnGetValidateNo setBackgroundImage: btnGetValidateNoImage forState: UIControlStateNormal];
    btnGetValidateNo.adjustsImageWhenHighlighted=NO;
    [btnGetValidateNo addTarget: self action: @selector(getValidateNo:) forControlEvents:UIControlEventTouchUpInside];
    
    
    txtValidateNo = [[UITextField alloc] initWithFrame:CGRectMake(iconPassword.maxX + marginTxtWithIcon + 1, line.maxY + 1, form1.width - (form1.width - btnGetValidateNo.x) - iconPassword.maxX - marginTxtWithIcon - 2, form1.height - line.maxY - 2)];
    [form1 addSubview: txtValidateNo];
    txtValidateNo.keyboardType = UIKeyboardTypeNumberPad;
    txtValidateNo.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtValidateNo.placeholder = @"请输入验证码";
    txtValidateNo.delegate = self;
}

- (void) initForm2 {
    int rowCount = 1;
    form2 = [[UIView alloc] initWithFrame: CGRectMake(loginFormMarginRL, form1.maxY + 15, SCREEN_WIDTH - loginFormMarginRL*2, Line_height*rowCount + ((rowCount-1)*borderWidthForForm))];
    UIImage *formBackgroundImage = [[UIImage imageNamed:@"user_login_formbg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, form2.width, form2.height)];
    bgView.image = formBackgroundImage;
    [form2 addSubview: bgView];
    [form2 sendSubviewToBack: bgView];
    form2.IQIgnoreGroup = YES;
    [self.view addSubview: form2];
    
    UIImageView *iconPwd = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_login_icon_password"]];
    [form2 addSubview: iconPwd];
    [iconPwd setY: (form2.height - iconPwd.height) / 2.0];
    iconPwd.x = marginLWithIcon;
    
    
    txtPassword = [[UITextField alloc] initWithFrame:CGRectMake(iconPwd.maxX + marginTxtWithIcon + 1, 1, form2.width - iconPwd.maxX - marginTxtWithIcon - 2, form2.height - 2)];
    txtPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    [form2 addSubview: txtPassword];
    txtPassword.keyboardType = UIKeyboardTypeASCIICapable;
    txtPassword.placeholder = _isFindPwd ? @"设置新密码" : @"设置登录密码";
}

- (void) initRegisterButton {
    btnRegister = [[UIButton alloc] initWithFrame: CGRectMake(form2.x, form2.maxY + loginFormMarginRL + 3, form2.width, 45)];
    [btnRegister setTitle: (_isFindPwd?@"重置密码":@"注册") forState: UIControlStateNormal];
    btnRegister.titleLabel.font = [UIFont systemFontOfSize: 16];
    [btnRegister setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [btnRegister setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3bc2ff)] forState:UIControlStateNormal];
    [btnRegister setBackgroundImage:[CommonUtils createImageWithColor: COL_BLUE] forState:UIControlStateHighlighted];
    
    [btnRegister addTarget: self action: @selector(userRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btnRegister];
}

- (void) initRemark {
    UILabel *contract = [[UILabel alloc] initWithFrame:CGRectMake(btnRegister.x, btnRegister.maxY + loginFormMarginRL, 1, 1)];
    if(!_isFindPwd){
        contract.text = @"点注册，即代表您同意《江海通用户注册条款》";
    }
//    contract.text = [NSString stringWithFormat: @"%@，即代表您同意《江海通用户服务协议》", (self.isFindPwd? @"点重置密码" : @"点注册")];
    contract.userInteractionEnabled=YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside)];
    [contract addGestureRecognizer:labelTapGestureRecognizer];
    contract.font = [UIFont systemFontOfSize: 12];
    contract.textColor = UIColorFromRGB(0x86878B);
    [self.view addSubview: contract];
    [contract sizeToFit];
}
-(void) labelTouchUpInside{
    JHTYongHuXieYiViewController *xiaoxi = [[JHTYongHuXieYiViewController alloc] init];
    [self.navigationController pushViewController:xiaoxi animated: YES];
}
-(IBAction)getValidateNo:(id)sender {
    
    NSString *lastGetValidateNoTime = [USER_DEFAULT objectForKey: UD_KEY_LAST_GETVALIDATENO];
    NSTimeInterval ins = [[NSDate date] timeIntervalSince1970] * 1000;
    if (lastGetValidateNoTime != nil) {
        long second = (ins - [lastGetValidateNoTime longLongValue]) / 1000;
        if (second <= max_second) {
            [self.view makeToast:[NSString stringWithFormat:@"请等待%ld秒后再获取", max_second - second]
                        duration:1.0
                        position:CSToastPositionCenter];
            return;
        }
    }
    
    NSString *phoneNo = txtPhone.text;
    if([CommonUtils checkTelNumber: phoneNo] == NO) {
        [self.view makeToast:@"手机号码格式错误"
                    duration:1.0
                    position:CSToastPositionCenter];
        return;
    }
    [ProgressHUD show: @"正在获取验证码,请稍候..." Interaction: NO];
    // 请求服务器接口获取验证码
    NSString *mobile = txtPhone.text;
    NSString *stype = self.isFindPwd ? @"2" : @"1";
    
    WEAK_SELF
    [[NetHttpClient sharedHTTPClient] request: @"/send_authcode" parameters:@{@"mobile": mobile, @"stype": stype} completion:^(id obj) {
        [ProgressHUD dismiss];
        if (obj) {
            if ([[obj objectForKey:ApiKey_ErrorCode] isEqualToString: @"0"]) {
                [self.view makeToast: @"验证码发送成功" duration: 0.5 position: CSToastPositionCenter];
                id codeid = [obj objectForKey: @"codeid"];
                NSString *codeidStr = [NSString stringWithFormat: @"%@", codeid];
                [USER_DEFAULT setObject: codeidStr forKey: (self.isFindPwd ? UD_KEY_VALIDATENO_ID_FINDPWD : UD_KEY_VALIDATENO_ID)];
                btnGetValidateNo.enabled = NO;
                NSTimeInterval ins = [[NSDate date] timeIntervalSince1970] * 1000;
                NSString *lastGetValidateNoTime = [NSString stringWithFormat: @"%.0f", ins];
                [USER_DEFAULT setObject:lastGetValidateNoTime forKey: UD_KEY_LAST_GETVALIDATENO];
                validateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakself selector:@selector(refValidateBtnTitle:) userInfo:nil repeats:YES];
            } else {
                [self.view makeToast:[NSString stringWithFormat: @"获取验证码失败：%@", [obj objectForKey: @"message"]] duration: 0.5 position:CSToastPositionCenter];
            }
        } else {
            [self.view makeToast:@"连接服务器失败" duration: 0.5 position:CSToastPositionCenter];
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
    NSString *password = txtPassword.text;
    NSString *codeid = [USER_DEFAULT objectForKey: self.isFindPwd ? UD_KEY_VALIDATENO_ID_FINDPWD : UD_KEY_VALIDATENO_ID];
    VALIDATE_NOT_NULL(phoneNo, @"请填写手机号码");
    VALIDATE_NOT_NULL(validateNo, @"请填写验证码");
    VALIDATE_NOT_NULL(codeid, @"验证码已失效，请重新获取");
    VALIDATE_NOT_NULL(password, (self.isFindPwd?@"请输入新密码":@"请设置密码"));
    
    VALIDATE_REGEX(phoneNo, VALREG_MOBILE_PHONE, @"手机号码不正确");
    VALIDATE_REGEX(validateNo, @"\\d{4}", @"验证码不正确");
    VALIDATE_REGEX(password, @"^[\\@A-Za-z0-9\\!\\#\\$\\%\\^\\&\\*\\.\\~]{6,22}$", @"密码至少6位，只能包含数字字母下划线");

    if (_isFindPwd) {
        // 找回密码
        [ProgressHUD show: @"请稍后..." Interaction: NO];
        [[NetHttpClient sharedHTTPClient] request: @"/find_pwd" parameters:@{@"mobile":phoneNo, @"newpwd":[CommonUtils securityPasswd:password], @"new2pwd":[CommonUtils securityPasswd:password], @"code": validateNo, @"codeid": codeid, @"stype": @"2", @"pwd_type":@"1"} completion:^(id obj) {
            [ProgressHUD dismiss];
            if (obj) {
                if ([@"0" isEqualToString:[obj objectForKey:ApiKey_ErrorCode]]) {
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
                [self.view makeToast:@"连接服务器失败" duration: 0.5 position:CSToastPositionCenter];
            }
        }];
    } else {
        // 注册
        [ProgressHUD show: @"请稍后..." Interaction: NO];
        [[NetHttpClient sharedHTTPClient] request: @"/register" parameters:@{@"mobile":phoneNo, @"pwd":[CommonUtils securityPasswd:password], @"code": validateNo, @"codeid": codeid, @"stype": @"1", @"pwd_type": @"1"} completion:^(id obj) {
            [ProgressHUD dismiss];
            if (obj) {
                if ([@"0" isEqualToString:[obj objectForKey:ApiKey_ErrorCode]]) {
                    [USER_DEFAULT removeObjectForKey: UD_KEY_VALIDATENO_ID];
                    [self.navigationController popViewControllerAnimated: YES];
//                    NSData *arc = [NSKeyedArchiver archivedDataWithRootObject: obj];
//                    [USER_DEFAULT setObject: arc forKey: CURRENT_USER_KEY];
                    if (self.success) {
                        self.success(txtPhone.text);
                    }
                    return;
                } else {
                    [self.view makeToast:[NSString stringWithFormat:@"%@", [obj objectForKey:@"message"]] duration: 0.5 position:CSToastPositionCenter];
                }
            } else {
                [self.view makeToast:@"连接服务器失败" duration: 0.5 position:CSToastPositionCenter];
            }
        }];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == txtPhone || textField == txtValidateNo) {
        if (![string isEqualToString: @""]) {
            if (![string isMatch: RX(@"\\d+")]) {
                [self.view makeToast: @"字符不正确" duration: 0.5 position: CSToastPositionCenter];
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
        if (phone.length <= 4) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
