//
//  HQZXLoginViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/25.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//
#define loginFormMarginRL 17
#define borderWidthForForm 1
#define marginTxtWithIcon 5
#define marginLWithIcon 10
#define ColorForFormLine UIColorFromRGB(0xdfdfde)
#define ColorForFunctionButton UIColorFromRGB(0x5f646e)
#define ColorDownForFunctionButton ColorForFormLine

#import "HQZXLoginViewController.h"
#import "CommonUtils.h"
#import "HQZXRegisterViewController.h"
#import "ProgressHUD.h"
#import "NetHttpClient.h"
//#import <MobClick.h>
#import "HQZXUserModel.h"
#import <JHChainableAnimations.h>


@interface HQZXLoginViewController () {
    
    
    UIView *form;
    UITextField *txtUserName;
    UITextField *txtPassword;
    UIButton *btnLogin;
    UIButton *btnRegister;
    UIButton *btnForgetPwd;
    UIButton *btnCancel;
    UIImageView *iconLianText;
    UITextField *txtLianText;
    HQZXCountry *commitCountry;
}
@end

@implementation HQZXLoginViewController

+ (UINavigationController*) getLoginController {
    HQZXLoginViewController *loginController = [[HQZXLoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController: loginController];
    [CommonUtils setNavigationControllerStyle: nav];
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    return nav;
}
//-(NSString *)pageName {
//    return @"登录页";
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    self.title = LocatizedStirngForkey(@"DENGLU");
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] init];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 80, 44);
    [backBtn setTintColor:[UIColor whiteColor]];
    [backBtn setTitle:LocatizedStirngForkey(@"FANHUI") forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [backBtn setTitleColor:UIColorFromRGB(0x439AFE) forState:UIControlStateNormal];
    UIImage *leftBtnImage = [UIImage imageNamed:@"icon_back_chevron"];
    [backBtn setImage:leftBtnImage forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake((backBtn.frame.size.height-leftBtnImage.size.height)/2,SCREEN_WIDTH/30,(backBtn.frame.size.height-leftBtnImage.size.height)/2,80-leftBtnImage.size.width-SCREEN_WIDTH/30);
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [backBarButtonItem setCustomView:backBtn];
    UIBarButtonItem *negativeSpacers = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacers.width = -15;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacers, backBarButtonItem, nil];
    
//    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    UIButton *zhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zhuBtn.frame = CGRectMake(0, 0, 60, 44);
    [zhuBtn setTintColor:[UIColor whiteColor]];
    [zhuBtn setTitle:LocatizedStirngForkey(@"ZHUCE") forState:UIControlStateNormal];
    zhuBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [zhuBtn setTitleColor:UIColorFromRGB(0x439AFE) forState:UIControlStateNormal];
    [zhuBtn addTarget:self action:@selector(userRegister:) forControlEvents:UIControlEventTouchUpInside];
    
    [temporaryBarButtonItem setCustomView:zhuBtn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -12;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, temporaryBarButtonItem, nil];
//    self.navigationItem.rightBarButtonItem = temporaryBarButtonItem;
    
    
    // Do any additional setup after loading the view.
    [self initLoginForm];
    [self initFunctions];
    
//    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
//    temporaryBarButtonItem.title = @"返回";
//    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
}
-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    return CGRectMake(SCREEN_WIDTH/6, 0, SCREEN_WIDTH-SCREEN_WIDTH/6, SCREEN_WIDTH/8);
}
-(void) initLoginForm {
    form = [[UIView alloc] initWithFrame: CGRectMake(0, TOP_HEIGHT + SCREEN_WIDTH/10, SCREEN_WIDTH, SCREEN_WIDTH/4*1.5)];
    [form setBackgroundColor:UIColorFromRGB(0x293035)];
    [self.view addSubview: form];
    
    UIView *line = [[UIView alloc] initWithFrame: CGRectMake(borderWidthForForm, form.height / 3, form.width-2, borderWidthForForm)];
    UIView *line1 = [[UIView alloc] initWithFrame: CGRectMake(borderWidthForForm, form.height / 3*2, form.width-2, borderWidthForForm)];
    line.backgroundColor = UIColorFromRGB(0x0C1319);
    line1.backgroundColor = UIColorFromRGB(0x0C1319);
    [form addSubview: line];
    [form addSubview: line1];
    
    iconLianText = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_country"]];
    [form addSubview: iconLianText];
    [iconLianText setY: (form.height/3 - iconLianText.height) / 2.0];
    iconLianText.x = SCREEN_WIDTH/20;
    
    txtLianText = [[UITextField alloc] initWithFrame:CGRectMake(iconLianText.maxX + SCREEN_WIDTH/30 , 0, form.width - iconLianText.maxX - SCREEN_WIDTH/30 -SCREEN_WIDTH/8, form.height/3)];
    [form addSubview: txtLianText];
    [txtLianText setEnabled:NO];
    txtLianText.textColor = UIColorFromRGB(0x767D85);
    txtLianText.font = [UIFont systemFontOfSize:REGISTERFONTONE];
    txtLianText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    txtLianText.placeholder = LocatizedStirngForkey(@"GUOJIA");
    //    [txtLianText setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
    //    [txtLianText setValue:[UIFont systemFontOfSize:REGISTERFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style = [txtLianText.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = txtLianText.font.lineHeight - (txtLianText.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtLianText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"GUOJIA")
                                                                        attributes:@{
                                                                                     NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:REGISTERFONTONE],
                                                                                     NSParagraphStyleAttributeName : style
                                                                                     }];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(txtLianText.maxX, 0, SCREEN_WIDTH/8, form.height/3);
    [backBtn setTintColor:[UIColor whiteColor]];
    [backBtn setTitleColor:UIColorFromRGB(0x293035) forState:UIControlStateNormal];
    UIImage *leftBtnImage = [UIImage imageNamed:@"icon_jt_bo_bl"];
    [backBtn setImage:leftBtnImage forState:UIControlStateNormal];
    [form addSubview: backBtn];
    
    UIView *clickView = [[UIView alloc]initWithFrame:CGRectMake(iconLianText.maxX + SCREEN_WIDTH/30, 0 , form.width - iconLianText.maxX - SCREEN_WIDTH/30, form.height/3-1)];
    clickView.userInteractionEnabled = YES;
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCountry)];
    
    [clickView addGestureRecognizer:tapGesture];
    [form addSubview: clickView];
    
