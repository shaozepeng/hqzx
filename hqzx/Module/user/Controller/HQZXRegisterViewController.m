//
//  JHTRegisterViewController.m
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
#import "HQZXRegisterViewController.h"
#import "IQUIView+IQIgnoreGroup.h"
#import <UIView+Toast.h>

@interface HQZXRegisterViewController () {
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
    UIImageView *iconLianText;
    BOOL isImageBool;
    HQZXCountry *commitCountry;
    NSString *codeType;
}
@end

@implementation HQZXRegisterViewController

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
    self.title = LocatizedStirngForkey(@"ZHUCE");
    isImageBool = YES;
    _isFindPwd = NO;

    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    [self initForm1];
    [self setIsEnabledForBtnValidateNo];
    [self initForm2];
    [self initRegisterButton];
    [self initRemark];

}

- (void) initForm1 {
    form1 = [[UIView alloc] initWithFrame: CGRectMake(0, TOP_HEIGHT + SCREEN_WIDTH/10, SCREEN_WIDTH , SCREEN_WIDTH/2*1.25)];
    [form1 setBackgroundColor:UIColorFromRGB(0x293035)];
    [self.view addSubview: form1];
    
    
    UIView *line = [[UIView alloc] initWithFrame: CGRectMake(0, form1.height / 5, SCREEN_WIDTH, borderWidthForForm)];
    line.backgroundColor = UIColorFromRGB(0x0C1319);
    
    UIView *line2 = [[UIView alloc] initWithFrame: CGRectMake(0, form1.height / 5*2, SCREEN_WIDTH, borderWidthForForm)];
    line.backgroundColor = UIColorFromRGB(0x0C1319);
    
    UIView *line3 = [[UIView alloc] initWithFrame: CGRectMake(0, form1.height / 5 *3, SCREEN_WIDTH, borderWidthForForm)];
    UIView *line4 = [[UIView alloc] initWithFrame: CGRectMake(0, form1.height / 5 *4, SCREEN_WIDTH, borderWidthForForm)];
    line.backgroundColor = UIColorFromRGB(0x0C1319);
    line2.backgroundColor = UIColorFromRGB(0x0C1319);
    line3.backgroundColor = UIColorFromRGB(0x0C1319);
    line4.backgroundColor = UIColorFromRGB(0x0C1319);
    [form1 addSubview: line];
    [form1 addSubview: line2];
    [form1 addSubview: line3];
    [form1 addSubview: line4];
    
//    UIView *userNameView = [[UIView alloc] initWithFrame: CGRectMake(borderWidthForForm, borderWidthForForm, form1.width - borderWidthForForm*2, (form1.height - borderWidthForForm*2 - line.height)/2)];
//    [form1 addSubview:userNameView];
    
    
    iconLianText = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lock"]];
    [form1 addSubview: iconLianText];
    [iconLianText setY: (form1.height/5 - iconLianText.height) / 2.0];
    iconLianText.x = SCREEN_WIDTH/20;
    
    txtLianText = [[UITextField alloc] initWithFrame:CGRectMake(iconLianText.maxX + SCREEN_WIDTH/30 , 0, form1.width - iconLianText.maxX - SCREEN_WIDTH/30 -SCREEN_WIDTH/8, form1.height/5)];
    [form1 addSubview: txtLianText];
    txtLianText.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtLianText.textColor = UIColorFromRGB(0x767D85);
    txtLianText.font = [UIFont systemFontOfSize:REGISTERFONTONE];
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
    backBtn.frame = CGRectMake(txtLianText.maxX , 0, SCREEN_WIDTH/8, form1.height/5);
    [backBtn setTintColor:[UIColor whiteColor]];
    [backBtn setTitleColor:UIColorFromRGB(0x293035) forState:UIControlStateNormal];
    UIImage *leftBtnImage = [UIImage imageNamed:@"icon_jt_bo_bl"];
    [backBtn setImage:leftBtnImage forState:UIControlStateNormal];
    [form1 addSubview: backBtn];
    
    UIView *clickView = [[UIView alloc]initWithFrame:CGRectMake(iconLianText.maxX + SCREEN_WIDTH/30, 0 , form1.width - iconLianText.maxX - SCREEN_WIDTH/30, form1.height/5-1)];
    clickView.userInteractionEnabled = YES;
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCountry)];
    
    [clickView addGestureRecognizer:tapGesture];
    [form1 addSubview: clickView];
    
    btnGetValidateNo = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 1, 1)];
    btnGetValidateNo.enabled = NO;
    [btnGetValidateNo setTitle:LocatizedStirngForkey(@"HUOQUYANZHENGMA") forState: UIControlStateNormal];
    btnGetValidateNo.titleLabel.font = [UIFont systemFontOfSize: REGISTERFONTFORE];
    [form1 addSubview: btnGetValidateNo];
    [btnGetValidateNo sizeToFit];
    [btnGetValidateNo setH:btnGetValidateNo.height*0.8];
    [btnGetValidateNo adjustW: 22 andH: 8];
    [btnGetValidateNo.layer setBorderWidth:1.0];
    [btnGetValidateNo.layer setCornerRadius:5.0];
    [btnGetValidateNo.layer setBorderColor:UIColorFromRGB(0x3E87FA).CGColor];
    [btnGetValidateNo setX: (form1.width - btnGetValidateNo.width - 6)];
    [btnGetValidateNo setY: (form1.height/5 -btnGetValidateNo.height) / 2.0+line.maxY ];
    [btnGetValidateNo setTitleColor: UIColorFromRGB(0x3E87FA) forState:UIControlStateDisabled];
    [btnGetValidateNo setTitleColor: UIColorFromRGB(0x87CEFA) forState:UIControlStateNormal];
    [btnGetValidateNo setTitleColor: UIColorFromRGB(0x2254A6) forState:UIControlStateHighlighted];
    UIImage *btnGetValidateNoImage = [[UIImage imageNamed:@"user_login_form_validatebg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [btnGetValidateNo setBackgroundImage: btnGetValidateNoImage forState: UIControlStateNormal];
    btnGetValidateNo.adjustsImageWhenHighlighted=NO;
    [btnGetValidateNo addTarget: self action: @selector(getValidateNo:) forControlEvents:UIControlEventTouchUpInside];

    UIImageView *iconPhone = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_phone"]];
    [form1 addSubview: iconPhone];
    [iconPhone setY: (form1.height/5 - iconPhone.height) / 2.0+line.maxY];
    iconPhone.x = SCREEN_WIDTH/20;
    
    txtPhone = [[US2ValidatorTextField alloc] initWithFrame:CGRectMake(iconLianText.maxX + SCREEN_WIDTH/30, line.maxY+1, form1.width -(form1.width - btnGetValidateNo.x)- iconLianText.maxX - SCREEN_WIDTH/30 - 2, form1.height/5 - 1)];
    txtPhone.clearButtonMode = UITextFieldViewModeWhileEditing;
    US2Validator *validator = [[US2Validator alloc] init];
    US2ConditionNumeric *numCondition = [[US2ConditionNumeric alloc] init];
    US2ConditionRange *rangeCondition = [[US2ConditionRange alloc] init];
    rangeCondition.range = NSMakeRange(11, 11);
    US2ConditionAnd *phoneCondition = [[US2ConditionAnd alloc] initWithConditionOne:numCondition two: rangeCondition];
    [validator addCondition:phoneCondition];
    txtPhone.validator = validator;
    phoneCondition.shouldAllowViolation = YES;
    txtPhone.textColor = UIColorFromRGB(0x767D85);
    txtPhone.font = [UIFont systemFontOfSize:REGISTERFONTONE];
    txtPhone.shouldAllowViolations   = YES;
    txtPhone.validateOnFocusLossOnly = NO;
    txtPhone.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtPhone.validatorUIDelegate = self;
    if ([initPhoneNo isNotEmpty]) {
        txtPhone.text = initPhoneNo;
    }
    
    [form1 addSubview: txtPhone];
    txtPhone.keyboardType = UIKeyboardTypeNumberPad;
//    txtPhone.placeholder = LocatizedStirngForkey(@"SHOUJIHAOMA");
//    [txtPhone setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
//    [txtPhone setValue:[UIFont systemFontOfSize:REGISTERFONTONE]forKeyPath:@"_placeholderLabel.font"];

    NSMutableParagraphStyle *style2 = [txtPhone.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style2.minimumLineHeight = txtPhone.font.lineHeight - (txtPhone.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtPhone.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"SHOUJIHAOMA")
                                                                        attributes:@{
                                                                                     NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:REGISTERFONTONE],
                                                                                     NSParagraphStyleAttributeName : style2
                                                                                     }];
    
    
    UIImageView *iconPassword = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lock"]];
    [form1 addSubview: iconPassword];
    form1.IQIgnoreGroup = YES;
    [iconPassword setY: (form1.height/5 - iconPassword.height) / 2.0 + line2.maxY];
    iconPassword.x = SCREEN_WIDTH/20;
    
    
    txtValidateNo = [[UITextField alloc] initWithFrame:CGRectMake(iconLianText.maxX + SCREEN_WIDTH/30, line2.maxY + 1, form1.width  - iconLianText.maxX - SCREEN_WIDTH/30 - 2, form1.height/5 - 1)];
    [form1 addSubview: txtValidateNo];
    txtValidateNo.keyboardType = UIKeyboardTypeNumberPad;
    txtValidateNo.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtValidateNo.textColor = UIColorFromRGB(0x767D85);
    txtValidateNo.font = [UIFont systemFontOfSize:REGISTERFONTONE];
//    txtValidateNo.placeholder = LocatizedStirngForkey(@"QINGSHURUYANZHENGMA");
//    [txtValidateNo setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
//    [txtValidateNo setValue:[UIFont systemFontOfSize:REGISTERFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style3 = [txtValidateNo.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style3.minimumLineHeight = txtValidateNo.font.lineHeight - (txtValidateNo.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtValidateNo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"QINGSHURUYANZHENGMA")
                                                                     attributes:@{
                                                                                  NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                  NSFontAttributeName : [UIFont systemFontOfSize:REGISTERFONTONE],
                                                                                  NSParagraphStyleAttributeName : style3
                                                                                  }];
    
    txtValidateNo.delegate = self;
    
    UIImageView *iconDengPassword = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lock"]];
    [form1 addSubview: iconDengPassword];
    [iconDengPassword setY: (form1.height /5 - iconDengPassword.height) / 2.0 + line3.maxY];
    iconDengPassword.x = SCREEN_WIDTH/20;
    
    txtDengPassword = [[UITextField alloc] initWithFrame:CGRectMake(iconLianText.maxX + SCREEN_WIDTH/30, line3.maxY + 1, form1.width - iconLianText.maxX - SCREEN_WIDTH/30 - 2,form1.height/5 - 1)];
    [form1 addSubview: txtDengPassword];
    txtDengPassword.secureTextEntry = YES;
    txtDengPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtDengPassword.textColor = UIColorFromRGB(0x767D85);
    txtDengPassword.font = [UIFont systemFontOfSize:REGISTERFONTONE];
