//
//  JHTYaoQingGuanZhuForm.h
//  jht
//
//  Created by 泽鹏邵 on 15/11/9.
//  Copyright © 2015年 dhgh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQZXCommonAlert.h"
#import "HQZXCountry.h"
typedef void (^Void_Block)(void);
#define Void_Block() ^void ()
typedef void (^HQZXSelectCountryComp)(HQZXCountry*);
#define HQZXSelectCountryComp() ^void (HQZXCountry* COUNTRY)

@interface HQZXSelectCountryForm : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) HQZXSelectCountryComp beSureComp;

@property (nonatomic, strong) HQZXCountry* country;

- (instancetype)initWithPlaceHolder:(NSString*) placeHolder ;

- (void) showAction;

- (void) hideAction: (Void_Block) didClose;

@end
