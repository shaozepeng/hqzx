//
//  HQZXKlineGraphViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/3.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXKlineGraphViewController.h"
#import "lineView.h"
#import "UIColor+helper.h"

@interface HQZXKlineGraphViewController ()
{
    lineView *lineview;
    UIButton *btnDay;
    UIButton *btnWeek;
    UIButton *btnMonth;
}
@end
@implementation HQZXKlineGraphViewController
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    self.title = LocatizedStirngForkey(@"KXIANTU");
    
    btnDay = [[UIButton alloc] initWithFrame:CGRectMake(20,TOP_HEIGHT+70, 50, 30)];
    [btnDay setTitle:@"日K" forState:UIControlStateNormal];
    [btnDay addTarget:self action:@selector(kDayLine) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonAttr:btnDay];
    [self.view addSubview:btnDay];
    // 周k按钮
    btnWeek = [[UIButton alloc] initWithFrame:CGRectMake(75, TOP_HEIGHT+70, 50, 30)];
    [btnWeek setTitle:@"周K" forState:UIControlStateNormal];
    [btnWeek addTarget:self action:@selector(kWeekLine) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonAttr:btnWeek];
    [self.view addSubview:btnWeek];
    // 月k按钮
    btnMonth = [[UIButton alloc] initWithFrame:CGRectMake(130, TOP_HEIGHT+70, 50, 30)];
    [btnMonth setTitle:@"月K" forState:UIControlStateNormal];
    [btnMonth addTarget:self action:@selector(kMonthLine) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonAttr:btnMonth];
    [self.view addSubview:btnMonth];
    
    // 放大
    UIButton *btnBig = [[UIButton alloc] initWithFrame:CGRectMake(185, TOP_HEIGHT+70, 50, 30)];
    [btnBig setTitle:@"+" forState:UIControlStateNormal];
    [btnBig addTarget:self action:@selector(kBigLine) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonAttr:btnBig];
    [self.view addSubview:btnBig];
    
    // 缩小
    UIButton *btnSmall = [[UIButton alloc] initWithFrame:CGRectMake(240, TOP_HEIGHT+70, 50, 30)];
    [btnSmall setTitle:@"-" forState:UIControlStateNormal];
    [btnSmall addTarget:self action:@selector(kSmallLine) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonAttr:btnSmall];
    [self.view addSubview:btnSmall];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#111111" withAlpha:1];
    // 添加k线图
    lineview = [[lineView alloc] init];
    CGRect frame = self.view.frame;
    frame.origin = CGPointMake(0, TOP_HEIGHT+120);
    frame.size = CGSizeMake(310, 200);
    lineview.frame = frame;
    //lineview.backgroundColor = [UIColor blueColor];
    lineview.req_type = @"d";
    lineview.req_freq = @"601888.SS";
    lineview.kLineWidth = 5;
    lineview.kLinePadding = 0.5;
    [self.view addSubview:lineview];
    [lineview start]; // k线图运行
    [self setButtonAttrWithClick:btnDay];
}
-(void)kDayLine{
    [self setButtonAttrWithClick:btnDay];
    [self setButtonAttr:btnMonth];
    [self setButtonAttr:btnWeek];
    lineview.req_type = @"d";
    [self kUpdate];
}

-(void)kWeekLine{
    [self setButtonAttrWithClick:btnWeek];
    [self setButtonAttr:btnMonth];
    [self setButtonAttr:btnDay];
    lineview.req_type = @"w";
    [self kUpdate];
}

-(void)kMonthLine{
    [self setButtonAttrWithClick:btnMonth];
    [self setButtonAttr:btnWeek];
    [self setButtonAttr:btnDay];
    lineview.req_type = @"m";
    [self kUpdate];
}

-(void)kBigLine{
    lineview.kLineWidth += 1;
    [self kUpdate];
}

-(void)kSmallLine{
    lineview.kLineWidth -= 1;
    if (lineview.kLineWidth<=1) {
        lineview.kLineWidth = 1;
    }
    [self kUpdate];
}

-(void)kUpdate{
    [lineview update];
}

-(void)setButtonAttr:(UIButton*)button{
    button.backgroundColor = [UIColor blackColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
-(void)setButtonAttrWithClick:(UIButton*)button{
    button.backgroundColor = [UIColor colorWithHexString:@"cccccc" withAlpha:1];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
@end
