//
//  HQZXRMBWithdrawalsViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/5.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXRMBWithdrawalsViewController.h"
@interface HQZXRMBWithdrawalsViewController (){
    UIView *topLineView;
    UIView *topView;
    UIView *bottomLineView;
}
@end

@implementation HQZXRMBWithdrawalsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    self.title = LocatizedStirngForkey(@"RENMINBITIXIAN");
    
    [self createTopBody];
}
-(void)createTopBody{
//    topLineView = [[UIView alloc] initWithFrame: CGRectMake(0, TOP_HEIGHT+8, SCREEN_WIDTH, 1)];
//    topLineView.backgroundColor = UIColorFromRGB(0x192631);
//    [self.view addSubview:topLineView];
//    
//    topView = [[UIView alloc] initWithFrame: CGRectMake(0, topLineView.maxY, SCREEN_WIDTH, SCREEN_WIDTH/10)];
//    topView.backgroundColor = UIColorFromRGB(0x0F151B);
//    [self.view addSubview:topView];
//    
//    UILabel *seceltLab = [[UILabel alloc]initWithFrame:CGRectMake(0, TOP_HEIGHT+8, SCREEN_WIDTH, 1)];
//    seceltLab.text = LocatizedStirngForkey(@"WOYIYUEDU");
//    seceltLab.font = [UIFont systemFontOfSize: fontCon];
//    seceltLab.textColor = UIColorFromRGB(0x86878B);
//    [self.view addSubview: seceltLab];
//    [seceltLab sizeToFit];
//    [seceltLab setX:clickText.maxX+SCREEN_WIDTH/fontSmallLeft ];
//    [seceltLab setY:form2.maxY+(clickText.height-contract.height)/2 +SCREEN_WIDTH/30];
//    
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(txtLianText.maxX , 0, SCREEN_WIDTH/8, form1.height/5);
//    [backBtn setTintColor:[UIColor whiteColor]];
//    [backBtn setTitleColor:UIColorFromRGB(0x293035) forState:UIControlStateNormal];
//    UIImage *leftBtnImage = [UIImage imageNamed:@"icon_jt_bo_bl"];
//    [backBtn setImage:leftBtnImage forState:UIControlStateNormal];
//    [form1 addSubview: backBtn];
//    
//    UIView *clickView = [[UIView alloc]initWithFrame:CGRectMake(iconLianText.maxX + SCREEN_WIDTH/30, 0 , form1.width - iconLianText.maxX - SCREEN_WIDTH/30, form1.height/5-1)];
//    clickView.userInteractionEnabled = YES;
//    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCountry)];
//    
//    [clickView addGestureRecognizer:tapGesture];
//    [form1 addSubview: clickView];
//    
//    bottomLineView = [[UIView alloc] initWithFrame: CGRectMake(0, topView.maxY, SCREEN_WIDTH, 1)];
//    bottomLineView.backgroundColor = UIColorFromRGB(0x192631);
//    [self.view addSubview:bottomLineView];
}
@end
