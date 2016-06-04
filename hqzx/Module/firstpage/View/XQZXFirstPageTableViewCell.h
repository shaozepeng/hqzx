//
//  JHWoCanYuDeHuoPanTableViewCell.h
//  jht
//
//  Created by 泽鹏邵 on 15/7/23.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#define FIRSTHEIGHTONE IP4566PELSE(90, 86,100,110,100)
#define FIRSTFONTONE IP4566PELSE(13, 13,14,15,14)
#define FIRSTFONTTWO IP4566PELSE(14, 14,15,16,15)
#define FIRSTFONTTHREE IP4566PELSE(11, 12,12,14,12)
#define FIRSTHEIGHTTWO IP4566PELSE(0.9, 0.9,1,1.1,1)
#define IMAGELEFT IP4566PELSE(10, 3,3,3,3)
#define IMAGELEFTTWO IP4566PELSE(0.46, 0.5,0.5,0.5,0.5)
#define IMAGELEFTTHREE IP4566PELSE(0.71, 0.75,0.75,0.75,0.75)

#import <UIKit/UIKit.h>

@protocol XQZXFirstPageTableViewCellDelegate <NSObject>

@optional
-(void) toubiao: (long) rowIndex;
-(void) xiangqing: (long) rowIndex;
-(void) jishilianxi: (long) rowIndex;

@end

@interface XQZXFirstPageTableViewCell : UITableViewCell
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
@property id<XQZXFirstPageTableViewCellDelegate> delegate;
@end
