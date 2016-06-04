//
//  HQZXCertificationSuccessViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/29.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define SUCCESSFONTONE  IP4566PELSE(11, 12,13,14,13)
#define SUCCESSFONTONETWO  IP4566PELSE(12, 12,14,15,14)
#define SUCCESSHEIGHT  IP4566PELSE(16, 20,15,15,15)

#import <Foundation/Foundation.h>

@interface HQZXCertificationSuccessViewController : UIViewController
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *cardType;
@property (strong, nonatomic) NSString *cardId;
@property (strong, nonatomic) NSString *timeStem;
@end
