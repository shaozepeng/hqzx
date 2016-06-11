//
//  HQZXSelectBankForm.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/8.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XQZXCommonAlert.h"
#import "HQZXBank.h"
typedef void (^Void_Block)(void);
#define Void_Block() ^void ()
typedef void (^HQZXSelectBankComp)(HQZXBank*);
#define HQZXSelectBankComp() ^void (HQZXBank* BANK)

@interface HQZXSelectBankForm : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) HQZXSelectBankComp beSureComp;

@property (nonatomic, strong) HQZXBank* bank;

- (instancetype)initWithPlaceHolder:(NSString*) placeHolder ;

- (void) showAction;

- (void) hideAction: (Void_Block) didClose;
@end
