//
//  TransactionFlowViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/31.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "TransactionFlowViewController.h"

@implementation TransactionFlowViewController{
    UIBarButtonItem *temporaryBarButtonItem;
    UIScrollView * scrollView;
    UIImageView *imageView;
    UIView *infoView;
    UILabel *lblTitle1;
    UILabel *lblTitle2;
    UILabel *lblTitle3;
    UILabel *lblTitle4;
    UILabel *lblTitle5;
    UILabel *lblZhuangzaigang;
    UILabel *lblXiezaigang;
    UILabel *lblKaibiaohaisheng;
    UIImageView *statusImg;
    UIImage *imageStatus;
    UILabel *lbltoubiaozhuangtai;
    UIImage *serviceimg;
    UIButton *btnContact;
    UIButton *btnContactText;
    
    UILabel *lblTitle31;
    UILabel *lblTitle21;
    UILabel *lblTitle51;
    UILabel *lblZhuangzaigang1;
    UIView *toolView;
    UIView *toolTwoView;
    UILabel *lblmaiyitext;
    UILabel *lblmaiyivalue;
    UILabel *lblbuyyitext;
    UILabel *lblbuyyivalue;
    UILabel *lblsellyitext;
    UILabel *lblsellyivalue;
    UIView *buyView;
    UIView *sellView;
    UIView *cheView;
    UIView *operBuyView;
    UIView *operSellView;
    UIView *tbView;
    
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
    
    UILabel *skmrmb;
    UILabel *lblskmrmb;
    UILabel *skmxyb;
    UILabel *lblskmxyb;
    UILabel *smairjiag;
    UITextField *txtSellsText;
    UILabel *ssellrjiag;
    UITextField *txtSsellText;
    UILabel *szhehje;
    UILabel *lblszhehje;
    UILabel *sjiaoymm;
    UITextField *txtsJiaoymmText;
    UIButton *btnSells;
    NSArray *buyAry;
    NSDictionary *buyDict;
    NSArray *sellAry;
    NSDictionary *sellDict;
    HQZXEmptyManager *hqzxEmptyManager;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    self.title = LocatizedStirngForkey(@"XINGYUNBIJIAOYI");
    
    temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setTintColor:[UIColor whiteColor]];
    //icon_tann_pressed incomingletter
    [backBtn setImage:[UIImage imageNamed:@"icon_kxt"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doKilne) forControlEvents:UIControlEventTouchUpInside];
    
    [temporaryBarButtonItem setCustomView:backBtn];
    
    
    //    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -12;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, temporaryBarButtonItem, nil];
    
    scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT)];
    scrollView.backgroundColor = UIColorFromRGB(0x0C1319);
    [self.view addSubview:scrollView];
    
    [self createBBDetailView];
    [self clickButton];
    [self createOperationView];
    [self createOperationTwoView];
    [self createTbView];
    [self reData];
    WEAK_SELF
    scrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself reData];
    }];
    HQZXEmptyData(self.myTableView, hqzxEmptyManager, nil);
}
-(void)refScrollView{
    [scrollView.header beginRefreshing];
}
-(void)reData{
    [[NetHttpClient sharedHTTPClient] request: @"/coins_detail.json" parameters: @{@"symbol": self.symbol,@"auth_key":[HQZXUserModel sharedInstance].currentUser.auth_key} completion:^(id obj) {
        [scrollView.header endRefreshing];
        if (obj==nil) {
            [self.view makeToast: @"查询服务器失败，请检查网络连接" duration: 0.5 position: CSToastPositionCenter];
            return;
        }
        if (![@"0" isEqualToString: StrValueFromDictionary(obj, ApiKey_ErrorCode)]) {
            [self.view makeToast: [obj objectForKey:@"message"] duration: 0.5 position: CSToastPositionCenter];
            return;
        }
        _dataDict = [[NSMutableDictionary alloc]initWithDictionary:obj];
        NSString *imageUrl = [NSString stringWithFormat:@"http://coins.zhaojizi.com%@",StrValueFromDictionary(_dataDict, @"img") ];
        [imageView sd_setImageWithURL: [NSURL URLWithString: imageUrl]];
        NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
        if([language isEqualToString:@"zh-Hans"]){
            lblTitle1.text = StrValueFromDictionary(_dataDict, @"name");
        }else if([language isEqualToString:@"en"]){
            lblTitle1.text = StrValueFromDictionary(_dataDict, @"ename");
        }
        NSString *pricedt = StrValueFromDictionary(_dataDict, @"price");
        NSString *pricedt2;
        if(pricedt.length>0){
            pricedt2 = pricedt;
        }else{
            pricedt2 = @"0.0000";
        }
        lblTitle4.text = [NSString stringWithFormat:@"￥%@",pricedt2];
        NSString *ratio = StrValueFromDictionary(_dataDict, @"ratio");
        NSRange foundObj=[ratio rangeOfString:@"-" options:NSCaseInsensitiveSearch];
        NSString *baizhi;
        if(foundObj.length>0){
            [btnContactText setBackgroundColor:UIColorFromRGB(0x138E02)];
            baizhi = [NSString stringWithFormat:@"%0.2f％",[ratio floatValue]];
        }else{
            baizhi = [NSString stringWithFormat:@"+%0.2f％",[ratio floatValue]];
        }
        [btnContactText setTitle:baizhi  forState: UIControlStateNormal];
        lblTitle3.text = @"12784.5";
        lblTitle2.text = StrValueFromDictionary(_dataDict, @"volume");
        NSString *min_price = StrValueFromDictionary(_dataDict, @"min_price");
        NSString *min_price2;
        if(min_price.length>0){
            min_price2 = min_price;
        }else{
            min_price2 = @"0.0000";
        }
        lblTitle5.text = min_price2;
        NSString *max_price = StrValueFromDictionary(_dataDict, @"max_price");
        NSString *max_price2;
        if(max_price.length>0){
            max_price2 = max_price;
        }else{
            max_price2 = @"0.0000";
        }
        lblZhuangzaigang.text = max_price2;
        buyAry = [_dataDict objectForKey:@"buy_list"];
        if(buyAry.count>0){
            buyDict = [buyAry objectAtIndex:0];
        }
        sellAry = [_dataDict objectForKey:@"sell_list"];
        if(sellAry.count>0){
            sellDict = [sellAry objectAtIndex:0];
        }
        
        lblbuyyivalue.text = [NSString stringWithFormat:@"￥%@",StrValueFromDictionary(buyDict, @"price")?StrValueFromDictionary(buyDict, @"price"):@"0.0000"];
        NSString *procesd = StrValueFromDictionary(sellDict, @"price");
        NSString *balasd = StrValueFromDictionary(_dataDict, @"account_balance");
        NSString *priceGG = StrValueFromDictionary(_dataDict, @"price");
        lblsellyivalue.text = [NSString stringWithFormat:@"￥%@",procesd?procesd:@"0.0000"];
        
        lblkmrmb.text = [NSString stringWithFormat:@"￥%@",balasd?balasd:@"0.0000"];
        float balasdFlo = [balasd floatValue];
        float priceGGFlo = [priceGG floatValue];
        float divisionbp;
        if(balasdFlo>0 && priceGGFlo>0){
            divisionbp = (float)balasdFlo/priceGGFlo;
        }else{
            divisionbp = 0.0000;
        }
        
        lblkmxyb.text = [NSString stringWithFormat:@"%0.2f",divisionbp];
        NSString *coins = StrValueFromDictionary(_dataDict, @"coins_balance");
        lblskmrmb.text = coins;
        NSString *frozen = StrValueFromDictionary(_dataDict, @"frozen");
        if(frozen.length>0){
            lblskmxyb.text = StrValueFromDictionary(_dataDict, @"frozen");
        }else{
            lblskmxyb.text = @"0";
        }
        txtBuyText.text = pricedt2;
//        NSString *balance = coins;
        txtSellText.text = @"";
        txtSellsText.text = pricedt2;
        txtSsellText.text = @"";
        
//        float sooNy = [pricedt2 floatValue]*[coins intValue];
        lblzhehje.text = @"0.0000";
        lblszhehje.text = @"0.0000";
        txtJiaoymmText.text = @"";
        txtsJiaoymmText.text = @"";

        [self reLayout];
        [self.myTableView reloadData];
    }];
}
-(void)reLayout{
    [lblszhehje sizeToFit];
    [lblzhehje sizeToFit];
    [lblskmrmb sizeToFit];
    [lblskmxyb sizeToFit];
    [lblkmxyb sizeToFit];
    [lblkmrmb sizeToFit];
    NSString *buyPrice = [NSString stringWithFormat:@"￥%@",StrValueFromDictionary(buyDict, @"price")];
    CGSize textSize566 = JHTCalcStringSizeWithFontSize(@"￥3.229", FIRSTFONTTHREE);
    CGSize textSize552 = JHTCalcStringSizeWithFontSize(buyPrice, FIRSTFONTTHREE);
    [lblbuyyivalue setAdjustsFontSizeToFitWidth:YES];
    [lblbuyyivalue sizeToFit];
    if(textSize552.width>textSize566.width){
        [lblbuyyivalue setW:textSize566.width];
        [lblbuyyivalue setH:textSize566.height];
    }
    [lblbuyyivalue setX:lblbuyyitext.maxX];
    [lblbuyyivalue setY:lblbuyyitext.y];
    NSString *sellPrice = [NSString stringWithFormat:@"￥%@",StrValueFromDictionary(sellDict, @"price")];
    CGSize textSize562 = JHTCalcStringSizeWithFontSize(sellPrice, FIRSTFONTTHREE);
    [lblsellyivalue setAdjustsFontSizeToFitWidth:YES];
    [lblsellyivalue sizeToFit];
    if(textSize562.width>textSize566.width){
        [lblsellyivalue setW:textSize566.width];
        [lblsellyivalue setH:textSize566.height];
    }
    [lblsellyivalue setX:lblsellyitext.maxX];
    [lblsellyivalue setY:lblbuyyitext.y];
    CGSize textSize51 = JHTCalcStringSizeWithFontSize(@"1888.8888万", FIRSTFONTTHREE);
    CGSize textSize522 = JHTCalcStringSizeWithFontSize(StrValueFromDictionary(_dataDict, @"max_price"), FIRSTFONTTHREE);
    [lblZhuangzaigang setAdjustsFontSizeToFitWidth:YES];
    [lblZhuangzaigang sizeToFit];
    if(textSize522.width>textSize51.width){
        [lblZhuangzaigang setW:textSize51.width];
        [lblZhuangzaigang setH:textSize51.height];
    }
    [lblZhuangzaigang setX:SCREEN_WIDTH*0.7];
    [lblZhuangzaigang setY:lblZhuangzaigang1.maxY+toolView.height/10];
    CGSize textSize52 = JHTCalcStringSizeWithFontSize(StrValueFromDictionary(_dataDict, @"min_price"), FIRSTFONTTHREE);
    [lblTitle5 setAdjustsFontSizeToFitWidth:YES];
    [lblTitle5 sizeToFit];
    if(textSize52.width>textSize51.width){
        [lblTitle5 setW:textSize51.width];
        [lblTitle5 setH:textSize51.height];
    }
    [lblTitle5 setX:SCREEN_WIDTH*0.35];
    [lblTitle5 setY:lblTitle51.maxY+toolView.height/10];
    CGSize textSize22 = JHTCalcStringSizeWithFontSize(StrValueFromDictionary(_dataDict, @"volume"), FIRSTFONTTHREE);
    [lblTitle2 setAdjustsFontSizeToFitWidth:YES];
    [lblTitle2 sizeToFit];
    if(textSize22.width>textSize51.width){
        [lblTitle2 setW:textSize51.width];
        [lblTitle2 setH:textSize51.height];
    }
    [lblTitle2 setX:imageView.x+imageView.width/IMAGELEFT+COMMON_H_MARGIN];
    [lblTitle2 setY:lblTitle21.maxY+toolView.height/10];
    CGSize textSize2 = JHTCalcStringSizeWithFontSize(StrValueFromDictionary(_dataDict, @"turnover"), FIRSTFONTTHREE);
    [lblTitle3 setAdjustsFontSizeToFitWidth:YES];
    [lblTitle3 sizeToFit];
    if(textSize2.width>textSize51.width){
        [lblTitle3 setW:textSize51.width];
        [lblTitle3 setH:textSize51.height];
    }
    [lblTitle3 setX:lblTitle31.x];
    [lblTitle3 setY:lblTitle31.maxY+toolView.height/10];
    [lblTitle1 sizeToFit];
    [lblTitle1 setX:imageView.maxX + SCREEN_WIDTH/50];
    [lblTitle1 setY:imageView.y+(imageView.height-lblTitle1.height)/2];
    
    CGSize textSize112 = JHTCalcStringSizeWithFontSize(@"￥3.2293", FIRSTFONTTWO);
    CGSize textSize110 = JHTCalcStringSizeWithFontSize(buyPrice, FIRSTFONTTWO);
    [lblTitle4 setAdjustsFontSizeToFitWidth:YES];
    [lblTitle4 sizeToFit];
    if(textSize110.width>textSize112.width){
        [lblTitle4 setW:textSize112.width];
        [lblTitle4 setH:textSize112.height];
    }
    [lblTitle4 setX:SCREEN_WIDTH*0.53];
    [lblTitle4 setY:lblTitle1.y];
}
-(void)createBBDetailView{
    infoView = [[UIView alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/40, 10, scrollView.width - COMMON_H_MARGIN*2, DATRANHEIGHTONE*0.45 - 2)];
    infoView.backgroundColor = UIColorFromRGB(0x0D161C);
    [scrollView addSubview: infoView];
    
    UIImage *biIcon = [UIImage imageNamed:@"icon_bibi_1"];
    imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 8, biIcon.size.width*FIRSTHEIGHTTWO, biIcon.size.height*FIRSTHEIGHTTWO)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = biIcon;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 1;
    [infoView addSubview: imageView];
    
    lblTitle1 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    lblTitle1.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
    [infoView addSubview: lblTitle1];
    lblTitle1.font = [UIFont systemFontOfSize: FIRSTFONTONE];
    lblTitle1.textColor = UIColorFromRGB(0xFBFFFF);
    [lblTitle1 sizeToFit];
    [lblTitle1 setX:imageView.maxX + SCREEN_WIDTH/50];
    [lblTitle1 setY:imageView.y+(imageView.height-lblTitle1.height)/2];
    
    lblTitle4 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    lblTitle4.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
    [infoView addSubview: lblTitle4];
    lblTitle4.font = [UIFont boldSystemFontOfSize: FIRSTFONTTWO];
    lblTitle4.textColor = [UIColor whiteColor];
    [lblTitle4 sizeToFit];
    [lblTitle4 setX:SCREEN_WIDTH*0.55];
    [lblTitle4 setY:imageView.y+(imageView.height-lblTitle4.height)/2];
    
    btnContactText = [[UIButton alloc] init];
    [btnContactText setTitle: LocatizedStirngForkey(@"JIAZAIZHONGQ") forState: UIControlStateNormal];
    btnContactText.titleLabel.font = [UIFont systemFontOfSize: FIRSTFONTONE];
    btnContactText.titleLabel.textColor = [UIColor whiteColor];
    [btnContactText setBackgroundColor:[UIColor redColor]];
    [btnContactText sizeToFit];
    [btnContactText setX:lblTitle4.maxX+SCREEN_WIDTH/20];
    [btnContactText setY:imageView.y];
    [btnContactText setW:SCREEN_WIDTH-lblTitle4.maxX-SCREEN_WIDTH/10];
    [btnContactText setH:imageView.height];
    
    [btnContactText setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [infoView addSubview: btnContactText];
    
    UIView *line = [[UIView alloc] initWithFrame: CGRectMake(COMMON_H_MARGIN, infoView.maxY, scrollView.width , 1)];
    [line setBackgroundColor:UIColorFromRGB(0x141A21)];
    [scrollView addSubview: line];
    
    UIView *linetwo = [[UIView alloc] initWithFrame: CGRectMake(COMMON_H_MARGIN, line.maxY, scrollView.width, 1)];
    [linetwo setBackgroundColor:UIColorFromRGB(0x0B1219)];
    [scrollView addSubview: linetwo];
    
    toolView = [[UIView alloc] initWithFrame: CGRectMake(0, linetwo.maxY, scrollView.width, DATRANHEIGHTONE - linetwo.maxY)];
    toolView.backgroundColor = UIColorFromRGB(0x0D161C);
    [scrollView addSubview:toolView];
    //        #7D8285
//    lblTitle31 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
//    lblTitle31.text = LocatizedStirngForkey(@"CHENGJIAOE");
//    [toolView addSubview: lblTitle31];
//    lblTitle31.font = [UIFont systemFontOfSize: FIRSTFONTTHREE];
//    lblTitle31.textColor = UIColorFromRGB(0x7D8285);
//    [lblTitle31 sizeToFit];
//    NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
//    if([language isEqualToString:@"zh-Hans"]){
//        [lblTitle31 setX:imageView.x+imageView.width/IMAGELEFT+COMMON_H_MARGIN];
//    }else if([language isEqualToString:@"en"]){
//        [lblTitle31 setX:imageView.width/IMAGELEFT];
//    }
//    
//    [lblTitle31 setY:toolView.height/5];
//    
//    lblTitle3 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
//    lblTitle3.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
//    lblTitle3.textColor = UIColorFromRGB(0x7D8285);
//    [toolView addSubview: lblTitle3];
//    lblTitle3.font = [UIFont systemFontOfSize: FIRSTFONTTHREE];
//    [lblTitle3 sizeToFit];
//    [lblTitle3 setX:lblTitle31.x];
//    [lblTitle3 setY:lblTitle31.maxY+toolView.height/10];
    
    lblTitle21 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    lblTitle21.text = LocatizedStirngForkey(@"CHENGJIAOLIANG");
    lblTitle21.textColor = UIColorFromRGB(0x7D8285);
    lblTitle21.font = [UIFont systemFontOfSize: FIRSTFONTTHREE];
    [toolView addSubview: lblTitle21];
    [lblTitle21 sizeToFit];
    [lblTitle21 setX:imageView.x+imageView.width/IMAGELEFT+COMMON_H_MARGIN];
    [lblTitle21 setY:toolView.height/5];
    
    lblTitle2 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    lblTitle2.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
    lblTitle2.textColor = UIColorFromRGB(0x7D8285);
    lblTitle2.font = [UIFont systemFontOfSize: FIRSTFONTTHREE];
    [toolView addSubview: lblTitle2];
    [lblTitle2 sizeToFit];
    [lblTitle2 setX:lblTitle21.x];
    [lblTitle2 setY:lblTitle21.maxY+toolView.height/10];
    
    lblTitle51 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    lblTitle51.text = LocatizedStirngForkey(@"ZUIDIJIA");
    lblTitle51.textColor = UIColorFromRGB(0x7D8285);
    lblTitle51.font = [UIFont systemFontOfSize: FIRSTFONTTHREE];
    [toolView addSubview: lblTitle51];
    [lblTitle51 sizeToFit];
    [lblTitle51 setX:SCREEN_WIDTH*0.35];
    [lblTitle51 setY:toolView.height/5];
    
    lblTitle5 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    lblTitle5.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
    lblTitle5.textColor = UIColorFromRGB(0x7D8285);
    lblTitle5.font = [UIFont systemFontOfSize: FIRSTFONTTHREE];
    [toolView addSubview: lblTitle5];
    [lblTitle5 sizeToFit];
    [lblTitle5 setX:SCREEN_WIDTH*0.35];
    [lblTitle5 setY:lblTitle51.maxY+toolView.height/10];
    
    lblZhuangzaigang1 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    lblZhuangzaigang1.text = LocatizedStirngForkey(@"ZUIGAOJIA");
    lblZhuangzaigang1.textColor = UIColorFromRGB(0x7D8285);
    lblZhuangzaigang1.font = [UIFont systemFontOfSize: FIRSTFONTTHREE];
    [toolView addSubview: lblZhuangzaigang1];
    [lblZhuangzaigang1 sizeToFit];
    [lblZhuangzaigang1 setX:SCREEN_WIDTH*0.7];
    [lblZhuangzaigang1 setY:toolView.height/5];
    
    lblZhuangzaigang = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    lblZhuangzaigang.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
    lblZhuangzaigang.font = [UIFont systemFontOfSize: FIRSTFONTTHREE];
    lblZhuangzaigang.textColor = UIColorFromRGB(0x7D8285);
    [toolView addSubview: lblZhuangzaigang];
    [lblZhuangzaigang sizeToFit];
    [lblZhuangzaigang setX:SCREEN_WIDTH*0.7];
    [lblZhuangzaigang setY:lblZhuangzaigang1.maxY+toolView.height/10];
    
    toolTwoView = [[UIView alloc] initWithFrame: CGRectMake(0, toolView.maxY, scrollView.width, (DATRANHEIGHTONE - linetwo.maxY)*0.8)];
    toolTwoView.backgroundColor = UIColorFromRGB(0x0D161C);
    [scrollView addSubview:toolTwoView];
    
    lblbuyyitext = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    lblbuyyitext.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"BUYYIJIA")];
    lblbuyyitext.textColor = UIColorFromRGB(0xB4B4B4);
    lblbuyyitext.font = [UIFont systemFontOfSize: TRANSACTIONFTWO];
    [toolTwoView addSubview: lblbuyyitext];
    [lblbuyyitext sizeToFit];
    [lblbuyyitext setX:SCREEN_WIDTH/20];
    [lblbuyyitext setY:SCREEN_WIDTH/30];
    
    lblbuyyivalue = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    lblbuyyivalue.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
    lblbuyyivalue.textColor = UIColorFromRGB(0xB4B4B4);
    lblbuyyivalue.font = [UIFont systemFontOfSize: TRANSACTIONFTWO];
    [toolTwoView addSubview: lblbuyyivalue];
    [lblbuyyivalue sizeToFit];
    [lblbuyyivalue setX:lblbuyyitext.maxX];
    [lblbuyyivalue setY:lblbuyyitext.y];
    
    lblsellyitext = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    lblsellyitext.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"SELLYIJIA")];
    lblsellyitext.textColor = UIColorFromRGB(0xB4B4B4);
    lblsellyitext.font = [UIFont systemFontOfSize: TRANSACTIONFTWO];
    [toolTwoView addSubview: lblsellyitext];
    [lblsellyitext sizeToFit];
    [lblsellyitext setX:SCREEN_WIDTH*0.6];
    [lblsellyitext setY:lblbuyyitext.y];
    
    lblsellyivalue = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    lblsellyivalue.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
    lblsellyivalue.font = [UIFont systemFontOfSize: TRANSACTIONFTWO];
    lblsellyivalue.textColor = UIColorFromRGB(0xB4B4B4);
    [toolTwoView addSubview: lblsellyivalue];
    [lblsellyivalue sizeToFit];
    [lblsellyivalue setX:lblsellyitext.maxX];
    [lblsellyivalue setY:lblbuyyitext.y];
}
-(void)clickButton{
    buyView = [[UIView alloc] initWithFrame: CGRectMake(0, toolTwoView.maxY+8, (scrollView.width-4)/3, SCREEN_WIDTH/10)];
    buyView.backgroundColor = UIColorFromRGB(0x192834);
    [scrollView addSubview:buyView];
    
    buyView.userInteractionEnabled = YES;
     UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buyGe:)];
    [buyView addGestureRecognizer:tapGesture];
    
    UILabel *buylable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    buylable.text = LocatizedStirngForkey(@"MAIRU");
    buylable.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    buylable.textColor = [UIColor whiteColor];
    [buyView addSubview: buylable];
    [buylable sizeToFit];
    [buylable setX:(buyView.width-buylable.width)/2];
    [buylable setY:(buyView.height-buylable.height)/2];
    
    
    UIView *buyhenglineoneView = [[UIView alloc] initWithFrame: CGRectMake(0, toolTwoView.maxY+7, (scrollView.width-4)/3, 1)];
    buyhenglineoneView.backgroundColor = UIColorFromRGB(0x141D25);
    [scrollView addSubview:buyhenglineoneView];
    
    UIView *buylineoneView = [[UIView alloc] initWithFrame: CGRectMake(buyView.maxX, toolTwoView.maxY+8, 1, SCREEN_WIDTH/10)];
    buylineoneView.backgroundColor = UIColorFromRGB(0x141D25);
    [scrollView addSubview:buylineoneView];
    
    UIView *buylinetwoView = [[UIView alloc] initWithFrame: CGRectMake(buylineoneView.maxX, toolTwoView.maxY+8, 1, SCREEN_WIDTH/10)];
    buylinetwoView.backgroundColor = UIColorFromRGB(0x0D1318);
    [scrollView addSubview:buylinetwoView];
    
    sellView = [[UIView alloc] initWithFrame: CGRectMake(buylinetwoView.maxX, toolTwoView.maxY+8, (scrollView.width-4)/3, SCREEN_WIDTH/10)];
    sellView.backgroundColor = UIColorFromRGB(0x0F151A);
    [scrollView addSubview:sellView];
    
    sellView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sellGe:)];
    [sellView addGestureRecognizer:tapGesture2];
    
    UILabel *selllable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    selllable.text = LocatizedStirngForkey(@"MAICHU");
    selllable.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    selllable.textColor = [UIColor whiteColor];
    [sellView addSubview: selllable];
    [selllable sizeToFit];
    [selllable setX:(sellView.width-selllable.width)/2];
    [selllable setY:(sellView.height-selllable.height)/2];
    
    UIView *buyhenglinetwoView = [[UIView alloc] initWithFrame: CGRectMake(buylinetwoView.maxX, toolTwoView.maxY+7, (scrollView.width-4)/3, 1)];
    buyhenglinetwoView.backgroundColor = UIColorFromRGB(0x141D25);
    [scrollView addSubview:buyhenglinetwoView];
    
    UIView *buylinethreeView = [[UIView alloc] initWithFrame: CGRectMake(sellView.maxX, toolTwoView.maxY+8, 1, SCREEN_WIDTH/10)];
    buylinethreeView.backgroundColor = UIColorFromRGB(0x141D25);
    [scrollView addSubview:buylinethreeView];
    
    UIView *buylineforeView = [[UIView alloc] initWithFrame: CGRectMake(buylinethreeView.maxX, toolTwoView.maxY+8, 1, SCREEN_WIDTH/10)];
    buylineforeView.backgroundColor = UIColorFromRGB(0x0D1318);
    [scrollView addSubview:buylineforeView];
    
    
    cheView = [[UIView alloc] initWithFrame: CGRectMake(buylineforeView.maxX, toolTwoView.maxY+8, (scrollView.width-4)/3, SCREEN_WIDTH/10)];
    cheView.backgroundColor = UIColorFromRGB(0x0F151A);
    [scrollView addSubview:cheView];
    
    cheView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cheGe:)];
    [cheView addGestureRecognizer:tapGesture3];
    
    UILabel *chelable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    chelable.text = LocatizedStirngForkey(@"CHEDAN");
    chelable.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    chelable.textColor = [UIColor whiteColor];
    [cheView addSubview: chelable];
    [chelable sizeToFit];
    [chelable setX:(cheView.width-chelable.width)/2];
    [chelable setY:(cheView.height-chelable.height)/2];
    
    UIView *buyhenglinethreeView = [[UIView alloc] initWithFrame: CGRectMake(buylineforeView.maxX, toolTwoView.maxY+7, (scrollView.width-4)/3, 1)];
    buyhenglinethreeView.backgroundColor = UIColorFromRGB(0x141D25);
    [scrollView addSubview:buyhenglinethreeView];
}
-(void)createOperationView{
    operBuyView = [[UIView alloc] initWithFrame: CGRectMake(0, buyView.maxY+8, scrollView.width, SCREEN_WIDTH/1.3)];
    operBuyView.backgroundColor = UIColorFromRGB(0x0F151A);
    [scrollView addSubview:operBuyView];
    
//    UIView *operSellView = [[UIView alloc] initWithFrame: CGRectMake(0, buyView.maxY+8, scrollView.width, SCREEN_WIDTH/1.5)];
//    operSellView.backgroundColor = UIColorFromRGB(0x0F151A);
//    [scrollView addSubview:operSellView];
//    operSellView.hidden = YES;
    
    kmrmb = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/30, SCREEN_WIDTH/30, 1, 1)];
