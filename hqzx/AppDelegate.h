//
//  AppDelegate.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/18.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQZYTabBarController.h"
#import "IQKeyboardManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *nav;
@property (strong, nonatomic) NSDictionary *launchOptions;
@property (nonatomic,assign) NSInteger selectSum;
@end

