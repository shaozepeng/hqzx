//
//  HQZXChooseCaseWithVewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/16.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQZXChooseCaseTableCell.h"
#import "HQZXCashWithdrawalViewController.h"

@interface HQZXChooseCaseWithVewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *myTableView;

@end
