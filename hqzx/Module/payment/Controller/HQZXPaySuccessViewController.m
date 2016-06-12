//
//  HQZXPaySuccessViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/4.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXPaySuccessViewController.h"

@implementation HQZXPaySuccessViewController{
    UIImageView *renImageView;
    UILabel *shenfenInfo;
    UILabel *nameInfo;
    UILabel *cardInfo;
    UILabel *idInfo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    self.title = LocatizedStirngForkey(@"FUKUANCHENGGONG");
    NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
    
    UIImage *renImage = [UIImage imageNamed:@"icon_suessce"];
    renImageView = [[UIImageView alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/SUCCESSHEIGHT, TOP_HEIGHT+SCREEN_WIDTH/10, SCREEN_WIDTH/10, SCREEN_WIDTH/10)];
    [renImageView setImage:renImage];
    renImageView.layer.masksToBounds = YES;
    //    renImageView.layer.cornerRadius = renImageView.width/2;
    renImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview: renImageView];
    
    UILabel *tongguorenzheng = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    tongguorenzheng.text = LocatizedStirngForkey(@"FUKUANCHENGGONG");
    tongguorenzheng.font = [UIFont systemFontOfSize: SUCCESSFONTONETWO];
    tongguorenzheng.textColor = UIColorFromRGB(0x1EE409);
    
    if([language isEqualToString:@"zh-Hans"]){
        [tongguorenzheng sizeToFit];
    }else if([language isEqualToString:@"en"]){
        tongguorenzheng.lineBreakMode = NSLineBreakByCharWrapping;
        tongguorenzheng.numberOfLines = 0;
        [tongguorenzheng setW:SCREEN_WIDTH- renImageView.maxX-SCREEN_WIDTH/30-5 ];
        [tongguorenzheng setH:SCREEN_WIDTH/10];
    }
    
    [self.view addSubview: tongguorenzheng];
    
    [tongguorenzheng setX:renImageView.maxX+SCREEN_WIDTH/30 ];
    [tongguorenzheng setY:renImageView.y];
    
    shenfenInfo = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    shenfenInfo.text = LocatizedStirngForkey(@"NINDEFUKUANXINXI");
    shenfenInfo.font = [UIFont systemFontOfSize: SUCCESSFONTONE];
    shenfenInfo.textColor = UIColorFromRGB(0x6E7071);
    [self.view addSubview: shenfenInfo];
    [shenfenInfo sizeToFit];
    [shenfenInfo setX:renImageView.maxX+SCREEN_WIDTH/30 ];
    [shenfenInfo setY:tongguorenzheng.maxY+SCREEN_WIDTH/30];
    
    nameInfo = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    nameInfo.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"SHOUKUANZHANGHAO"),_userId];
    nameInfo.font = [UIFont systemFontOfSize: SUCCESSFONTONE];
    nameInfo.textColor = UIColorFromRGB(0x6E7071);
    [self.view addSubview: nameInfo];
    [nameInfo sizeToFit];
    [nameInfo setX:renImageView.maxX+SCREEN_WIDTH/30 ];
    [nameInfo setY:shenfenInfo.maxY+SCREEN_WIDTH/30];
    
    cardInfo = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    cardInfo.text = [NSString stringWithFormat:@"%@：￥%@",LocatizedStirngForkey(@"SHOUKUANJINE"),_jine];
    cardInfo.font = [UIFont systemFontOfSize: SUCCESSFONTONE];
    cardInfo.textColor = UIColorFromRGB(0x6E7071);
    [self.view addSubview: cardInfo];
    [cardInfo sizeToFit];
    [cardInfo setX:renImageView.maxX+SCREEN_WIDTH/30 ];
    [cardInfo setY:nameInfo.maxY+SCREEN_WIDTH/30];
    
    idInfo = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    idInfo.text = [NSString stringWithFormat:@"%@%@%@：%@",LocatizedStirngForkey(@"ZHEHE"),_sysname,LocatizedStirngForkey(@"SHULIANG"),_zhehe];
    idInfo.font = [UIFont systemFontOfSize: SUCCESSFONTONE];
    idInfo.textColor = UIColorFromRGB(0x6E7071);
    [self.view addSubview: idInfo];
    [idInfo sizeToFit];
    [idInfo setX:renImageView.maxX+SCREEN_WIDTH/30 ];
    [idInfo setY:cardInfo.maxY+SCREEN_WIDTH/30];

}
@end
