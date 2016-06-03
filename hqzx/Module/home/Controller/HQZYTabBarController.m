//
//  HQZYTabBarController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/19.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZYTabBarController.h"

@implementation HQZYTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor=[UIColor redColor];
    // Do any additional setup after loading the view.
    self.tabBar.translucent = NO;
    self.delegate = self;
    UIView * mView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, self.tabBar.frame.size.height)];//这是整个tabbar的颜色
    [mView setBackgroundColor:UIColorFromRGB(0x1D2228)];
    [self.tabBar insertSubview:mView atIndex:1];
    mView.alpha=0.8;
    //创建三个tab的视图
    self.recentViewCntlr = [[MyRecentViewController alloc] init];
    self.contactsViewCntlr = [[MyContactsViewController alloc] init];
    self.meViewCntlr = [[MyMeViewController alloc] init];
    
    //设置navi作为根视图
    UINavigationController* recentNaviCntlr = [[UINavigationController alloc]initWithRootViewController:self.recentViewCntlr];
    UINavigationController* contactsNaviCntlr = [[UINavigationController alloc]initWithRootViewController:self.contactsViewCntlr];
    UINavigationController* meNaviCntlr = [[UINavigationController alloc]initWithRootViewController:self.meViewCntlr];
    
    [self addChildViewController:recentNaviCntlr];
    [self addChildViewController:contactsNaviCntlr];
    [self addChildViewController:meNaviCntlr];
    
    recentNaviCntlr.tabBarItem = [[UITabBarItem alloc] initWithTitle:LocatizedStirngForkey(@"ONE")
                                                               image:[[UIImage imageNamed:@"icon_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                       selectedImage:[[UIImage imageNamed:@"icon_home_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    recentNaviCntlr.tabBarItem.tag=0;
    contactsNaviCntlr.tabBarItem = [[UITabBarItem alloc] initWithTitle:LocatizedStirngForkey(@"TWO")
                                                                 image:[[UIImage imageNamed:@"icon_jydt"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                         selectedImage:[[UIImage imageNamed:@"icon_jydt_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    contactsNaviCntlr.tabBarItem.tag=1;
    meNaviCntlr.tabBarItem = [[UITabBarItem alloc] initWithTitle:LocatizedStirngForkey(@"THREE")
                                                           image:[[UIImage imageNamed:@"icon_me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                   selectedImage:[[UIImage imageNamed:@"icon_me_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    meNaviCntlr.tabBarItem.tag=2;
    
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    self.tabBar.backgroundImage = [[UIImage imageNamed:@"tabbar_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(2.0f, 2.0f, 2.0f, 2.0f)];
    self.selectedIndex = _selectSum?_selectSum:0;
//    self.selectedIndex = 1;
    //[[AppDelegate sharedAppDelegate] testLogout];
}
-(void)setSelectSum:(NSInteger)selectSum{
    _selectSum = selectSum;
    self.selectedIndex = _selectSum?_selectSum:0;
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if(item.tag==2){
        if (![HQZXUserModel sharedInstance].isLogined) {
            HQZXLoginViewController *vc = [[HQZXLoginViewController alloc] init];
            UINavigationController *textNav = [[UINavigationController alloc] initWithRootViewController: vc];
            [CommonUtils setNavigationControllerStyle: textNav];
            [self presentViewController: textNav animated: YES completion:^{
                self.selectedIndex = 0;
            }];
        }else{
            if (![HQZXUserModel sharedInstance].isAuthen) {
                HQZXRealNameAuthenticationViewController *au = [[HQZXRealNameAuthenticationViewController alloc] init];
                [rootNav pushViewController:au animated:YES];
            }
        }
    }
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if(viewController.tabBarItem.tag==2){
        if (![HQZXUserModel sharedInstance].isLogined) {
            return NO;
        }else{
            if (![HQZXUserModel sharedInstance].isAuthen) {
                return NO;
            }
        }
        return YES;
    }else {
        return YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    self.recentViewCntlr = nil;
    self.contactsViewCntlr = nil;
    self.meViewCntlr = nil;
}
@end
