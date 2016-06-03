//
//  HQZXRealNameAuthenticationViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/29.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define MODIFYTFONTONE  IP4566PELSE(13, 13,14,15)
#define MODIFYFONTBUTONE  IP4566PELSE(15, 15,16,16)

#import <Foundation/Foundation.h>
#import <US2FormValidator.h>
#import "HQZXSelectIDForm.h"
#import "HQZXCertificationSuccessViewController.h"

@interface HQZXRealNameAuthenticationViewController : UIViewController<UITextFieldDelegate>
@property BOOL isFindPwd;
@property (nonatomic, strong) Id_Block success;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *cardTyoe;
@property (strong, nonatomic) NSString *cardId;
@property(nonatomic, strong) void (^successBlock)();
@end
