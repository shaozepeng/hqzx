//
//  JHWoCanYuDeHuoPanTableViewCell.h
//  jht
//
//  Created by 泽鹏邵 on 15/7/23.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#define WodehuojiaCellHeight IP5ELSE(124, 140)
#define WodehuojiaCellMarginTB IP5ELSE(8, 12)
#define WodehuojiaCellMarginRL IP5ELSE(28, 30)
#define WodehuojiaFont1 IP5ELSE(14, 15)
#define WodehuojiaFont2 IP5ELSE(13, 14)
#define WodehuojiaFont3 IP5ELSE(12, 13)
#define WodehuojiaFont4 IP5ELSE(15, 16)
#import <UIKit/UIKit.h>

@protocol JHTWoCanYuDeTouBiaoTableViewCellDelegate <NSObject>

@optional
-(void) toubiao: (long) rowIndex;
-(void) xiangqing: (long) rowIndex;
-(void) jishilianxi: (long) rowIndex;

@end

@interface JHTWoCanYuDeTouBiaoTableViewCell : UITableViewCell
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *title1;
@property (strong, nonatomic) NSString *title2;
@property (strong, nonatomic) NSString *title3;
@property (strong, nonatomic) NSString *toubiaoshu;
@property (strong, nonatomic) NSString *zhuangzaigang;
@property (strong, nonatomic) NSString *toubiaozhuangtai;
@property (strong, nonatomic) NSString *xiezaigang;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *youxiaoqi;
@property (strong, nonatomic) NSString *kaibiaohaisheng;
@property(nonatomic, strong) void (^wocanyudehuopanxiangqingBlock)();

@property long rowNum;
@property id<JHTWoCanYuDeTouBiaoTableViewCellDelegate> delegate;
@end
