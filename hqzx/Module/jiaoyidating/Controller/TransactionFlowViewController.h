//
//  TransactionFlowViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/31.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define DATRANHEIGHTONE IP4566PELSE(90, 86,100,110,100)
#define TRANSACTIONFONT  IP4566PELSE(12,11,13,14,13)
#define TRANSACTIONFTWO  IP4566PELSE(13,12,14,15,14)
#define TRANSACTIONFTHREE  IP4566PELSE(14,13,15,16,15)
#define TRANSACTIONFFORE  IP4566PELSE(12,11,12,13,12)

#import <Foundation/Foundation.h>
#import "HQZXKlineGraphViewController.h"

@interface TransactionFlowViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *myTableView;
@end