//    txtDengPassword.placeholder = LocatizedStirngForkey(@"DENGLUMIMA");
//    [txtDengPassword setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
//    [txtDengPassword setValue:[UIFont systemFontOfSize:REGISTERFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style4 = [txtDengPassword.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style4.minimumLineHeight = txtDengPassword.font.lineHeight - (txtDengPassword.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtDengPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"DENGLUMIMA")
                                                                          attributes:@{
                                                                                       NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                       NSFontAttributeName : [UIFont systemFontOfSize:REGISTERFONTONE],
                                                                                       NSParagraphStyleAttributeName : style4
                                                                                       }];
    
    
    UIImageView *iconQuePassword = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lock"]];
    [form1 addSubview: iconQuePassword];
    [iconQuePassword setY: (form1.height/5 - iconQuePassword.height) / 2.0 + line4.maxY];
    iconQuePassword.x = SCREEN_WIDTH/20;
    
    txtQuePassword = [[UITextField alloc] initWithFrame:CGRectMake(iconLianText.maxX + SCREEN_WIDTH/30, line4.maxY + 1, form1.width - iconLianText.maxX - SCREEN_WIDTH/30 - 2, form1.height/5 - 1)];
    [form1 addSubview: txtQuePassword];
    txtQuePassword.secureTextEntry = YES;
    txtQuePassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtQuePassword.textColor = UIColorFromRGB(0x767D85);
    txtQuePassword.font = [UIFont systemFontOfSize:REGISTERFONTONE];
