//
//  HQZXPaymentViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/4.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXPaymentViewController.h"
#import "SYQrCode.h"

@interface HQZXPaymentViewController (){
    UIImageView *imageView;
    UIView *operBuyView;
    UILabel *kmrmb;
    UILabel *lblkmrmb;
    UILabel *kmxyb;
    UILabel *lblkmxyb;
    UILabel *mairjiag;
    UITextField *txtBuyText;
    UILabel *sellrjiag;
    UITextField *txtSellText;
    UILabel *zhehje;
    UILabel *lblzhehje;
    UILabel *jiaoymm;
    UITextField *txtJiaoymmText;
    UIButton *btnBuy;
}
@end

@implementation HQZXPaymentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    self.title = LocatizedStirngForkey(@"WOYAOFUKUAN");
    
    [self createOperationView];
}

-(void)createOperationView{
    operBuyView = [[UIView alloc] initWithFrame: CGRectMake(0, TOP_HEIGHT+8, SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT-8)];
    operBuyView.backgroundColor = UIColorFromRGB(0x0F151A);
    [self.view addSubview:operBuyView];
    
    //    UIView *operSellView = [[UIView alloc] initWithFrame: CGRectMake(0, buyView.maxY+8, scrollView.width, SCREEN_WIDTH/1.5)];
    //    operSellView.backgroundColor = UIColorFromRGB(0x0F151A);
    //    [scrollView addSubview:operSellView];
    //    operSellView.hidden = YES;
    
    kmrmb = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/30, SCREEN_WIDTH/30, 1, 1)];
    //    LocatizedStirngForkey(@"CHEDAN")
    
    kmrmb.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"SHOUKUANZHANGHU") ];
    kmrmb.font = [UIFont systemFontOfSize: TRANSACTIONFONT];
    kmrmb.textColor = UIColorFromRGB(0xF4F4F4);
    [operBuyView addSubview: kmrmb];
    [kmrmb sizeToFit];
    
    lblkmrmb = [[UILabel alloc] initWithFrame: CGRectMake(kmrmb.maxX, kmrmb.y, 1, 1)];
    lblkmrmb.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
    lblkmrmb.font = [UIFont systemFontOfSize: TRANSACTIONFONT];
    lblkmrmb.textColor = UIColorFromRGB(0x3177E0);
    [operBuyView addSubview: lblkmrmb];
    [lblkmrmb sizeToFit];
    
    kmxyb = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/30, kmrmb.maxY+SCREEN_WIDTH/50, 1, 1)];
    kmxyb.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"SHOUKUANBIZHONG") ];
    kmxyb.font = [UIFont systemFontOfSize: TRANSACTIONFONT];
    kmxyb.textColor = UIColorFromRGB(0xF4F4F4);
    [operBuyView addSubview: kmxyb];
    [kmxyb sizeToFit];
    
    lblkmxyb = [[UILabel alloc] initWithFrame: CGRectMake(kmxyb.maxX, kmxyb.y, 1, 1)];
    lblkmxyb.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
    lblkmxyb.font = [UIFont systemFontOfSize: TRANSACTIONFONT];
    lblkmxyb.textColor = UIColorFromRGB(0xF4F4F4);
    [operBuyView addSubview: lblkmxyb];
    [lblkmxyb sizeToFit];
    
    mairjiag = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/40, kmxyb.maxY+SCREEN_WIDTH/18, 1, 1)];
    mairjiag.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"ZHIFURENMINBI") ];
    mairjiag.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    mairjiag.textColor = UIColorFromRGB(0xF4F4F4);
    [operBuyView addSubview: mairjiag];
    
    CGSize textSize = JHTCalcStringSizeWithFontSize(@"乌鲁木齐：", TRANSACTIONFTHREE);
    NSString *zhifu = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"ZHIFURENMINBI")];
    CGSize textSize2 = JHTCalcStringSizeWithFontSize(zhifu, TRANSACTIONFTHREE);
    [mairjiag sizeToFit];
    [mairjiag setAdjustsFontSizeToFitWidth:YES];
    if(textSize2.width>textSize.width){
        [mairjiag setW:textSize.width];
        [mairjiag setH:textSize.height];
    }
    
    txtBuyText = [[UITextField alloc] initWithFrame:CGRectMake(mairjiag.maxX +SCREEN_WIDTH/50, kmxyb.maxY+SCREEN_WIDTH/36 ,  SCREEN_WIDTH-mairjiag.maxX -SCREEN_WIDTH/22, SCREEN_WIDTH/10)];
    [operBuyView addSubview: txtBuyText];
    //    [txtBuyText setEnabled:NO];
    txtBuyText.textColor = UIColorFromRGB(0x767D85);
    txtBuyText.font = [UIFont systemFontOfSize:TRANSACTIONFTWO];
    txtBuyText.layer.borderColor=UIColorFromRGB(0x192631).CGColor;
    txtBuyText.layer.borderWidth= 1.0f;
    
    zhehje = [[UILabel alloc] initWithFrame: CGRectMake(txtBuyText.x+SCREEN_WIDTH/40, txtBuyText.maxY+SCREEN_WIDTH/30, 1, 1)];
    zhehje.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"ZHEHEBITEBISHULIANG") ];
    zhehje.font = [UIFont systemFontOfSize: TRANSACTIONFFORE];
    zhehje.textColor = UIColorFromRGB(0xF4F4F4);
    [operBuyView addSubview: zhehje];
    [zhehje sizeToFit];
    
    lblzhehje = [[UILabel alloc] initWithFrame: CGRectMake(zhehje.maxX+SCREEN_WIDTH/40, zhehje.y, 1, 1)];
    lblzhehje.text = @"0.00";
    lblzhehje.font = [UIFont systemFontOfSize: TRANSACTIONFFORE];
    lblzhehje.textColor = [UIColor whiteColor];
    [operBuyView addSubview: lblzhehje];
    [lblzhehje sizeToFit];
    
    jiaoymm = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/40, zhehje.maxY+SCREEN_WIDTH/20, 1, 1)];
    jiaoymm.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"JIAOYIMIMA") ];
    jiaoymm.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    jiaoymm.textColor = UIColorFromRGB(0xF4F4F4);
    [operBuyView addSubview: jiaoymm];
    [jiaoymm sizeToFit];
    
    txtJiaoymmText = [[UITextField alloc] initWithFrame:CGRectMake(jiaoymm.maxX +SCREEN_WIDTH/50, zhehje.maxY+SCREEN_WIDTH/40 ,  SCREEN_WIDTH-jiaoymm.maxX -SCREEN_WIDTH/22, SCREEN_WIDTH/10)];
    [operBuyView addSubview: txtJiaoymmText];
    //    [txtBuyText setEnabled:NO];
    txtJiaoymmText.secureTextEntry = YES;
    txtJiaoymmText.textColor = UIColorFromRGB(0x767D85);
    txtJiaoymmText.font = [UIFont systemFontOfSize:TRANSACTIONFTWO];
    txtJiaoymmText.layer.borderColor=UIColorFromRGB(0x192631).CGColor;
    txtJiaoymmText.layer.borderWidth= 1.0f;
    
    btnBuy = [[UIButton alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/20, txtJiaoymmText.maxY+SCREEN_WIDTH/15 , SCREEN_WIDTH-SCREEN_WIDTH/10, SCREEN_WIDTH/8)];
    [btnBuy setTitle: LocatizedStirngForkey(@"QUERENFUKUAN") forState: UIControlStateNormal];
    btnBuy.titleLabel.font = [UIFont systemFontOfSize: LOGINFONTBUTONE];
    [btnBuy.layer setMasksToBounds:YES];
    [btnBuy.layer setCornerRadius:5.0];
    [btnBuy setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [btnBuy setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3178E3)] forState:UIControlStateNormal];
    [btnBuy setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3A5FCD)] forState:UIControlStateHighlighted];
    
    [btnBuy addTarget: self action: @selector(shouSuccess) forControlEvents:UIControlEventTouchUpInside];
    [operBuyView addSubview: btnBuy];
    
    CGRect pointValueRect = CGRectMake(SCREEN_WIDTH/24, btnBuy.maxY+SCREEN_WIDTH/TRANFONTHEIGHT ,SCREEN_WIDTH-SCREEN_WIDTH/12, 50);
    UILabel *pointValue = [[UILabel alloc] initWithFrame:pointValueRect];
    pointValue.font = [UIFont systemFontOfSize:TRANFONTTWO];
    pointValue.textColor = UIColorFromRGB(0x666B70);
    pointValue.lineBreakMode = NSLineBreakByCharWrapping;
    pointValue.numberOfLines = 0;//上面两行设置多行显示
    pointValue.text = LocatizedStirngForkey(@"SHOUKUANSHUOMING");
    [operBuyView addSubview: pointValue];
}
-(void)shouSuccess{
    HQZXPaySuccessViewController *paysuccess=[[HQZXPaySuccessViewController alloc]init];
    [self.navigationController pushViewController:paysuccess animated:YES];
}
@end
