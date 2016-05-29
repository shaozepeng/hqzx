//
//  JHTLoginViewController.h
//  jht
//
//  Created by 孙泽山 on 15/6/24.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHTBaseController.h"
#import "MyTLSUIViewController.h"

@interface JHTLoginViewController : JHTBaseController

+ (UINavigationController*) getLoginController;

@property(nonatomic, strong) void (^successBlock)();
@property(nonatomic, strong) void (^cancelBlock)();
@end
