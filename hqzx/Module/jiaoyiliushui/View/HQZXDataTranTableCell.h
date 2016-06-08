//
//  HQZXDataTranTableCell.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/4.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQZXDataTranTableCell : UITableViewCell
@property long rowNum;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *title1;
@property (strong, nonatomic) NSString *title2;
@property (strong, nonatomic) NSString *title3;
@property (strong, nonatomic) NSString *toubiaoshu;
@property (strong, nonatomic) NSString *zhuangzaigang;
@property (strong, nonatomic) NSString *toubiaozhuangtai;
@property (strong, nonatomic) NSString *kaibiaohaisheng;
@property(nonatomic, strong) void (^buquanBlock)();
@property(nonatomic, strong) void (^quxiaoBlock)();
@end
