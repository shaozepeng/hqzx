//
//  JHTRegisterViewController.h
//  jht
//
//  Created by 孙泽山 on 15/6/24.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <US2FormValidator.h>
#import "JHTBaseController.h"
#import "JHTYongHuXieYiViewController.h"

@interface JHTRegisterViewController : JHTBaseController<US2ValidatorUIDelegate, UITextFieldDelegate>
-(instancetype)initWithPhoneNo:(NSString*) phoneNo;
@property BOOL isFindPwd;
@property (nonatomic, strong) Id_Block success;
@end
