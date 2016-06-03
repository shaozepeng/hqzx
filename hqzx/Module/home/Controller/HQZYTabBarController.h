//
//  HQZYTabBarController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/19.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRecentViewController.h"
#import "MyContactsViewController.h"
#import "MyMeViewController.h"
#import "MacroDefinition.h"
#import "HQZXLoginViewController.h"
#import "HQZXRealNameAuthenticationViewController.h"

@interface HQZYTabBarController : UITabBarController<UITabBarControllerDelegate>
@property (nonatomic, strong)MyRecentViewController* recentViewCntlr;
@property (nonatomic, strong)MyContactsViewController* contactsViewCntlr;
@property (nonatomic, strong)MyMeViewController* meViewCntlr;
@property (nonatomic,assign) NSInteger selectSum;

@end
