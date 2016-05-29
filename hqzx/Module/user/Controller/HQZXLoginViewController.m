//
//  JHTLoginViewController.m
//  jht
//
//  Created by 孙泽山 on 15/6/24.
//  Copyright (c) 2015年 zthz. All rights reserved.
//
#define lastLoginUserNameKey @"Last_Login_UserName"
#define loginFormMarginRL 17
#define borderWidthForForm 1
#define marginTxtWithIcon 5
#define marginLWithIcon 10
#define ColorForFormLine UIColorFromRGB(0xdfdfde)
#define ColorForFunctionButton UIColorFromRGB(0x5f646e)
#define ColorDownForFunctionButton ColorForFormLine

//#define imName @"xingyuand908"
#define imName @"shao116726834"

#import "JHTLoginViewController.h"
#import "CommonUtils.h"
#import "JHTRegisterViewController.h"
#import "ProgressHUD.h"
#import "NetHttpClient.h"
#import <MobClick.h>
#import "JHTUserModel.h"
#import <JHChainableAnimations.h>
#import <ImSDK/TIMComm.h>
#import <TLSSDK/TLSHelper.h>
#import <ImSDK/TIMManager.h>
#import "GlobalData.h"
#import "FriendshipManager.h"

@interface JHTLoginViewController () {
    
    
    UIView *form;
    UITextField *txtUserName;
    UITextField *txtPassword;
    UIButton *btnLogin;
    UIButton *btnRegister;
    UIButton *btnForgetPwd;
    UIButton *btnCancel;
}
@end

@implementation JHTLoginViewController

+ (UINavigationController*) getLoginController {
    JHTLoginViewController *loginController = [[JHTLoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController: loginController];
    [CommonUtils setNavigationControllerStyle: nav];
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    return nav;
}
-(NSString *)pageName {
    return @"登录页";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xEEEFF1);
    self.title = @"登录江海通";
    // Do any additional setup after loading the view.
    [self initLoginForm];
    [self initFunctions];
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
}

