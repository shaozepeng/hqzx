//
//  HQZXModifyTransactionViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/26.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define TRANTFONTONE  IP4566PELSE(13, 13,14,15,14)
#define TRANFONTTWO  IP4566PELSE(12, 12,13,14,13)
#define TRANFONTBUTONE  IP4566PELSE(15, 15,16,16,16)
#define TRANFONTLABEL  IP4566PELSE(14, 14,15,16,15)
#define TRANFONTHEIGHT  IP4566PELSE(10, 5,5,5,5)

typedef void (^Id_Block)(id obj);
#define Id_Block() ^void (id obj)

#import <Foundation/Foundation.h>
#import <US2FormValidator.h>

@interface HQZXModifyTransactionViewController : UIViewController<US2ValidatorUIDelegate, UITextFieldDelegate>
@property BOOL isFindPwd;
@property (nonatomic, strong) Id_Block success;
@end
