//
//  MyContactsViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/19.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "MyContactsViewController.h"

@implementation MyContactsViewController{
    UIBarButtonItem *temporaryBarButtonItem;
    BOOL isTouch;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = LocatizedStirngForkey(@"TWO");
    [self.view setBackgroundColor:UIColorFromRGB(0x0C1319)];
    
    isTouch =YES;
    temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 60, 44);
    [backBtn setTintColor:[UIColor whiteColor]];
    [backBtn setTitle:@"En" forState:UIControlStateNormal];
    [backBtn setTitleColor:UIColorFromRGB(0x439AFE) forState:UIControlStateNormal];
    UIImage *leftBtnImage = [UIImage imageNamed:@"icon_jt_bottom"];
    [backBtn setImage:leftBtnImage forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake((backBtn.frame.size.height-leftBtnImage.size.height)/2+2,50,(backBtn.frame.size.height-leftBtnImage.size.height)/2-2,2);
    //icon_tann_pressed incomingletter
    
    [backBtn addTarget:self action:@selector(createCover) forControlEvents:UIControlEventTouchUpInside];
    
    [temporaryBarButtonItem setCustomView:backBtn];
    self.tabBarController.navigationItem.rightBarButtonItem = temporaryBarButtonItem;
    
    
    //    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = 0;
    self.tabBarController.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, temporaryBarButtonItem, nil];
}
-(void)viewWillAppear:(BOOL)animated {
    self.tabBarController.title = LocatizedStirngForkey(@"TWO");
    self.tabBarController.navigationItem.backBarButtonItem = temporaryBarButtonItem;
}
- (void)createCover{
    for (UIView *subView in self.tabBarController.view.subviews) {
        if ([subView isKindOfClass:[HRCoverView class]]) {
            isTouch = NO;
        }else{
            isTouch = YES;
        }
    }
    if(isTouch){
        NSLog(@"创建了一个遮盖");
        //创建遮盖
        HRCoverView *cover = [[HRCoverView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        //跳转
        cover.jump = ^(UIViewController *vc){
            
            //        self.iconBtn.hidden = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        [self.tabBarController.view addSubview:cover];
        isTouch = NO;
    }else{
        for (UIView *subView in self.tabBarController.view.subviews) {
            if ([subView isKindOfClass:[HRCoverView class]]) {
                [UIView animateWithDuration:0.5 animations:^{
                    subView.transform = CGAffineTransformMakeScale(0.01, 0.01);
                    //缩小到指定的位置
                    subView.center = CGPointMake(SCREEN_WIDTH-20,64);
                    
                }completion:^(BOOL finished) {
                    [subView removeFromSuperview];
                    isTouch = YES;
                }];
            }
        }
    }
    
}
@end
