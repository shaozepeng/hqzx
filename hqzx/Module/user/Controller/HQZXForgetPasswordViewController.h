//
//  HQZXForgetPasswordViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/25.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define FORGETFONTONE  IP4566PELSE(13, 13,14,15)
#define FORGETFONTTWO  IP4566PELSE(12, 12,13,14)
#define FORGETFONTBUTONE  IP4566PELSE(15, 15,16,16)

#import <Foundation/Foundation.h>
#import <US2FormValidator.h>
//#import "HQZXLoginViewController.h"

@interface HQZXForgetPasswordViewController : UIViewController<US2ValidatorUIDelegate, UITextFieldDelegate>
-(instancetype)initWithPhoneNo:(NSString*) phoneNo;
@property BOOL isFindPwd;
@property (nonatomic, strong) Id_Block success;
@end
