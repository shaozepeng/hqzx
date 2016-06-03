//
//  MyRecentViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/19.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

//

#define FIRSTSECIONHEIGHT  IP4566PELSE(8, 6,8,9)

#import "GDLocalizableController.h"
#import <SDCycleScrollView.h>
#import "HRCoverView.h"
#import "XQZXFirstPageTableViewCell.h"
#import "HQZXEmptyManager.h"

@interface MyRecentViewController :UIViewController<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *myTableView;
@end
