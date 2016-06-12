//
//  HQZXChooseReceViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/11.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQZXChooseReceTableCell.h"
#import "HQZXReceivablesViewController.h"


@interface HQZXChooseReceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *myTableView;
@end
