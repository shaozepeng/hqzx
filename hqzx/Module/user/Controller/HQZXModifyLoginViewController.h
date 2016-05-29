//
//  HQZXModifyLoginViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/25.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define MODIFYTFONTONE  IP4566PELSE(13, 13,14,15)
#define MODIFYFONTBUTONE  IP4566PELSE(15, 15,16,16)

typedef void (^Id_Block)(id obj);
#define Id_Block() ^void (id obj)

#import <Foundation/Foundation.h>
#import <US2FormValidator.h>

@interface HQZXModifyLoginViewController : UIViewController<US2ValidatorUIDelegate, UITextFieldDelegate>
//-(instancetype)initWithPhoneNo:(NSString*) phoneNo;
@property BOOL isFindPwd;
@property (nonatomic, strong) Id_Block success;
@end