//    [backBtn addTarget:self action:@selector(createCover) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *iconUsername = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_phone"]];
    [form addSubview:iconUsername];
    [iconUsername setY: (form.height/3 - iconUsername.height) / 2.0+line.maxY];
    iconUsername.x = SCREEN_WIDTH/20;
    
    txtUserName = [[UITextField alloc] initWithFrame:CGRectMake(iconUsername.maxX + SCREEN_WIDTH/40 + 1, line.maxY+1, form.width - iconUsername.maxX - marginTxtWithIcon - COMMON_H_MARGIN, form.height/3-1)];
    txtUserName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [form addSubview: txtUserName];
    txtUserName.textColor = UIColorFromRGB(0x767D85);
    txtUserName.font = [UIFont systemFontOfSize:REGISTERFONTONE];
    txtUserName.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    txtUserName.placeholder = LocatizedStirngForkey(@"SHOUJIHAOMA");
//    [txtUserName setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
//    [txtUserName setValue:[UIFont systemFontOfSize:LOGINFONTONE]forKeyPath:@"_placeholderLabel.font"];
    NSMutableParagraphStyle *style3 = [txtUserName.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style3.minimumLineHeight = txtUserName.font.lineHeight - (txtUserName.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"SHOUJIHAOMA")
                                                                        attributes:@{
                                                                                     NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:LOGINFONTONE],
                                                                                     NSParagraphStyleAttributeName : style3
                                                                                     }];
    NSString *remindUserName = [USER_DEFAULT objectForKey:lastLoginUserNameKey];
    if (remindUserName != nil && [remindUserName isNotEmpty]) {
        txtUserName.text = remindUserName;
    }
    
    
    UIImageView *iconPassword = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_secret"]];
    [form addSubview: iconPassword];
    [iconPassword setY: (form.height/3 - iconPassword.height) / 2.0 + line1.maxY];
    iconPassword.x = SCREEN_WIDTH/20;
    
    txtPassword = [[UITextField alloc] initWithFrame:CGRectMake(iconUsername.maxX + SCREEN_WIDTH/40 + 1, line1.maxY + 1, form.width - iconPassword.maxX - marginTxtWithIcon - COMMON_H_MARGIN, form.height/3-1)];
    [form addSubview: txtPassword];
    txtPassword.secureTextEntry = YES;
    txtPassword.textColor = UIColorFromRGB(0x767D85);
    txtPassword.font = [UIFont systemFontOfSize:REGISTERFONTONE];
    txtPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
