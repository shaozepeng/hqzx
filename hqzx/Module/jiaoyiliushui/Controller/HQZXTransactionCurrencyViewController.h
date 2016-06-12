//
//  HQZXTransactionCurrencyViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/4.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQZXTransactionTableCell.h"
#import "HQZXDataTranTableCell.h"
#import "HQZXTransferAccountsTableCell.h"
#import "HQZXDataAccTableCell.h"

@interface HQZXTransactionCurrencyViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *myAccTableView;
@property (nonatomic, retain) UITableView *myAccTwoTableView;
@property (nonatomic, retain) UITableView *mySecAccTableView;
@property (nonatomic, retain) UITableView *mySecAccTwoTableView;
@property (nonatomic, retain) UITableView *myAccDataTableView;
@property (nonatomic, retain) UITableView *myAccDataTwoTableView;
@property (nonatomic, retain) UITableView *mySecAccDataTableView;
@property (nonatomic, retain) UITableView *mySecAccDataTwoTableView;
@property (strong, nonatomic) NSString *sysId;
@end
