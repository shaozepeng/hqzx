//
//  HQZXPaymentViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/4.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQZXPaySuccessViewController.h"

@interface HQZXPaymentViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) NSString *sysId;
@property (strong, nonatomic) NSString *sysName;
@property (strong, nonatomic) NSString *userId;
@end
