//
//  HQZXCertificationSuccessViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/29.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXCertificationSuccessViewController.h"

@implementation HQZXCertificationSuccessViewController{
    UIImageView *renImageView;
    UILabel *shenfenInfo;
    UILabel *nameInfo;
    UILabel *cardInfo;
    UILabel *idInfo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    self.title = LocatizedStirngForkey(@"RENZHENGCHENGGONG");

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(popToRootView)];
    
    NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
    
    UIImage *renImage = [UIImage imageNamed:@"icon_suessce"];
    renImageView = [[UIImageView alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/SUCCESSHEIGHT, TOP_HEIGHT+SCREEN_WIDTH/10, SCREEN_WIDTH/10, SCREEN_WIDTH/10)];
    [renImageView setImage:renImage];
    renImageView.layer.masksToBounds = YES;
//    renImageView.layer.cornerRadius = renImageView.width/2;
    renImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview: renImageView];
    
    UILabel *tongguorenzheng = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    tongguorenzheng.text = LocatizedStirngForkey(@"YITONGGUORENZHENG");
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
    shenfenInfo.text = LocatizedStirngForkey(@"NINDESHENFENXINXI");
    shenfenInfo.font = [UIFont systemFontOfSize: SUCCESSFONTONE];
    shenfenInfo.textColor = UIColorFromRGB(0x6E7071);
    [self.view addSubview: shenfenInfo];
    [shenfenInfo sizeToFit];
    [shenfenInfo setX:renImageView.maxX+SCREEN_WIDTH/30 ];
    [shenfenInfo setY:tongguorenzheng.maxY+SCREEN_WIDTH/30];
    
    nameInfo = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    nameInfo.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"XINGMING"),_name];
    nameInfo.font = [UIFont systemFontOfSize: SUCCESSFONTONE];
    nameInfo.textColor = UIColorFromRGB(0x6E7071);
    [self.view addSubview: nameInfo];
    [nameInfo sizeToFit];
    [nameInfo setX:renImageView.maxX+SCREEN_WIDTH/30 ];
    [nameInfo setY:shenfenInfo.maxY+SCREEN_WIDTH/30];
    
    cardInfo = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    cardInfo.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"ZHENGJIANLEIXING"),_cardType];
    cardInfo.font = [UIFont systemFontOfSize: SUCCESSFONTONE];
    cardInfo.textColor = UIColorFromRGB(0x6E7071);
    [self.view addSubview: cardInfo];
    [cardInfo sizeToFit];
    [cardInfo setX:renImageView.maxX+SCREEN_WIDTH/30 ];
    [cardInfo setY:nameInfo.maxY+SCREEN_WIDTH/30];
    
    idInfo = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    NSString *temp2 = [_cardId substringFromIndex:[_cardId length]-4];
    idInfo.text = [NSString stringWithFormat:@"%@：***************%@",LocatizedStirngForkey(@"ZHENGJIANHAOMA"),temp2];
    idInfo.font = [UIFont systemFontOfSize: SUCCESSFONTONE];
    idInfo.textColor = UIColorFromRGB(0x6E7071);
    [self.view addSubview: idInfo];
    [idInfo sizeToFit];
    [idInfo setX:renImageView.maxX+SCREEN_WIDTH/30 ];
    [idInfo setY:cardInfo.maxY+SCREEN_WIDTH/30];
    
//    UILabel *timeInfo = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
//    timeInfo.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"RENZHENGSHIJIAN"),@"2015-09-12 10:23:56"];
//    timeInfo.font = [UIFont systemFontOfSize: SUCCESSFONTONE];
//    timeInfo.textColor = UIColorFromRGB(0x6E7071);
//    [self.view addSubview: timeInfo];
//    [timeInfo sizeToFit];
//    [timeInfo setX:renImageView.maxX+SCREEN_WIDTH/30 ];
//    [timeInfo setY:idInfo.maxY+SCREEN_WIDTH/30];
}
-(void)popToRootView{
//    [self.navigationController popViewControllerAnimated:YES];
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:@"2" forKey:@"selectPlu"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLanguage"
                                                        object:self
                                                      userInfo:parameter];
}
-(void)setName:(NSString *)value{
    _name = NilToEmpty(value);
    nameInfo.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"XINGMING"),_name];
    [nameInfo sizeToFit];
    [nameInfo setX:renImageView.maxX+SCREEN_WIDTH/30 ];
    [nameInfo setY:shenfenInfo.maxY+SCREEN_WIDTH/30];
}
-(void)setCardType:(NSString *)value{
    _cardType = NilToEmpty(value);
    cardInfo.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"ZHENGJIANLEIXING"),_cardType];
    [cardInfo sizeToFit];
    [cardInfo setX:renImageView.maxX+SCREEN_WIDTH/30 ];
    [cardInfo setY:nameInfo.maxY+SCREEN_WIDTH/30];
}
-(void)setCardId:(NSString *)value{
    _cardId = NilToEmpty(value);
    idInfo.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"ZHENGJIANHAOMA"),_cardId];
    [idInfo sizeToFit];
    [idInfo setX:renImageView.maxX+SCREEN_WIDTH/30 ];
    [idInfo setY:cardInfo.maxY+SCREEN_WIDTH/30];
}
-(void)setTimeStem:(NSString *)value{
    _timeStem = NilToEmpty(value);
}
@end
