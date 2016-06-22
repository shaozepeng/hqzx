//
//  HQZXCashViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/16.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQZXCashWiTableCell.h"
#import "HQZXDataCashWiTableCell.h"

@interface HQZXCashViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) UITableView *myTwoTableView;
@property (strong, nonatomic) NSString *sysid;

@end
