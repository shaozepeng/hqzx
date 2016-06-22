//
//  MyMeViewController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/19.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define WOCONTROLLERFONT IP4566PELSE(12, 12,14,15,14)
#define WOCONTDETAILFONT IP4566PELSE(11, 11,12,13,12)
#define WOCONTROLLERPROPO IP4566PELSE(75, 72,80,90,80)
#define WOCONTROLLEEIGHT IP4566PELSE(35, 35,40,45,40)

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "XQZXWodeTableViewCell.h"
#import "HQZXLoginViewController.H"
#import "HQZXModifyLoginViewController.h"
#import "HQZXModifyTransactionViewController.h"
#import "HQZXRealNameAuthenticationViewController.h"
#import "HQZXUserModel.h"
#import "HQZXEntrustManagementViewController.h"
#import "HQZXChooseCurViewController.h"
#import "HQZXReceivablesViewController.h"
#import "HQZXPaymentViewController.h"
#import "SYQrCode.h"
#import "HQZXTransactionCurrencyViewController.h"
#import "HQZXChooseCurrencyViewController.h"
#import "HQZXRMBWithdrawalsViewController.h"
#import "HQZXChooseReceViewController.h"
#import "HQZXAboutMeViewController.h"
#import "HQZXRMBCongZhiViewController.h"
#import "HQZXChooseVirtualViewController.h"
#import "HQZXChooseCaseWithVewController.h"

@interface MyMeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *myTableView;
@end
