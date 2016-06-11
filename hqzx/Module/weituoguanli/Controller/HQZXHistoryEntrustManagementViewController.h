//
//  HQZXHistoryEntrustManagementViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/4.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQZXHistoryEntrustTableCell.h"
#import "HQZXHistoryDataEnTableCell.h"

@interface HQZXHistoryEntrustManagementViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *arrX;
/** y方向数据*/
@property (nonatomic, strong) NSArray *arrY;
@property (strong, nonatomic) NSString *sysId;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) UITableView *myTwoTableView;
@end