//    txtPassword.placeholder = LocatizedStirngForkey(@"MIMA");
//    [txtPassword setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
//    [txtPassword setValue:[UIFont systemFontOfSize:LOGINFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *styles = [txtPassword.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    styles.minimumLineHeight = txtPassword.font.lineHeight - (txtPassword.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"MIMA")
                                                                        attributes:@{
                                                                                     NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:LOGINFONTONE],
                                                                                     NSParagraphStyleAttributeName : styles
                                                                                     }];
    
    btnLogin = [[UIButton alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/20, form.maxY + SCREEN_WIDTH/10, SCREEN_WIDTH-SCREEN_WIDTH/10, SCREEN_WIDTH/8)];
    [btnLogin setTitle: LocatizedStirngForkey(@"DENGLU") forState: UIControlStateNormal];
    btnLogin.titleLabel.font = [UIFont systemFontOfSize: LOGINFONTBUTONE];
    [btnLogin.layer setMasksToBounds:YES];
    [btnLogin.layer setCornerRadius:5.0];
    [btnLogin setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [btnLogin setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3178E3)] forState:UIControlStateNormal];
    [btnLogin setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3A5FCD)] forState:UIControlStateHighlighted];
    
    [btnLogin addTarget: self action: @selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btnLogin];
}
-(void)selectCountry{
    HQZXSelectCountryForm *selectCountForm = [[HQZXSelectCountryForm alloc] initWithPlaceHolder: LocatizedStirngForkey(@"XUANZEGUOJIA")];
    __weak typeof(selectCountForm) weakSelectForm = selectCountForm;
    weakSelectForm.beSureComp = HQZXSelectCountryComp() {
        [weakSelectForm hideAction:^{
            commitCountry = COUNTRY;
            NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
            if([language isEqualToString:@"zh-Hans"]){
                txtLianText.text = COUNTRY.country_name;
            }else if([language isEqualToString:@"en"]){
                txtLianText.text = COUNTRY.country_ename;
            }
            
        }];
    };
    [weakSelectForm showAction];
}
-(void) initFunctions {
    UILabel *iponeLab = [[UILabel alloc]initWithFrame: CGRectMake(form.x, btnLogin.maxY + SCREEN_WIDTH/30 , 1, 1)];
    [self.view addSubview: iponeLab];
    iponeLab.text = LocatizedStirngForkey(@"KEFUDIANHUA");
    [iponeLab sizeToFit];
    iponeLab.textAlignment = NSTextAlignmentCenter;
    [iponeLab setX:(SCREEN_WIDTH-iponeLab.width)/2];
    iponeLab.font = [UIFont systemFontOfSize:LOGINFONTTWO];
    iponeLab.textColor = UIColorFromRGB(0x8B959B);
    
    btnForgetPwd = [[UIButton alloc] initWithFrame: CGRectMake(0, SCREEN_HEIGHT-SCREEN_HEIGHT/12, 1, 1)];
    [btnForgetPwd setTitle:LocatizedStirngForkey(@"WANGJIMIMA") forState: UIControlStateNormal];
    [self.view addSubview: btnForgetPwd];
    [btnForgetPwd sizeToFit];
    btnForgetPwd.titleLabel.font = [UIFont systemFontOfSize: LOGINFONTTWO];
    [btnForgetPwd setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [btnForgetPwd setTitleColor: ColorDownForFunctionButton forState: UIControlStateHighlighted];
    [btnForgetPwd setX: (SCREEN_WIDTH -btnForgetPwd.width)/2];
    [btnForgetPwd addTarget: self action: @selector(userFindPwd:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) login {
    WEAK_SELF
    NSString *phoneNo = txtUserName.text;
    NSString *password = txtPassword.text;
    VALIDATE_NOT_NULL(phoneNo, LocatizedStirngForkey(@"QINGTIANXIESHOUJIHAOMA"));
    VALIDATE_NOT_NULL(password, LocatizedStirngForkey(@"QINGSHURUMIMA"));
    
    if(!commitCountry.country_id){
        [self.view makeToast: LocatizedStirngForkey(@"QINGXUANZEGUOJIA") duration: 0.5 position: CSToastPositionCenter];
        return;
    }
    
    
    VALIDATE_REGEX(phoneNo, VALREG_MOBILE_PHONE, LocatizedStirngForkey(@"SHOUJIHAOMAGESHICUOWU"));
//    VALIDATE_REGEX(password, @"[x00-xff]{8,100}", @"密码至少8位，不能包含汉字");
    
    
    [ProgressHUD show: [NSString stringWithFormat:@"%@...",LocatizedStirngForkey(@"QINGDENGDAI")] Interaction: NO];
    [[HQZXUserModel sharedInstance] login: phoneNo pwd: password country:commitCountry.country_id completion:^(id obj) {
        [ProgressHUD dismiss];
        if (obj == nil) {
            [self.view makeToast:LocatizedStirngForkey(@"LIANJIEFUWUQISHIBAI") duration: 0.5 position:CSToastPositionCenter];
            return;
        }
        if ([obj isKindOfClass: [NSString class]]) {
            [self.view makeToast:obj duration: 0.5 position:CSToastPositionCenter];
            return;
        }
//        [self cloudLanding];
        
//        [self.navigationController popViewControllerAnimated: YES];
        
        [USER_DEFAULT setObject: phoneNo forKey: lastLoginUserNameKey];
        [weakself dismissViewControllerAnimated: YES completion:^{
            if (weakself.cancellationBlock) {
                weakself.cancellationBlock();
            }
            if (weakself.successBlock) {
                weakself.successBlock();
            }
        }];
    }];
    
}

//- (void)cloudLanding
//{

//}
-(IBAction) back:(id) sender{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:@"0" forKey:@"selectPlu"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLanguage"
                                                        object:self
                                                      userInfo:parameter];
    [self dismissViewControllerAnimated: YES completion:nil];
}
-(IBAction) userRegister:(id) sender{
    HQZXRegisterViewController *userRegister = [[HQZXRegisterViewController alloc] init];
    userRegister.success = ^(id phoneNo) {
        [self.view makeToast:LocatizedStirngForkey(@"ZHUCECHENGGONG") duration:1 position:CSToastPositionCenter];
        txtUserName.text = phoneNo;
        [txtPassword becomeFirstResponder];
    };
    [self.navigationController pushViewController: userRegister animated: YES];
}
-(IBAction)userFindPwd:(id)sender {
    HQZXForgetPasswordViewController *userFind = [[HQZXForgetPasswordViewController alloc] initWithPhoneNo: txtUserName.text];
//    userRegister.isFindPwd = YES;
//    userRegister.success = ^(id phoneNo) {
//        [self.view makeToast:@"密码重置成功" duration:1 position:CSToastPositionCenter];
//        txtUserName.text = phoneNo;
//        [txtPassword becomeFirstResponder];
//    };
    [self.navigationController pushViewController: userFind animated: YES];
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
