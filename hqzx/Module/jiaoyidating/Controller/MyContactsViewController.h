//
//  MyContactsViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/19.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

//#define FIRSTSECIONHEIGHT  IP4566PELSE(8, 6,8,9,8)

#import <UIKit/UIKit.h>
#import "XQZXJiaoYiDaTingTableCell.h"
#import "TransactionFlowViewController.h"
#import "HQZXNeedLoginController.h"

@interface MyContactsViewController :UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *myTableView;
@property NSMutableArray *datas;
@end
