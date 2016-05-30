//
//  HQZXServiceAgreementViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/29.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXServiceAgreementViewController.h"

@implementation HQZXServiceAgreementViewController{
    UIScrollView *scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
//    self.title = LocatizedStirngForkey(@"RENZHENGCHENGGONG");
    self.title = @"环球在线服务协议";
    
    scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH-TOP_HEIGHT)];
    scrollView.backgroundColor = UIColorFromRGB(0x0C1319);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
    [self.view addSubview:scrollView];
    
//    NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
//    if([language isEqualToString:@"zh-Hans"]){
//        [tongguorenzheng sizeToFit];
//    }else if([language isEqualToString:@"en"]){
//        tongguorenzheng.lineBreakMode = NSLineBreakByCharWrapping;
//        tongguorenzheng.numberOfLines = 0;
//        [tongguorenzheng setW:SCREEN_WIDTH- renImageView.maxX-SCREEN_WIDTH/30-5 ];
//        [tongguorenzheng setH:SCREEN_WIDTH/10];
//    }
    
    
    UILabel *tongguorenzheng = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    tongguorenzheng.text = @"环球在线用户注册协议";
    tongguorenzheng.font = [UIFont systemFontOfSize: SUCCESSFONTONETWO];
    tongguorenzheng.textColor = [UIColor whiteColor];
    [tongguorenzheng sizeToFit];
    [scrollView addSubview: tongguorenzheng];
    [tongguorenzheng setX:(SCREEN_WIDTH-tongguorenzheng.width)/2];
    [tongguorenzheng setY:SCREEN_WIDTH/20];
//
    UILabel *shenfenInfo = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    shenfenInfo.text = @"公司规定啊是坎大哈开始打卡圣诞卡上看风景哈萨克积分换卡收费啊是坎大哈开始打卡圣诞卡上看风景哈萨克积分换卡收费啊是坎大哈开始打卡圣诞卡上看风景哈萨克积分换卡收费啊是坎大哈开始打卡圣诞卡上看风景哈萨克积分换卡收费";
    shenfenInfo.font = [UIFont systemFontOfSize: 12];
    shenfenInfo.textColor = [UIColor whiteColor];
    shenfenInfo.lineBreakMode = NSLineBreakByCharWrapping;
    shenfenInfo.numberOfLines = 0;
    [shenfenInfo setX:SCREEN_WIDTH/30 ];
    [shenfenInfo setW:SCREEN_WIDTH-SCREEN_WIDTH/15 ];
    [shenfenInfo setH:SCREEN_WIDTH/5];
    [shenfenInfo setY:tongguorenzheng.maxY+SCREEN_WIDTH/30];
    [scrollView addSubview: shenfenInfo];
//
    UILabel *nameInfo = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    nameInfo.text = @"1.环球在线用户注册协议";
    nameInfo.font = [UIFont systemFontOfSize: SUCCESSFONTONE];
    nameInfo.textColor = [UIColor whiteColor];
    [scrollView addSubview: nameInfo];
    [nameInfo sizeToFit];
    [nameInfo setX:SCREEN_WIDTH/30 ];
    [nameInfo setY:shenfenInfo.maxY+SCREEN_WIDTH/30];
    
    UILabel *cardInfo = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    cardInfo.text = @"公司规定啊是坎大哈开始打卡圣诞卡上看风景哈萨克积分换卡收费啊是坎大哈开始打卡圣诞卡上看风景哈萨克积分换卡收费啊是坎大哈开始打卡圣诞卡上看风景哈萨克积分换卡收费啊是坎大哈开始打卡圣诞卡上看风景哈萨克积分换卡收费";
    cardInfo.font = [UIFont systemFontOfSize: 12];
    cardInfo.textColor = [UIColor whiteColor];
    cardInfo.lineBreakMode = NSLineBreakByCharWrapping;
    cardInfo.numberOfLines = 0;
    [cardInfo setX:SCREEN_WIDTH/30 ];
    [cardInfo setW:SCREEN_WIDTH-SCREEN_WIDTH/15 ];
    [cardInfo setH:SCREEN_WIDTH/5];
    [cardInfo setY:nameInfo.maxY+SCREEN_WIDTH/30];
    [scrollView addSubview: cardInfo];
//
//    UILabel *cardInfo = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
//    cardInfo.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"ZHENGJIANLEIXING"),@"身份证"];
//    cardInfo.font = [UIFont systemFontOfSize: SUCCESSFONTONE];
//    cardInfo.textColor = UIColorFromRGB(0x6E7071);
//    [self.view addSubview: cardInfo];
//    [cardInfo sizeToFit];
//    [cardInfo setX:renImageView.maxX+SCREEN_WIDTH/30 ];
//    [cardInfo setY:nameInfo.maxY+SCREEN_WIDTH/30];
//    
//    UILabel *idInfo = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
//    idInfo.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"ZHENGJIANHAOMA"),@"**************3467"];
//    idInfo.font = [UIFont systemFontOfSize: SUCCESSFONTONE];
//    idInfo.textColor = UIColorFromRGB(0x6E7071);
//    [self.view addSubview: idInfo];
//    [idInfo sizeToFit];
//    [idInfo setX:renImageView.maxX+SCREEN_WIDTH/30 ];
//    [idInfo setY:cardInfo.maxY+SCREEN_WIDTH/30];
//    
//    UILabel *timeInfo = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
//    timeInfo.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"RENZHENGSHIJIAN"),@"2015-09-12 10:23:56"];
//    timeInfo.font = [UIFont systemFontOfSize: SUCCESSFONTONE];
//    timeInfo.textColor = UIColorFromRGB(0x6E7071);
//    [self.view addSubview: timeInfo];
//    [timeInfo sizeToFit];
//    [timeInfo setX:renImageView.maxX+SCREEN_WIDTH/30 ];
//    [timeInfo setY:idInfo.maxY+SCREEN_WIDTH/30];
}
@end
