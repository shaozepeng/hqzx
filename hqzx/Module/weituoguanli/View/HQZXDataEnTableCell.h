//
//  HQZXDataEnTableCell.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/4.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define DATAFONT IP4566PELSE(9, 8,10,11,10)
#define DATAFONTONE IP4566PELSE(10, 9,11,12,11)
#define DATAFONTTWO IP4566PELSE(11, 10,12,13,12)
#define DATAFONTTHREE IP4566PELSE(12, 11,13,14,13)
#define DATAFONTFORE IP4566PELSE(13, 12,14,15,14)

#import <Foundation/Foundation.h>

@interface HQZXDataEnTableCell : UITableViewCell
@property long rowNum;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *tradetype;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *fee;
@property (strong, nonatomic) NSString *volume;
@property (strong, nonatomic) NSString *dealmoney;
@property (strong, nonatomic) NSString *status;
@property(nonatomic, strong) void (^buquanBlock)();
@property(nonatomic, strong) void (^quxiaoBlock)();
@end
