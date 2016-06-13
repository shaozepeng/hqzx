//
//  HQZXDataTranTableCell.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/4.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//
#define DATAFONTTHREES IP4566PELSE(12, 11,13,14,13)
#define DATAFONTTHREEST IP4566PELSE(10, 9,11,12,11)

#import <Foundation/Foundation.h>

@interface HQZXDataTranTableCell : UITableViewCell
@property long rowNum;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *volume;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *fee;
@end