//    txtQuePassword.placeholder = LocatizedStirngForkey(@"QUERENMIMA");
//    [txtQuePassword setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
//    [txtQuePassword setValue:[UIFont systemFontOfSize:REGISTERFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style5 = [txtQuePassword.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style5.minimumLineHeight = txtQuePassword.font.lineHeight - (txtQuePassword.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtQuePassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"QUERENMIMA")
                                                                            attributes:@{
                                                                                         NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                         NSFontAttributeName : [UIFont systemFontOfSize:REGISTERFONTONE],
                                                                                         NSParagraphStyleAttributeName : style5
                                                                                         }];
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
- (void) initForm2 {
    form2 = [[UIView alloc] initWithFrame: CGRectMake(0, form1.maxY + 10, SCREEN_WIDTH, SCREEN_WIDTH/8)];
    [form2 setBackgroundColor:UIColorFromRGB(0x293035)];
//    form2.IQIgnoreGroup = YES;
    [self.view addSubview: form2];
    
    UIImageView *iconGuoText = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lock"]];
    [form2 addSubview: iconGuoText];
    [iconGuoText setY: (form2.height - iconGuoText.height) / 2.0 ];
    iconGuoText.x = SCREEN_WIDTH/20;
    
    txtGuoText = [[UITextField alloc] initWithFrame:CGRectMake(iconGuoText.maxX + SCREEN_WIDTH/30 , 0, form2.width - iconLianText.maxX - SCREEN_WIDTH/30 - 2,form2.height)];
    [form2 addSubview: txtGuoText];
    txtGuoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtGuoText.textColor = UIColorFromRGB(0x767D85);
    txtGuoText.font = [UIFont systemFontOfSize:REGISTERFONTONE];
//    txtGuoText.placeholder = LocatizedStirngForkey(@"TUIJIANRENID");
//    [txtGuoText setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
//    [txtGuoText setValue:[UIFont systemFontOfSize:REGISTERFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style6 = [txtGuoText.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style6.minimumLineHeight = txtGuoText.font.lineHeight - (txtGuoText.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtGuoText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"TUIJIANRENID")
                                                                           attributes:@{
                                                                                        NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                        NSFontAttributeName : [UIFont systemFontOfSize:REGISTERFONTONE],
                                                                                        NSParagraphStyleAttributeName : style6
                                                                                        }];
    
}

