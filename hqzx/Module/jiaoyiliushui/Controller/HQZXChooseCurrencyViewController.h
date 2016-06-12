//
//  HQZXChooseCurrencyViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/5.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQZXTransactionCurrencyViewController.h"

@interface HQZXChooseCurrencyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *myTableView;
@end
