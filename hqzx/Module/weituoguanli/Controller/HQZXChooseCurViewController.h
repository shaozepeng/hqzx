//
//  HQZXChooseCurViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/9.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQZXEntrustManagementViewController.h"
#import "HQZXVirtualViewController.h"
#import "HQZXChooseTableCell.h"

@interface HQZXChooseCurViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *myTableView;
@end
