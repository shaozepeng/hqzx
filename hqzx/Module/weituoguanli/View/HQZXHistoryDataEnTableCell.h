//
//  HQZXHistoryDataEnTableCell.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/4.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQZXHistoryDataEnTableCell : UITableViewCell
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
