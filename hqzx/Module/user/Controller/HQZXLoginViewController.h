//
//  HQZXLoginViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/25.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define LOGINFONTONE  IP4566PELSE(13, 13,14,15,14)
#define LOGINFONTTWO  IP4566PELSE(11, 11,12,13,12)
#define LOGINFONTBUTONE  IP4566PELSE(15, 15,16,17,16)


#import "HQZXForgetPasswordViewController.h"
#import "HQZXCountry.h"
#import "HQZXSelectCountryForm.h"

@interface HQZXLoginViewController : UIViewController

+ (UINavigationController*) getLoginController;

@property(nonatomic, strong) void (^successBlock)();
@property(nonatomic, strong) void (^cancelBlock)();
@property(nonatomic, strong) void (^cancellationBlock)();
@end
