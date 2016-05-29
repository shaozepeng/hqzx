//
//  XQZXWodeTableViewCell.h
//  xqzx
//
//  Created by 邵泽鹏 on 15/7/8.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#define CellHeight 100
#define CellMargin 12
#define WOCELLFONT IP4566PELSE(12, 12,14,15)
#define WOCELLHEIGHT IP4566PELSE(85, 82,90,100)
#define WOCELLPROPO IP4566PELSE(1.1, 1.1,1.2,1.3)

#import <UIKit/UIKit.h>
@protocol XQZXWodeTableViewCellDelegate <NSObject>

@optional
-(void) toubiao: (long) rowIndex;
-(void) xiangqing: (long) rowIndex;
-(void) jishilianxi: (long) rowIndex;

@end
@interface XQZXWodeTableViewCell : UITableViewCell
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *title1;
@property (strong, nonatomic) NSString *title2;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *chuanstatus;
@property (strong, nonatomic) NSString *chuanname;
@property long rowNum;
@property id<XQZXWodeTableViewCellDelegate> delegate;
@end