//    LocatizedStirngForkey(@"CHEDAN")
    
    kmrmb.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"KEYONGRENMINBI") ];
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
    kmxyb.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"KEMAIXINGYUNBI") ];
    kmxyb.font = [UIFont systemFontOfSize: TRANSACTIONFONT];
    kmxyb.textColor = UIColorFromRGB(0xF4F4F4);
    [operBuyView addSubview: kmxyb];
    [kmxyb sizeToFit];
    
    lblkmxyb = [[UILabel alloc] initWithFrame: CGRectMake(kmxyb.maxX, kmxyb.y, 1, 1)];
    lblkmxyb.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
    lblkmxyb.font = [UIFont systemFontOfSize: TRANSACTIONFONT];
    lblkmxyb.textColor = UIColorFromRGB(0xFC2408);
    [operBuyView addSubview: lblkmxyb];
    [lblkmxyb sizeToFit];
    
    mairjiag = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/40, kmxyb.maxY+SCREEN_WIDTH/18, 1, 1)];
    mairjiag.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"MAIRUJIAGE") ];
    mairjiag.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    mairjiag.textColor = UIColorFromRGB(0xF4F4F4);
    [operBuyView addSubview: mairjiag];
    [mairjiag sizeToFit];
    
    txtBuyText = [[UITextField alloc] initWithFrame:CGRectMake(mairjiag.maxX +SCREEN_WIDTH/50, kmxyb.maxY+SCREEN_WIDTH/36 ,  SCREEN_WIDTH-mairjiag.maxX -SCREEN_WIDTH/22, SCREEN_WIDTH/10)];
    [operBuyView addSubview: txtBuyText];
    txtBuyText.keyboardType = UIKeyboardTypeDecimalPad;