- (void) initRegisterButton {
    btnRegister = [[UIButton alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/20, form2.maxY + SCREEN_WIDTH/7, SCREEN_WIDTH-SCREEN_WIDTH/10, SCREEN_WIDTH/8)];
    [btnRegister setTitle: LocatizedStirngForkey(@"ZHUCE") forState: UIControlStateNormal];
    btnRegister.titleLabel.font = [UIFont systemFontOfSize: REGISTERFONTBUTONE];
    [btnRegister.layer setMasksToBounds:YES];
    [btnRegister.layer setCornerRadius:5.0];
    [btnRegister setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [btnRegister setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3178E3)] forState:UIControlStateNormal];
    [btnRegister setBackgroundImage:[CommonUtils createImageWithColor: COL_BLUE] forState:UIControlStateHighlighted];
    
    [btnRegister addTarget: self action: @selector(userRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btnRegister];
}

- (void) initRemark {
    NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
    double fontCon;
    double fontLeft;
    double fontSmallLeft;
    if([language isEqualToString:@"zh-Hans"]){
        fontCon = REGISTERFONTTWO;
        fontLeft = 20;
        fontSmallLeft = 40;
    }else if([language isEqualToString:@"en"]){
        fontCon = REGISTERFONTTHREE;
        fontLeft = 20;
        fontSmallLeft = 50;
    }
    UIImage *clickImg = [UIImage imageNamed:@"icon_agree"];
    clickText = [[UIImageView alloc] initWithImage:clickImg];
    [clickText setFrame:CGRectMake(SCREEN_WIDTH/fontLeft, form2.maxY + SCREEN_WIDTH/30, clickImg.size.width, clickImg.size.height)];
    clickText.userInteractionEnabled=YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTouchUpInside)];
    [clickText addGestureRecognizer:labelTapGestureRecognizer];
    [self.view addSubview: clickText];
    
    UILabel *contract = [[UILabel alloc] initWithFrame:CGRectMake(clickText.maxX, form2.maxY + loginFormMarginRL, 1, 1)];
    contract.text = LocatizedStirngForkey(@"WOYIYUEDU");
    contract.font = [UIFont systemFontOfSize: fontCon];
    contract.textColor = UIColorFromRGB(0x86878B);
    [self.view addSubview: contract];
    [contract sizeToFit];
    [contract setX:clickText.maxX+SCREEN_WIDTH/fontSmallLeft ];
    [contract setY:form2.maxY+(clickText.height-contract.height)/2 +SCREEN_WIDTH/30];
    
    UILabel *contracts = [[UILabel alloc] initWithFrame:CGRectMake(contract.maxX, form2.maxY + loginFormMarginRL, 1, 1)];
    contracts.text = LocatizedStirngForkey(@"HUANQIUZAIXIANXIEYI");
    contracts.userInteractionEnabled=YES;
    UITapGestureRecognizer *imageTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside)];
    [contracts addGestureRecognizer:imageTapGestureRecognizer];
    contracts.font = [UIFont systemFontOfSize: fontCon];
    contracts.textColor = UIColorFromRGB(0x3673D2);
    [self.view addSubview: contracts];
    [contracts sizeToFit];
    [contracts setX:contract.maxX];
    [contracts setY:form2.maxY+(clickText.height-contracts.height)/2 +SCREEN_WIDTH/30];
}
-(void)imageTouchUpInside{
    if(isImageBool){
        isImageBool = NO;
        [clickText setImage:[UIImage imageNamed:@"icon_agree_hl"]];
    }else{
        isImageBool = YES;
        [clickText setImage:[UIImage imageNamed:@"icon_agree"]];
    }
    
}
-(void) labelTouchUpInside{
    HQZXServiceAgreementViewController *xieyi = [[HQZXServiceAgreementViewController alloc] init];
    [self.navigationController pushViewController:xieyi animated: YES];
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
    NSString *stype = @"1";
    
    WEAK_SELF
    [[NetHttpClient sharedHTTPClient] request: @"/send_authcode.json" parameters:@{@"mobile": mobile, @"stype": stype} completion:^(id obj) {
        [ProgressHUD dismiss];
        if (obj) {
            if ([StrValueFromDictionary(obj, ApiKey_ErrorCode) isEqualToString: @"0"]) {
                [self.view makeToast: LocatizedStirngForkey(@"YANZHENGMAFASONGCHENGGONG") duration: 0.5 position: CSToastPositionCenter];
                id codeid = [obj objectForKey: @"codeid"];
                codeType = StrValueFromDictionary(obj, @"codetype");
                NSString *codeidStr = [NSString stringWithFormat: @"%@", codeid];
                [USER_DEFAULT setObject: codeidStr forKey: UD_KEY_VALIDATENO_ID];
                btnGetValidateNo.enabled = NO;
                NSTimeInterval ins = [[NSDate date] timeIntervalSince1970] * 1000;
                NSString *lastGetValidateNoTime = [NSString stringWithFormat: @"%.0f", ins];
                [USER_DEFAULT setObject:lastGetValidateNoTime forKey: UD_KEY_LAST_GETVALIDATENO];
                validateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakself selector:@selector(refValidateBtnTitle:) userInfo:nil repeats:YES];
            } else {
                [self.view makeToast:[NSString stringWithFormat: @"%@：%@",LocatizedStirngForkey(@"HUOQUYANZHENGMASHIBAI"), [obj objectForKey: @"message"]] duration: 0.5 position:CSToastPositionCenter];
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
    NSString *tuijian = txtGuoText.text;
    if([tuijian isEqualToString:@""] || !tuijian){
        tuijian = @"0";
    }
    NSString *codeid = [USER_DEFAULT objectForKey: UD_KEY_VALIDATENO_ID];
    
    if(!commitCountry.country_id){
        [self.view makeToast: LocatizedStirngForkey(@"QINGXUANZEGUOJIA") duration: 0.5 position: CSToastPositionCenter];
        return;
    }
    VALIDATE_NOT_NULL(phoneNo, LocatizedStirngForkey(@"QINGTIANXIESHOUJIHAOMA"));
    VALIDATE_REGEX(phoneNo, VALREG_MOBILE_PHONE, LocatizedStirngForkey(@"SHOUJIHAOMAGESHIBUZHENGQUE"));
    VALIDATE_NOT_NULL(validateNo, LocatizedStirngForkey(@"QINGSHURUYANZHENGMA"));
    VALIDATE_REGEX(validateNo, @"\\d{4}", LocatizedStirngForkey(@"YANZHENGMAGESHIBUZHENGQUE"));
    VALIDATE_NOT_NULL(codeid, LocatizedStirngForkey(@"YANZHENGMASHIXIAO"));
    VALIDATE_NOT_NULL(password, LocatizedStirngForkey(@"QINGSHURUMIMA"));
    VALIDATE_REGEX(password, @"^[\\@A-Za-z0-9\\!\\#\\$\\%\\^\\&\\*\\.\\~]{6,16}$", LocatizedStirngForkey(@"MIMABAOHANXIAHUAXIANDENG"));
    VALIDATE_NOT_NULL(passwordQue, LocatizedStirngForkey(@"QINGZAICISHURUMIMA"));
    if(![password isEqualToString:passwordQue]){
        [self.view makeToast: LocatizedStirngForkey(@"LIANGCIMIMABUYIZHI") duration: 0.5 position: CSToastPositionCenter];
        return;
    }
    if(isImageBool){
        [self.view makeToast: LocatizedStirngForkey(@"QINGYUEDUHUANQIUXIEYI") duration: 0.5 position: CSToastPositionCenter];
        return;
    }
        // 注册
        
    [ProgressHUD show: [NSString stringWithFormat:@"%@...",LocatizedStirngForkey(@"QINGDENGDAI")] Interaction: NO];//
    [[NetHttpClient sharedHTTPClient] request: @"/register.json" parameters:@{@"mobile":phoneNo, @"pwd":passwordQue, @"country": commitCountry.country_id,@"codetype": codeType,@"code": validateNo,@"recommend": tuijian} completion:^(id obj) {
        [ProgressHUD dismiss];
        if (obj) {
            if ([@"0" isEqualToString:[obj objectForKey:ApiKey_ErrorCode]]) {
                [USER_DEFAULT removeObjectForKey: UD_KEY_VALIDATENO_ID];
                [self.navigationController popViewControllerAnimated: YES];
                HQZXLoginViewController *userLogin = [[HQZXLoginViewController alloc] init];
                [self.navigationController pushViewController: userLogin animated: YES];
                if (self.success) {
                    self.success(txtPhone.text);
                }
                return;
            } else {
                [self.view makeToast:LocatizedStirngForkey(@"ZHUCECHENGGONG") duration: 0.5 position:CSToastPositionCenter];
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
    if (textField == txtQuePassword) {
        
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
