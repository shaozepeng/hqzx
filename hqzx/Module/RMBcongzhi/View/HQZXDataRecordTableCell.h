//
//  HQZXDataRecordTableCell.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/15.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQZXDataRecordTableCell : UITableViewCell
@property long rowNum;

@property (strong, nonatomic) NSString *create_time;
@property (strong, nonatomic) NSString *bankname;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSString *fee;
@property (strong, nonatomic) NSString *statu;

@end