//    [txtBuyText setEnabled:NO];
    txtBuyText.textColor = UIColorFromRGB(0x767D85);
    txtBuyText.font = [UIFont systemFontOfSize:TRANSACTIONFTWO];
    txtBuyText.layer.borderColor=UIColorFromRGB(0x192631).CGColor;
    txtBuyText.layer.borderWidth= 1.0f;
    
    sellrjiag = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/40, txtBuyText.maxY+SCREEN_WIDTH/20, 1, 1)];
    sellrjiag.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"MAIRUSHULIANG") ];
    sellrjiag.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    sellrjiag.textColor = UIColorFromRGB(0xF4F4F4);
    [operBuyView addSubview: sellrjiag];
    [sellrjiag sizeToFit];
    
    txtSellText = [[UITextField alloc] initWithFrame:CGRectMake(sellrjiag.maxX +SCREEN_WIDTH/50, txtBuyText.maxY+SCREEN_WIDTH/40 ,  SCREEN_WIDTH-sellrjiag.maxX -SCREEN_WIDTH/22, SCREEN_WIDTH/10)];
    [operBuyView addSubview: txtSellText];
    //    [txtBuyText setEnabled:NO];
    txtSellText.keyboardType = UIKeyboardTypeDecimalPad;
    txtSellText.textColor = UIColorFromRGB(0x767D85);
    txtSellText.font = [UIFont systemFontOfSize:TRANSACTIONFTWO];
    txtSellText.layer.borderColor=UIColorFromRGB(0x192631).CGColor;
    txtSellText.layer.borderWidth= 1.0f;
    txtSellText.delegate = self;
    
    zhehje = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/40, txtSellText.maxY+SCREEN_WIDTH/30, 1, 1)];
    zhehje.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"ZHEHEJINE") ];
    zhehje.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    zhehje.textColor = UIColorFromRGB(0xF4F4F4);
    [operBuyView addSubview: zhehje];
    [zhehje sizeToFit];
    
    lblzhehje = [[UILabel alloc] initWithFrame: CGRectMake(zhehje.maxX+SCREEN_WIDTH/40, zhehje.y, 1, 1)];
    lblzhehje.text = @"0.00";
    lblzhehje.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
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
    txtJiaoymmText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    txtJiaoymmText.secureTextEntry = YES;
    txtJiaoymmText.textColor = UIColorFromRGB(0x767D85);
    txtJiaoymmText.font = [UIFont systemFontOfSize:TRANSACTIONFTWO];
    txtJiaoymmText.layer.borderColor=UIColorFromRGB(0x192631).CGColor;
    txtJiaoymmText.layer.borderWidth= 1.0f;
    
    btnBuy = [[UIButton alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/20, txtJiaoymmText.maxY+SCREEN_WIDTH/30 , SCREEN_WIDTH-SCREEN_WIDTH/10, SCREEN_WIDTH/8)];
    [btnBuy setTitle: LocatizedStirngForkey(@"MAIRU") forState: UIControlStateNormal];
    btnBuy.titleLabel.font = [UIFont systemFontOfSize: LOGINFONTBUTONE];
    [btnBuy.layer setMasksToBounds:YES];
    [btnBuy.layer setCornerRadius:5.0];
    [btnBuy setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [btnBuy setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0xFC373B)] forState:UIControlStateNormal];
    [btnBuy setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0xCD0000)] forState:UIControlStateHighlighted];
    
    [btnBuy addTarget: self action: @selector(buySummit) forControlEvents:UIControlEventTouchUpInside];
    [operBuyView addSubview: btnBuy];
    operBuyView.hidden = NO;
    
}
-(void)createOperationTwoView{
    operSellView = [[UIView alloc] initWithFrame: CGRectMake(0, buyView.maxY+8, scrollView.width, SCREEN_WIDTH/1.3)];
    operSellView.backgroundColor = UIColorFromRGB(0x0F151A);
    [scrollView addSubview:operSellView];
    
    //    UIView *operSellView = [[UIView alloc] initWithFrame: CGRectMake(0, buyView.maxY+8, scrollView.width, SCREEN_WIDTH/1.5)];
    //    operSellView.backgroundColor = UIColorFromRGB(0x0F151A);
    //    [scrollView addSubview:operSellView];
    //    operSellView.hidden = YES;
    
    skmrmb = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/30, SCREEN_WIDTH/30, 1, 1)];
    skmrmb.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"KESELLXINGYUNBI") ];
    skmrmb.font = [UIFont systemFontOfSize: TRANSACTIONFONT];
    skmrmb.textColor = UIColorFromRGB(0xF4F4F4);
    [operSellView addSubview: skmrmb];
    [skmrmb sizeToFit];
    
    lblskmrmb = [[UILabel alloc] initWithFrame: CGRectMake(skmrmb.maxX, skmrmb.y, 1, 1)];
    lblskmrmb.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
    lblskmrmb.font = [UIFont systemFontOfSize: TRANSACTIONFONT];
    lblskmrmb.textColor = UIColorFromRGB(0x3177E0);
    [operSellView addSubview: lblskmrmb];
    [lblskmrmb sizeToFit];
    
    skmxyb = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/30, skmrmb.maxY+SCREEN_WIDTH/50, 1, 1)];
    skmxyb.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"DONGJIEXINGYUNBI") ];
    skmxyb.font = [UIFont systemFontOfSize: TRANSACTIONFONT];
    skmxyb.textColor = UIColorFromRGB(0xF4F4F4);
    [operSellView addSubview: skmxyb];
    [skmxyb sizeToFit];
    
    lblskmxyb = [[UILabel alloc] initWithFrame: CGRectMake(skmxyb.maxX, skmxyb.y, 1, 1)];
    lblskmxyb.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
    lblskmxyb.font = [UIFont systemFontOfSize: TRANSACTIONFONT];
    lblskmxyb.textColor = UIColorFromRGB(0xFC2408);
    [operSellView addSubview: lblskmxyb];
    [lblskmxyb sizeToFit];
    
    smairjiag = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/40, skmxyb.maxY+SCREEN_WIDTH/18, 1, 1)];
    smairjiag.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"MAICHUJIAGE") ];
    smairjiag.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    smairjiag.textColor = UIColorFromRGB(0xF4F4F4);
    [operSellView addSubview: smairjiag];
    [smairjiag sizeToFit];
    
    txtSellsText = [[UITextField alloc] initWithFrame:CGRectMake(smairjiag.maxX +SCREEN_WIDTH/50, skmxyb.maxY+SCREEN_WIDTH/36 ,  SCREEN_WIDTH-smairjiag.maxX -SCREEN_WIDTH/22, SCREEN_WIDTH/10)];
    [operSellView addSubview: txtSellsText];
    //    [txtBuyText setEnabled:NO];
    txtSellsText.keyboardType = UIKeyboardTypeDecimalPad;
    txtSellsText.textColor = UIColorFromRGB(0x767D85);
    txtSellsText.font = [UIFont systemFontOfSize:TRANSACTIONFTWO];
    txtSellsText.layer.borderColor=UIColorFromRGB(0x192631).CGColor;
    txtSellsText.layer.borderWidth= 1.0f;
    
    ssellrjiag = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/40, txtSellsText.maxY+SCREEN_WIDTH/20, 1, 1)];
    ssellrjiag.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"MAICHUSHULIANG") ];
    ssellrjiag.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    ssellrjiag.textColor = UIColorFromRGB(0xF4F4F4);
    [operSellView addSubview: ssellrjiag];
    [ssellrjiag sizeToFit];
    
    txtSsellText = [[UITextField alloc] initWithFrame:CGRectMake(ssellrjiag.maxX +SCREEN_WIDTH/50, txtSellsText.maxY+SCREEN_WIDTH/40 ,  SCREEN_WIDTH-ssellrjiag.maxX -SCREEN_WIDTH/22, SCREEN_WIDTH/10)];
    [operSellView addSubview: txtSsellText];
    //    [txtBuyText setEnabled:NO];
    txtSsellText.keyboardType = UIKeyboardTypeDecimalPad;
    txtSsellText.textColor = UIColorFromRGB(0x767D85);
    txtSsellText.font = [UIFont systemFontOfSize:TRANSACTIONFTWO];
    txtSsellText.layer.borderColor=UIColorFromRGB(0x192631).CGColor;
    txtSsellText.layer.borderWidth= 1.0f;
    txtSsellText.delegate = self;
    
    szhehje = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/40, txtSsellText.maxY+SCREEN_WIDTH/30, 1, 1)];
    szhehje.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"ZHEHEJINE") ];
    szhehje.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    szhehje.textColor = UIColorFromRGB(0xF4F4F4);
    [operSellView addSubview: szhehje];
    [szhehje sizeToFit];
    
    lblszhehje = [[UILabel alloc] initWithFrame: CGRectMake(szhehje.maxX+SCREEN_WIDTH/40, szhehje.y, 1, 1)];
    lblszhehje.text = @"0.00";
    lblszhehje.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    lblszhehje.textColor = [UIColor whiteColor];
    [operSellView addSubview: lblszhehje];
    [lblszhehje sizeToFit];
    
    sjiaoymm = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/40, szhehje.maxY+SCREEN_WIDTH/20, 1, 1)];
    sjiaoymm.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"JIAOYIMIMA") ];
    sjiaoymm.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    sjiaoymm.textColor = UIColorFromRGB(0xF4F4F4);
    [operSellView addSubview: sjiaoymm];
    [sjiaoymm sizeToFit];
    
    txtsJiaoymmText = [[UITextField alloc] initWithFrame:CGRectMake(sjiaoymm.maxX +SCREEN_WIDTH/50, szhehje.maxY+SCREEN_WIDTH/40 ,  SCREEN_WIDTH-sjiaoymm.maxX -SCREEN_WIDTH/22, SCREEN_WIDTH/10)];
    [operSellView addSubview: txtsJiaoymmText];
    //    [txtBuyText setEnabled:NO];
    txtsJiaoymmText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    txtsJiaoymmText.secureTextEntry = YES;
    txtsJiaoymmText.textColor = UIColorFromRGB(0x767D85);
    txtsJiaoymmText.font = [UIFont systemFontOfSize:TRANSACTIONFTWO];
    txtsJiaoymmText.layer.borderColor=UIColorFromRGB(0x192631).CGColor;
    txtsJiaoymmText.layer.borderWidth= 1.0f;
    
    btnSells = [[UIButton alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/20, txtsJiaoymmText.maxY+SCREEN_WIDTH/30 , SCREEN_WIDTH-SCREEN_WIDTH/10, SCREEN_WIDTH/8)];
    [btnSells setTitle: LocatizedStirngForkey(@"MAICHU") forState: UIControlStateNormal];
    btnSells.titleLabel.font = [UIFont systemFontOfSize: LOGINFONTBUTONE];
    [btnSells.layer setMasksToBounds:YES];
    [btnSells.layer setCornerRadius:5.0];
    [btnSells setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [btnSells setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3178E3)] forState:UIControlStateNormal];
    [btnSells setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3A5FCD)] forState:UIControlStateHighlighted];
    
    [btnSells addTarget: self action: @selector(sellSummit) forControlEvents:UIControlEventTouchUpInside];
    [operSellView addSubview: btnSells];
    operSellView.hidden = YES;
    
}
-(void)createTbView{
    tbView = [[UIView alloc] initWithFrame: CGRectMake(0, buyView.maxY+8+10+SCREEN_WIDTH/1.3, scrollView.width, SCREEN_WIDTH)];
    tbView.backgroundColor = UIColorFromRGB(0x0F151A);
    [scrollView addSubview:tbView];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, buyView.maxY+8+SCREEN_WIDTH/1.3+SCREEN_WIDTH+10+8);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, SCREEN_WIDTH)];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableView.dataSource = self;
    // 设置tableView的委托
    tableView.delegate = self;
    tableView.backgroundColor = UIColorFromRGB(0x0F151A);
    self.myTableView = tableView;
    //[self.myTableView registerClass:[JHWodeCustomTableViewCell class] forCellReuseIdentifier:@"CustomHeader"];
    [tbView addSubview:self.myTableView];
}
// 设置块的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH/11;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"bodong";
    UITableViewCell *cell=nil;
    NSUInteger row = [indexPath row];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = UIColorFromRGB(0x0F151A);
    [cell.contentView removeSubviews];
    if(row==0){
        UILabel *one=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/20, 0, (SCREEN_WIDTH-SCREEN_WIDTH/20)/3, SCREEN_WIDTH/11)];
        one.text=LocatizedStirngForkey(@"MAIMAI");
        one.textAlignment = NSTextAlignmentLeft;
        one.textColor=UIColorFromRGB(0x979797);
        one.font = [UIFont systemFontOfSize:TRANSACTIONFTWO];
        [cell.contentView addSubview: one];
        
        UILabel *two=[[UILabel alloc] initWithFrame:CGRectMake(one.maxX, 0, (SCREEN_WIDTH-SCREEN_WIDTH/20)/3, SCREEN_WIDTH/11)];
        two.text=LocatizedStirngForkey(@"JIAGEFUHAO");
        two.textAlignment = NSTextAlignmentLeft;
        two.textColor=UIColorFromRGB(0x979797);
        two.font = [UIFont systemFontOfSize:TRANSACTIONFTWO];
        [cell.contentView addSubview: two];
        
        UILabel *three=[[UILabel alloc] initWithFrame:CGRectMake(two.maxX, 0, (SCREEN_WIDTH-SCREEN_WIDTH/20)/3, SCREEN_WIDTH/11)];
        three.text=LocatizedStirngForkey(@"SHULIANG");
        three.textAlignment = NSTextAlignmentLeft;
        three.textColor=UIColorFromRGB(0x979797);
        //    three.backgroundColor = UIColorFromRGB(0x0F151A);
        three.font = [UIFont systemFontOfSize:TRANSACTIONFTWO];
        [cell.contentView addSubview: three];
        UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/11-1 , SCREEN_WIDTH, 1)];
        separator.backgroundColor = UIColorFromRGB(0x1B2026);
        [cell.contentView addSubview:separator];
    }else if(row>=1 &&row<=5){
        UILabel *buySellLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/16, 0, (SCREEN_WIDTH-SCREEN_WIDTH/16)/3, SCREEN_WIDTH/11)];
        buySellLab.text=@"";
        buySellLab.textAlignment = NSTextAlignmentLeft;
        buySellLab.textColor=[UIColor greenColor];
        buySellLab.font = [UIFont systemFontOfSize:TRANSACTIONFFORE];
        [cell.contentView addSubview: buySellLab];
        
        UILabel *bsFirst=[[UILabel alloc] initWithFrame:CGRectMake(buySellLab.maxX, 0, (SCREEN_WIDTH-SCREEN_WIDTH/16)/3, SCREEN_WIDTH/11)];
        bsFirst.text=@"";
        bsFirst.textAlignment = NSTextAlignmentLeft;
        bsFirst.textColor=[UIColor greenColor];

        bsFirst.font = [UIFont systemFontOfSize:TRANSACTIONFFORE];
        [cell.contentView addSubview: bsFirst];
        
        UILabel *bsSecond=[[UILabel alloc] initWithFrame:CGRectMake(bsFirst.maxX, 0, (SCREEN_WIDTH-SCREEN_WIDTH/16)/3, SCREEN_WIDTH/11)];
        bsSecond.text=@"";
        bsSecond.textAlignment = NSTextAlignmentLeft;
        bsSecond.textColor=[UIColor greenColor];
        //    three.backgroundColor = UIColorFromRGB(0x0F151A);
        bsSecond.font = [UIFont systemFontOfSize:TRANSACTIONFFORE];
        [cell.contentView addSubview: bsSecond];
        if(row ==1){
            if(sellAry.count>=5){
                NSDictionary *rowDict = [sellAry objectAtIndex:4];
                bsFirst.text=StrValueFromDictionary(rowDict, @"price");
                bsSecond.text=StrValueFromDictionary(rowDict, @"quantity");
            }else{
                bsFirst.text=@"--";
                bsSecond.text=@"--";
            }
            buySellLab.text=@"卖 5";
        }
        if(row ==2){
            if(sellAry.count>=4){
                NSDictionary *rowDict = [sellAry objectAtIndex:3];
                bsFirst.text=StrValueFromDictionary(rowDict, @"price");
                bsSecond.text=StrValueFromDictionary(rowDict, @"quantity");
            }else{
                bsFirst.text=@"--";
                bsSecond.text=@"--";
            }
            buySellLab.text=@"卖 4";
        }
        if(row ==3){
            if(sellAry.count>=3){
                NSDictionary *rowDict = [sellAry objectAtIndex:2];
                bsFirst.text=StrValueFromDictionary(rowDict, @"price");
                bsSecond.text=StrValueFromDictionary(rowDict, @"quantity");
            }else{
                bsFirst.text=@"--";
                bsSecond.text=@"--";
            }
            buySellLab.text=@"卖 3";
        }
        if(row ==4){
            if(sellAry.count>=2){
                NSDictionary *rowDict = [sellAry objectAtIndex:1];
                bsFirst.text=StrValueFromDictionary(rowDict, @"price");
                bsSecond.text=StrValueFromDictionary(rowDict, @"quantity");
            }else{
                bsFirst.text=@"--";
                bsSecond.text=@"--";
            }
            buySellLab.text=@"卖 2";
        }
        if(row ==5){
            if(sellAry.count>=1){
                NSDictionary *rowDict = [sellAry objectAtIndex:0];
                bsFirst.text=StrValueFromDictionary(rowDict, @"price");
                bsSecond.text=StrValueFromDictionary(rowDict, @"quantity");
            }else{
                bsFirst.text=@"--";
                bsSecond.text=@"--";
            }
            buySellLab.text=@"卖 1";
            UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/11-1 , SCREEN_WIDTH, 1)];
            separator.backgroundColor = UIColorFromRGB(0x1B2026);
            [cell.contentView addSubview:separator];
        }
    }else{
        UILabel *buySellLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/16, 0, (SCREEN_WIDTH-SCREEN_WIDTH/16)/3, SCREEN_WIDTH/11)];
        buySellLab.text=@"买 1";
        buySellLab.textAlignment = NSTextAlignmentLeft;
        buySellLab.textColor=[UIColor redColor];
        buySellLab.font = [UIFont systemFontOfSize:TRANSACTIONFFORE];
        [cell.contentView addSubview: buySellLab];
        
        UILabel *bsFirst=[[UILabel alloc] initWithFrame:CGRectMake(buySellLab.maxX, 0, (SCREEN_WIDTH-SCREEN_WIDTH/16)/3, SCREEN_WIDTH/11)];
        bsFirst.text=@"";
        bsFirst.textAlignment = NSTextAlignmentLeft;
        bsFirst.textColor=[UIColor redColor];
        bsFirst.font = [UIFont systemFontOfSize:TRANSACTIONFFORE];
        [cell.contentView addSubview: bsFirst];
        
        UILabel *bsSecond=[[UILabel alloc] initWithFrame:CGRectMake(bsFirst.maxX, 0, (SCREEN_WIDTH-SCREEN_WIDTH/16)/3, SCREEN_WIDTH/11)];
        bsSecond.text=@"";
        bsSecond.textAlignment = NSTextAlignmentLeft;
        bsSecond.textColor=[UIColor redColor];
        //    three.backgroundColor = UIColorFromRGB(0x0F151A);
        bsSecond.font = [UIFont systemFontOfSize:TRANSACTIONFFORE];
        [cell.contentView addSubview: bsSecond];
        for(int i=0;i<5;++i){
            if(row ==i+6){
                if((row-5)<=buyAry.count){
                    NSDictionary *rowDict = [buyAry objectAtIndex:i];
                    bsFirst.text=StrValueFromDictionary(rowDict, @"price");
                    bsSecond.text=StrValueFromDictionary(rowDict, @"quantity");
                }else{
                    bsFirst.text=@"--";
                    bsSecond.text=@"--";
                }
            }
        }
        if(row ==6){
            buySellLab.text=@"买 1";
        }
        if(row ==7){
            buySellLab.text=@"买 2";
        }
        if(row ==8){
            buySellLab.text=@"买 3";
        }
        if(row ==9){
            buySellLab.text=@"买 4";
        }
        if(row ==10){
            buySellLab.text=@"买 5";
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //push后cell选中效果消失,又动画
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)buyGe:(UITapGestureRecognizer *)gesture {
    buyView.backgroundColor = UIColorFromRGB(0x192834);
    sellView.backgroundColor = UIColorFromRGB(0x0F151A);
    cheView.backgroundColor = UIColorFromRGB(0x0F151A);
    operBuyView.hidden = NO;
    operSellView.hidden = YES;
    
}
- (void)sellGe:(UITapGestureRecognizer *)gesture {
    buyView.backgroundColor = UIColorFromRGB(0x0F151A);
    sellView.backgroundColor = UIColorFromRGB(0x192834);
    cheView.backgroundColor = UIColorFromRGB(0x0F151A);
    operBuyView.hidden = YES;
    operSellView.hidden = NO;
}
- (void)cheGe:(UITapGestureRecognizer *)gesture {
    buyView.backgroundColor = UIColorFromRGB(0x0F151A);
    sellView.backgroundColor = UIColorFromRGB(0x0F151A);
    cheView.backgroundColor = UIColorFromRGB(0x192834);
}
-(void)doKilne{
    HQZXKlineGraphViewController *klineView = [[HQZXKlineGraphViewController alloc]init];
    klineView.symbol = _symbol;
    [self.navigationController pushViewController: klineView animated: YES];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == txtSellText) {
        NSString *buyStr = txtBuyText.text;
        NSMutableString *sellStr = [[NSMutableString alloc]initWithString:txtSellText.text];
        if(string.length>0){
            [sellStr replaceCharactersInRange:range withString:string];
        }else{
            [sellStr deleteCharactersInRange:range];
        }
        float share = [buyStr floatValue]* [sellStr intValue];
//        NSString *coins = StrValueFromDictionary(_dataDict, @"coins_balance");
//        if (share>[coins floatValue]) {
//            [self.view makeToast: @"超过可用人民币数" duration: 0.5 position: CSToastPositionCenter];
//            return NO;
//        }
        lblzhehje.text = [NSString stringWithFormat:@"%.4f",share];
        [lblzhehje sizeToFit];
    }
    if (textField == txtSsellText) {
        NSString *buyStr = txtSellsText.text;
        NSMutableString *sellStr = [[NSMutableString alloc]initWithString:txtSsellText.text];
        if(string.length>0){
            [sellStr replaceCharactersInRange:range withString:string];
        }else{
            [sellStr deleteCharactersInRange:range];
        }
//        NSString *coins = StrValueFromDictionary(_dataDict, @"coins_balance");
//        if ([sellStr intValue]>[coins floatValue]) {
//            [self.view makeToast: @"超过该币所持数" duration: 0.5 position: CSToastPositionCenter];
//            return NO;
//        }
        float share = [buyStr floatValue]* [sellStr intValue];
        lblszhehje.text = [NSString stringWithFormat:@"%.4f",share];
         [lblszhehje sizeToFit];
    }
    return YES;
}
-(void)buySummit{
    NSString *buyText = txtBuyText.text;
    NSString *sellText = txtSellText.text;
    NSString *password = txtJiaoymmText.text;
    VALIDATE_NOT_NULL(buyText, @"买入价格不能为空");
    VALIDATE_NOT_NULL(sellText, @"买入数量不能为空");
    VALIDATE_NOT_NULL(password, @"交易密码不能为空");
    [ProgressHUD show: [NSString stringWithFormat:@"%@...",LocatizedStirngForkey(@"QINGDENGDAI")] Interaction: NO];
    [[NetHttpClient sharedHTTPClient] request: @"/purchase.json" parameters:@{@"symbol":_symbol, @"price":buyText, @"count":sellText, @"trade_pwd": password, @"auth_key":[HQZXUserModel sharedInstance].currentUser.auth_key} completion:^(id obj) {
        [ProgressHUD dismiss];
        if (obj) {
            if ([@"0" isEqualToString:StrValueFromDictionary(obj, ApiKey_ErrorCode)]) {
                [self refScrollView];
            } else {
                [self.view makeToast:[NSString stringWithFormat:@"%@", [obj objectForKey:@"message"]] duration: 0.5 position:CSToastPositionCenter];
            }
        } else {
            [self.view makeToast:LocatizedStirngForkey(@"LIANJIEFUWUQISHIBAI") duration: 0.5 position:CSToastPositionCenter];
        }
    }];
}
-(void)sellSummit{
    NSString *buyText = txtSellsText.text;
    NSString *sellText = txtSsellText.text;
    NSString *password = txtsJiaoymmText.text;
    VALIDATE_NOT_NULL(buyText, @"卖出价格不能为空");
    VALIDATE_NOT_NULL(sellText, @"卖出数量不能为空");
    VALIDATE_NOT_NULL(password, @"交易密码不能为空");
    [ProgressHUD show: [NSString stringWithFormat:@"%@...",LocatizedStirngForkey(@"QINGDENGDAI")] Interaction: NO];
    [[NetHttpClient sharedHTTPClient] request: @"/sellout.json" parameters:@{@"symbol":_symbol, @"price":buyText, @"count":sellText, @"trade_pwd": password, @"auth_key":[HQZXUserModel sharedInstance].currentUser.auth_key} completion:^(id obj) {
        [ProgressHUD dismiss];
        if (obj) {
            if ([@"0" isEqualToString:StrValueFromDictionary(obj, ApiKey_ErrorCode)]) {
                [self refScrollView];
            } else {
                [self.view makeToast:[NSString stringWithFormat:@"%@", [obj objectForKey:@"message"]] duration: 0.5 position:CSToastPositionCenter];
            }
        } else {
            [self.view makeToast:LocatizedStirngForkey(@"LIANJIEFUWUQISHIBAI") duration: 0.5 position:CSToastPositionCenter];
        }
    }];
}
@end
