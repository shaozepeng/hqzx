//
//  CustomRowView.h
//  jht
//
//  Created by 邵泽鹏 on 15/7/6.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomRowView : UIView

@property(nonatomic,strong) UIButton *customBtn;
+ (CustomRowView *)userdInstance;
-(UIView*)customView:(NSArray*) arrayView;
@property(nonatomic, strong) void (^Custom_Block)(NSInteger value);

@end
