//
//  TransactionFlowViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/31.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define DATRANHEIGHTONE IP4566PELSE(90, 86,100,110)
#define TRANSACTIONFONT  IP4566PELSE(12,11,13,14)
#define TRANSACTIONFTWO  IP4566PELSE(13,12,14,15)
#define TRANSACTIONFTHREE  IP4566PELSE(14,13,15,16)
#define TRANSACTIONFFORE  IP4566PELSE(12,11,12,13)

#import <Foundation/Foundation.h>

@interface TransactionFlowViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *myTableView;
@end
