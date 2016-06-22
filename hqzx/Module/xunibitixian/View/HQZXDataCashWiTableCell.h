//
//  HQZXDataCashWiTableCell.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/16.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQZXDataCashWiTableCell : UITableViewCell
@property long rowNum;

@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *wallet;
@property (strong, nonatomic) NSString *quantity;
@property (strong, nonatomic) NSString *fee;
@property (strong, nonatomic) NSString *status_name;

@end
