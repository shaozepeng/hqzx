//
//  HQZXEntrustManagementViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/3.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define LISHIFONT IP4566PELSE(13, 12,14,15,14)

#import <Foundation/Foundation.h>
#import "HQZXEntrustTableCell.h"
#import "HQZXDataEnTableCell.h"
#import "HQZXHistoryEntrustManagementViewController.h"

@interface HQZXEntrustManagementViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *arrX;
/** y方向数据*/
@property (nonatomic, strong) NSArray *arrY;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) UITableView *myTwoTableView;
@property (strong, nonatomic) NSString *sysId;
@end
