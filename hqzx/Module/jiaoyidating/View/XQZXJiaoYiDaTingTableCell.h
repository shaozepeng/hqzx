//
//  XQZXJiaoYiDaTingTableCell.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/23.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define FIRSTHEIGHTONE IP4566PELSE(90, 86,100,110)
#define FIRSTFONTONE IP4566PELSE(13, 13,14,15)
#define FIRSTFONTTWO IP4566PELSE(14, 14,15,16)
#define FIRSTFONTTHREE IP4566PELSE(11, 12,12,14)
#define FIRSTHEIGHTTWO IP4566PELSE(0.9, 0.9,1,1.1)
#define IMAGELEFT IP4566PELSE(10, 3,3,3)
#define IMAGELEFTTWO IP4566PELSE(0.46, 0.5,0.5,0.5)
#define IMAGELEFTTHREE IP4566PELSE(0.71, 0.75,0.75,0.75)

#import <UIKit/UIKit.h>

@protocol XQZXJiaoYiDaTingTableCellDelegate <NSObject>

@optional
-(void) toubiao: (long) rowIndex;
-(void) xiangqing: (long) rowIndex;
-(void) jishilianxi: (long) rowIndex;

@end

@interface XQZXJiaoYiDaTingTableCell : UITableViewCell
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *title1;
@property (strong, nonatomic) NSString *title2;
@property (strong, nonatomic) NSString *title3;
@property (strong, nonatomic) NSString *toubiaoshu;
@property (strong, nonatomic) NSString *zhuangzaigang;
@property (strong, nonatomic) NSString *toubiaozhuangtai;
@property (strong, nonatomic) NSString *kaibiaohaisheng;
@property(nonatomic, strong) void (^wocanyudehuopanxiangqingBlock)();

@property long rowNum;
@property id<XQZXJiaoYiDaTingTableCellDelegate> delegate;
@end
