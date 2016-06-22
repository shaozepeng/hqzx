//
//  HQZXRMBRecordViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/15.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQZXRMBRecordTableCell.h"
#import "HQZXDataRecordTableCell.h"

@interface HQZXRMBRecordViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) UITableView *myTwoTableView;
@end
