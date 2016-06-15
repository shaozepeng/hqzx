//
//  HQZXDataPreTableCell.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/13.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQZXDataPreTableCell : UITableViewCell
@property long rowNum;

@property (strong, nonatomic) NSString *create_time;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *bank;
@property (strong, nonatomic) NSString *bank_card;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSString *fee;
@property (strong, nonatomic) NSString *state;
@end
