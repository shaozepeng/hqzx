//
//  JHTRegisterViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/25.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define REGISTERFONTONE  IP4566PELSE(13, 13,14,15,14)
#define REGISTERFONTTWO  IP4566PELSE(12, 11,12,13,12)
#define REGISTERFONTFORE IP4566PELSE(12, 12,13,14,13)
#define REGISTERFONTTHREE  IP4566PELSE(11, 9,11,12,11)
#define REGISTERFONTBUTONE  IP4566PELSE(15, 15,16,16,16)


#import <US2FormValidator.h>
#import "HQZXLoginViewController.h"
#import "HQZXServiceAgreementViewController.h"

@interface HQZXRegisterViewController : UIViewController<US2ValidatorUIDelegate, UITextFieldDelegate>
-(instancetype)initWithPhoneNo:(NSString*) phoneNo;
@property BOOL isFindPwd;
@property (nonatomic, strong) Id_Block success;
@end
