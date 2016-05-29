//
//  JHWodeTableViewController.h
//  jht
//
//  Created by 邵泽鹏 on 15/7/8.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#define CellHeight 140
#define CellMargin 12
#import <UIKit/UIKit.h>
@protocol JHTWodeTableViewCellDelegate <NSObject>

@optional
-(void) toubiao: (long) rowIndex;
-(void) xiangqing: (long) rowIndex;
-(void) jishilianxi: (long) rowIndex;

@end
@interface JHTWodeTableViewController : UITableViewCell
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *title1;
@property (strong, nonatomic) NSString *title2;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *chuanstatus;
@property (strong, nonatomic) NSString *chuanname;
@property long rowNum;
@property id<JHTWodeTableViewCellDelegate> delegate;
@end
