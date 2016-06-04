//
//  HQZXEntrustManagementViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/3.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define LISHIFONT IP4566PELSE(11, 10,12,13,12)

#import <Foundation/Foundation.h>
#import "HQZXEntrustTableCell.h"
#import "HQZXDataEnTableCell.h"
#import "HQZXHistoryEntrustManagementViewController.h"

@interface HQZXEntrustManagementViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *arrX;
/** y方向数据*/
@property (nonatomic, strong) NSArray *arrY;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) UITableView *myTwoTableView;
@end
