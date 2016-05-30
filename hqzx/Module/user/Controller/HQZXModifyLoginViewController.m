//
//  HQZXModifyLoginViewController.m
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
#import "HQZXModifyLoginViewController.h"
#import "IQUIView+IQIgnoreGroup.h"
#import <UIView+Toast.h>
@interface HQZXModifyLoginViewController () {
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
}
@end

@implementation HQZXModifyLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor = [UIColor whiteColor];
    self.title = LocatizedStirngForkey(@"XIUGAIDENGLUMIMA");
    
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
    
    //    UIView *userNameView = [[UIView alloc] initWithFrame: CGRectMake(borderWidthForForm, borderWidthForForm, form1.width - borderWidthForForm*2, (form1.height - borderWidthForForm*2 - line.height)/2)];
    //    [form1 addSubview:userNameView];
    
    
    UIImageView *iconDengPassword = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lock"]];
    [form1 addSubview: iconDengPassword];
    [iconDengPassword setY: (form1.height/3 - iconDengPassword.height) / 2.0];
    iconDengPassword.x = SCREEN_WIDTH/20;
    
    txtDengPassword = [[UITextField alloc] initWithFrame:CGRectMake(iconDengPassword.maxX + SCREEN_WIDTH/40 + 1, 1, form1.width - iconDengPassword.maxX - marginTxtWithIcon - COMMON_H_MARGIN, form1.height/3 - 1)];
    [form1 addSubview: txtDengPassword];
    txtDengPassword.secureTextEntry = YES;
    txtDengPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtDengPassword.textColor = UIColorFromRGB(0x767D85);
    txtDengPassword.font = [UIFont systemFontOfSize:MODIFYTFONTONE];
    //    txtDengPassword.placeholder = LocatizedStirngForkey(@"DENGLUMIMA");
    //    [txtDengPassword setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
    //    [txtDengPassword setValue:[UIFont systemFontOfSize:REGISTERFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style = [txtDengPassword.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = txtDengPassword.font.lineHeight - (txtDengPassword.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtDengPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"JIUMIMA")
                                                                            attributes:@{
                                                                                         NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                         NSFontAttributeName : [UIFont systemFontOfSize:MODIFYTFONTONE],
                                                                                         NSParagraphStyleAttributeName : style
                                                                                         }];
  
    
    
    UIImageView *iconPassword = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lock"]];
    [form1 addSubview: iconPassword];
    form1.IQIgnoreGroup = YES;
    [iconPassword setY: (form1.height/3 - iconPassword.height) / 2.0 + line.maxY];
    iconPassword.x = SCREEN_WIDTH/20;
    
    
    txtValidateNo = [[UITextField alloc] initWithFrame:CGRectMake(iconDengPassword.maxX + SCREEN_WIDTH/40 + 1, line.maxY + 1, form1.width - iconDengPassword.maxX - marginTxtWithIcon - COMMON_H_MARGIN, form1.height/3 - 1)];
    [form1 addSubview: txtValidateNo];
    txtValidateNo.secureTextEntry = YES;
    txtValidateNo.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtValidateNo.textColor = UIColorFromRGB(0x767D85);
    txtValidateNo.font = [UIFont systemFontOfSize:MODIFYTFONTONE];
//    txtValidateNo.placeholder = LocatizedStirngForkey(@"XINMIMA");
//    [txtValidateNo setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
//    [txtValidateNo setValue:[UIFont systemFontOfSize:MODIFYTFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style2 = [txtValidateNo.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style2.minimumLineHeight = txtValidateNo.font.lineHeight - (txtValidateNo.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtValidateNo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"XINMIMA")
                                                                     attributes:@{
                                                                                  NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                  NSFontAttributeName : [UIFont systemFontOfSize:MODIFYTFONTONE],
                                                                                  NSParagraphStyleAttributeName : style2
                                                                                  }];
    
    txtValidateNo.delegate = self;
    
    UIImageView *iconDengPasswords = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lock"]];
    [form1 addSubview: iconDengPasswords];
    [iconDengPasswords setY: (form1.height /3 - iconDengPasswords.height) / 2.0 + line2.maxY];
    iconDengPasswords.x = SCREEN_WIDTH/20;
    
    txtQuePassword = [[UITextField alloc] initWithFrame:CGRectMake(iconDengPassword.maxX + SCREEN_WIDTH/40 + 1, line2.maxY + 1, form1.width - iconDengPassword.maxX - marginTxtWithIcon - COMMON_H_MARGIN,form1.height/3 - 1)];
    [form1 addSubview: txtQuePassword];
    txtQuePassword.secureTextEntry = YES;
    txtQuePassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtQuePassword.textColor = UIColorFromRGB(0x767D85);
    txtQuePassword.font = [UIFont systemFontOfSize:MODIFYTFONTONE];
//    txtDengPassword.placeholder = LocatizedStirngForkey(@"QUERENXINMIMA");
//    [txtDengPassword setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
//    [txtDengPassword setValue:[UIFont systemFontOfSize:MODIFYTFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style3 = [txtDengPassword.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style3.minimumLineHeight = txtQuePassword.font.lineHeight - (txtQuePassword.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtQuePassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"QUERENXINMIMA")
                                                                          attributes:@{
                                                                                       NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                       NSFontAttributeName : [UIFont systemFontOfSize:MODIFYTFONTONE],
                                                                                       NSParagraphStyleAttributeName : style3
                                                                                       }];
    
}


- (void) initRegisterButton {
    btnRegister = [[UIButton alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/20, form1.maxY + SCREEN_WIDTH/7, SCREEN_WIDTH-SCREEN_WIDTH/10, SCREEN_WIDTH/8)];
    [btnRegister setTitle: LocatizedStirngForkey(@"BAOCUNXIUGAI") forState: UIControlStateNormal];
    btnRegister.titleLabel.font = [UIFont systemFontOfSize: MODIFYFONTBUTONE];
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


-(IBAction)userRegister:(id)sender {
    NSString *oldPWD = txtDengPassword.text;
    NSString *newPWD = txtValidateNo.text;
    NSString *quePWD = txtQuePassword.text;

    VALIDATE_NOT_NULL(oldPWD, LocatizedStirngForkey(@"QINGSHURUJIUMIMA"));
    VALIDATE_NOT_NULL(newPWD, LocatizedStirngForkey(@"QINGSHURUXINMIMA"));
    VALIDATE_NOT_NULL(quePWD, LocatizedStirngForkey(@"QINGSHURUQUERENMIMA"));
    
    if(![newPWD isEqualToString:quePWD]){
        [self.view makeToast: LocatizedStirngForkey(@"LIANGCIMIMABUYIZHI") duration: 0.5 position: CSToastPositionCenter];
        return;
    }
 
    VALIDATE_REGEX(newPWD, @"^[\\@A-Za-z0-9\\!\\#\\$\\%\\^\\&\\*\\.\\~]{6,16}$", LocatizedStirngForkey(@"MIMABAOHANXIAHUAXIANDENG"));
    
    // 找回密码
    [ProgressHUD show: [NSString stringWithFormat:@"%@...",LocatizedStirngForkey(@"QINGDENGDAI")] Interaction: NO];
    [[NetHttpClient sharedHTTPClient] request: @"/upt_login_pwd.json" parameters:@{ @"old_pwd":oldPWD, @"new_pwd1":newPWD, @"new_pwd2": quePWD} completion:^(id obj) {
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction) userLoginBack:(id) sender{
    HQZXLoginViewController *userLogin= [[HQZXLoginViewController alloc] init];
    [self.navigationController pushViewController: userLogin animated: YES];
}
@end
