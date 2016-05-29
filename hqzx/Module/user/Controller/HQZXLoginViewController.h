//
//  JHTLoginViewController.h
//  jht
//
//  Created by 孙泽山 on 15/6/24.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#define LOGINFONTONE  IP4566PELSE(13, 13,14,15)
#define LOGINFONTTWO  IP4566PELSE(11, 11,12,13)
#define LOGINFONTBUTONE  IP4566PELSE(15, 15,16,17)


#import "HQZXForgetPasswordViewController.h"
#import "HQZXCountry.h"
#import "HQZXSelectCountryForm.h"

@interface HQZXLoginViewController : UIViewController

+ (UINavigationController*) getLoginController;

@property(nonatomic, strong) void (^successBlock)();
@property(nonatomic, strong) void (^cancelBlock)();
@end