-(void) initLoginForm {
    form = [[UIView alloc] initWithFrame: CGRectMake(loginFormMarginRL, TOP_HEIGHT + 25, SCREEN_WIDTH - loginFormMarginRL*2, 111)];
    UIImage *formBackgroundImage = [[UIImage imageNamed:@"user_login_formbg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, form.width, form.height)];
    bgView.image = formBackgroundImage;
    [form addSubview: bgView];
    [form sendSubviewToBack: bgView];
    [self.view addSubview: form];
    
    UIView *line = [[UIView alloc] initWithFrame: CGRectMake(borderWidthForForm, form.height / 2, form.width-2, borderWidthForForm)];
    line.backgroundColor = ColorForFormLine;
    [form addSubview: line];
    
    UIImageView *iconUsername = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_login_icon_username"]];
    [form addSubview:iconUsername];
    [iconUsername setY: (form.height - line.y - iconUsername.height) / 2.0];
    iconUsername.x = marginLWithIcon;
    
    txtUserName = [[UITextField alloc] initWithFrame:CGRectMake(iconUsername.maxX + marginTxtWithIcon + 1, 1, form.width - iconUsername.maxX - marginTxtWithIcon - COMMON_H_MARGIN, form.height - line.y - 2)];
    txtUserName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [form addSubview: txtUserName];
    txtUserName.keyboardType = UIKeyboardTypeNumberPad;
    txtUserName.placeholder = @"注册的手机号";
    NSString *remindUserName = [USER_DEFAULT objectForKey:lastLoginUserNameKey];
    if (remindUserName != nil && [remindUserName isNotEmpty]) {
        txtUserName.text = remindUserName;
    }
    
    
    UIImageView *iconPassword = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_login_icon_password"]];
    [form addSubview: iconPassword];
    [iconPassword setY: (form.height - line.maxY - iconPassword.height) / 2.0 + line.maxY];
    iconPassword.x = marginLWithIcon;
    
    txtPassword = [[UITextField alloc] initWithFrame:CGRectMake(iconPassword.maxX + marginTxtWithIcon + 1, line.maxY + 1, form.width - iconPassword.maxX - marginTxtWithIcon - COMMON_H_MARGIN, (form.height - line.maxY) - 2)];
    [form addSubview: txtPassword];
    txtPassword.secureTextEntry = YES;
    txtPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtPassword.placeholder = @"请输入密码";
    
    btnLogin = [[UIButton alloc] initWithFrame: CGRectMake(form.x, form.maxY + loginFormMarginRL + 3, form.width, 45)];
    [btnLogin setTitle: @"登录" forState: UIControlStateNormal];
    btnLogin.titleLabel.font = [UIFont systemFontOfSize: 16];
    [btnLogin setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [btnLogin setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3bc2ff)] forState:UIControlStateNormal];
    [btnLogin setBackgroundImage:[CommonUtils createImageWithColor: COL_BLUE] forState:UIControlStateHighlighted];
    
    [btnLogin addTarget: self action: @selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btnLogin];
}

-(void) initFunctions {
    btnRegister = [[UIButton alloc] initWithFrame: CGRectMake(form.x, btnLogin.maxY + loginFormMarginRL / 2.0 * 1.0, 1, 1)];
    [btnRegister setTitle:@"快速注册" forState: UIControlStateNormal];
    [self.view addSubview: btnRegister];
    [btnRegister sizeToFit];
    btnRegister.titleLabel.font = [UIFont systemFontOfSize: 14];
    [btnRegister setTitleColor: ColorForFunctionButton forState: UIControlStateNormal];
    [btnRegister setTitleColor: ColorDownForFunctionButton forState: UIControlStateHighlighted];
    [btnRegister addTarget: self action: @selector(userRegister:) forControlEvents:UIControlEventTouchUpInside];
    
    
    btnForgetPwd = [[UIButton alloc] initWithFrame: CGRectMake(0, btnRegister.y, 1, 1)];
    [btnForgetPwd setTitle:@"忘记密码" forState: UIControlStateNormal];
    [self.view addSubview: btnForgetPwd];
    [btnForgetPwd sizeToFit];
    btnForgetPwd.titleLabel.font = [UIFont systemFontOfSize: 14];
    [btnForgetPwd setTitleColor: ColorForFunctionButton forState: UIControlStateNormal];
    [btnForgetPwd setTitleColor: ColorDownForFunctionButton forState: UIControlStateHighlighted];
    [btnForgetPwd setX: (SCREEN_WIDTH - loginFormMarginRL - btnForgetPwd.width)];
    [btnForgetPwd addTarget: self action: @selector(userFindPwd:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    btnCancel = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 1, 1)];
    [btnCancel setTitle:@"放弃登录" forState: UIControlStateNormal];
    [self.view addSubview: btnCancel];
    [btnCancel sizeToFit];
    btnCancel.titleLabel.font = [UIFont systemFontOfSize: 14];
    [btnCancel addTarget: self action: @selector(cancelLogin) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setTitleColor: ColorForFunctionButton forState: UIControlStateNormal];
    [btnCancel setTitleColor: ColorDownForFunctionButton forState: UIControlStateHighlighted];
    [btnCancel setX: (SCREEN_WIDTH - loginFormMarginRL - btnForgetPwd.width)];
    [btnCancel setY: (self.view.height - btnForgetPwd.height - 10)];
}

-(void) login {
    WEAK_SELF
    NSString *phoneNo = txtUserName.text;
    NSString *password = txtPassword.text;
    VALIDATE_NOT_NULL(phoneNo, @"请输入手机号码");
    VALIDATE_NOT_NULL(password, @"请输入密码");
    
    VALIDATE_REGEX(phoneNo, VALREG_MOBILE_PHONE, @"手机号码不正确");
//    VALIDATE_REGEX(password, @"[x00-xff]{8,100}", @"密码至少8位，不能包含汉字");
    
    
    [ProgressHUD show: @"请稍后..." Interaction: NO];
    [[JHTUserModel sharedInstance] login: phoneNo pwd: password completion:^(id obj) {
        [ProgressHUD dismiss];
        if (obj == nil) {
            [self.view makeToast:@"连接服务器失败" duration: 0.5 position:CSToastPositionCenter];
            return;
        }
        if ([obj isKindOfClass: [NSString class]]) {
            [self.view makeToast:obj duration: 0.5 position:CSToastPositionCenter];
            return;
        }
        [self cloudLanding];
        
        [self.navigationController popViewControllerAnimated: YES];
        
        [USER_DEFAULT setObject: phoneNo forKey: lastLoginUserNameKey];
        [weakself dismissViewControllerAnimated: YES completion:^{
            if (weakself.successBlock) {
                weakself.successBlock();
            }
        }];
    }];
    
}
- (void)cloudLanding{
    JHTUser *currentUser = [JHTUserModel sharedInstance].currentUser;
    [[NetHttpClient sharedHTTPClient] request:@"/qcloud_get_usersig" parameters:@{@"uid":currentUser.userId} completion:^(id obj) {
        ServerError(obj, self.view);
        ApiResultMakToastIfError(self.view,  obj);
        
        NSString *myaccount = StrValueFromDictionary(obj, @"account");
        NSString *myUserSig = StrValueFromDictionary(obj, @"usersig");
        
        [GlobalData shareInstance].accountHelper = [AccountHelper sharedInstance];
        [GlobalData shareInstance].friendshipManager = [FriendshipManager sharedInstance];
        
        TIMLoginParam *param = [[TIMLoginParam alloc ]init];
        param.userSig = myUserSig;
        [[TIMManager sharedInstance] log:TIM_LOG_DEBUG tag:@"createParam get usersig is " msg:[NSString stringWithFormat:@"%@",param.userSig]];
        param.identifier = myaccount;
        param.appidAt3rd = [@kTLSAppid stringValue];
        param.accountType = [NSString stringWithFormat:@"%d", kSdkAccountType];
        param.sdkAppId = kSdkAppId;
        MyTLSUIViewController *tlsView = [[MyTLSUIViewController alloc]init];
        [tlsView TIMLogin:param];
    }];
}
//- (void)cloudLanding
//{

//}
-(IBAction) userRegister:(id) sender{
    JHTRegisterViewController *userRegister = [[JHTRegisterViewController alloc] init];
    userRegister.success = ^(id phoneNo) {
        [self.view makeToast:@"注册成功" duration:1 position:CSToastPositionCenter];
        txtUserName.text = phoneNo;
        [txtPassword becomeFirstResponder];
    };
    [self.navigationController pushViewController: userRegister animated: YES];
}
-(IBAction)userFindPwd:(id)sender {
    JHTRegisterViewController *userRegister = [[JHTRegisterViewController alloc] initWithPhoneNo: txtUserName.text];
    userRegister.isFindPwd = YES;
    userRegister.success = ^(id phoneNo) {
        [self.view makeToast:@"密码重置成功" duration:1 position:CSToastPositionCenter];
        txtUserName.text = phoneNo;
        [txtPassword becomeFirstResponder];
    };
    [self.navigationController pushViewController: userRegister animated: YES];
}
-(void) cancelLogin {
    [self dismissViewControllerAnimated: YES completion:^{
        if(_cancelBlock) {
            _cancelBlock();
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    // 关系到y坐标，因为在viewDidLoad方法里获得的self.view.height值不准确（导航条的原因），所以放到这里重新调整一下
//    [btnCancel setY: (self.view.height - btnForgetPwd.height - 10)];
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
