//
//  JHTNeedLoginController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/19.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

typedef void (^Bool_Block)(BOOL value);
#define Bool_Block() ^void (BOOL value)

#import <Foundation/Foundation.h>
#import "ProgressHUD.h"
#import "UIResponder+addtion.h"
#import "HQZXRealNameAuthenticationViewController.h"

@interface HQZXNeedLoginController : NSObject
@property (nonatomic, strong) UIViewController* controller;
@property (nonatomic, strong) NSString* url;

-(instancetype)initWithController:(UIViewController*) controller;
-(instancetype)initWithUrl:(NSString*) url;

- (void)validateFrom:(UIViewController*) parentController completion:(Bool_Block) completion;

- (void)presentFrom:(UIViewController *)parentController animated: (BOOL)flag completion:(void (^)(void))completion NS_AVAILABLE_IOS(5_0);

- (void)pushFrom:(UIViewController*) parentController inNavigationController:(UINavigationController*) navigationController animated: (BOOL)flag;
- (void)pushFrom1:(UIViewController*) parentController inNavigationController:(UINavigationController*) navigationController animated: (BOOL)flag;
- (void)pushFrom2:(UIViewController*) parentController inNavigationController:(UINavigationController*) navigationController animated: (BOOL)flag;

- (void)pushFrom:(UIViewController*) parentController animated: (BOOL)flag;
@end
