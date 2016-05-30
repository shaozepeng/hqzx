//
//  MyMeViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/19.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define WOCONTROLLERFONT IP4566PELSE(12, 12,14,15)
#define WOCONTDETAILFONT IP4566PELSE(11, 11,12,13)
#define WOCONTROLLERPROPO IP4566PELSE(85, 82,90,100)
#define WOCONTROLLEEIGHT IP4566PELSE(35, 35,40,45)

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
#import "XQZXWodeTableViewCell.h"
#import "HQZXLoginViewController.H"
#import "HQZXModifyLoginViewController.h"
#import "HQZXModifyTransactionViewController.h"
#import "HQZXRealNameAuthenticationViewController.h"

@interface MyMeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *myTableView;
@end
