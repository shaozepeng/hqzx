//
//  HRCoverView.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/19.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^task)(UIViewController *);

@interface HRCoverView : UIView

@property (nonatomic, copy) task jump;
@property(nonatomic, strong) void (^changeButBlock)(NSInteger NUM);
@end
