//
//  JHTYaoQingGuanZhuForm.h
//  jht
//
//  Created by 泽鹏邵 on 15/11/9.
//  Copyright © 2015年 dhgh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQZXCommonAlert.h"
#import "HQZXID.h"

typedef void (^HQZXSelectIDComp)(HQZXID*);
#define HQZXSelectIDComp() ^void (HQZXID* CARD)

@interface HQZXSelectIDForm : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) HQZXSelectIDComp beSureComp;

@property (nonatomic, strong) HQZXID* card;

- (instancetype)initWithPlaceHolder:(NSString*) placeHolder ;

- (void) showAction;

- (void) hideAction: (Void_Block) didClose;

@end
