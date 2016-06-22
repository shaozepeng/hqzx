//
//  HQZXRMBCongZhiViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/15.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXRMBCongZhiViewController.h"

@implementation HQZXRMBCongZhiViewController{
    UIView *bankingView;
    UIView *alipayView;
    UIView *form;
    UIView *twoform;
    HQZXBank *commBank;
    
    UIImageView *iconLianText;
    UITextField *txtLianText;
    UIImageView *iconBankId;
    UITextField *bankId;
    UIImageView *cmIconBankId;
    UITextField *cmBankId;
    UIImageView *iconName;
    UITextField *nameText;
    UIImageView *iconBranch;
    UITextField *branchText;
    UIImageView *iconMoney;
    UITextField *moneyText;
    
    UITextField *txtTwoLianText;
    UIImageView *iconTwoBankId;
    UITextField *bankTwoId;
    UIImageView *cmIconTwoBankId;
    UITextField *cmBankTwoId;
    UIImageView *iconTwoName;
    UITextField *nameTwoText;
    UIImageView *iconTwoBranch;
    UITextField *branchTwoText;
    UIImageView *iconTwoMoney;
    UITextField *moneyTwoText;
    
    UIButton *drawButton;
    UIButton *drawTwoButton;
    UILabel *pointValue;
    UILabel *huValue;
    UILabel *twopointValue;
    UILabel *twohuValue;
    float hightDraw;
    UIScrollView *scrollView;
    
    UILabel *oneLab;
    UILabel *twoLab;
    UILabel *threeLab;
    UILabel *foreLab;
    UILabel *fiveLab;
    UILabel *sixLab;
    
    UILabel *oneFLab;
    UILabel *twoFLab;
    UILabel *threeFLab;
    UILabel *foreFLab;
    UILabel *fiveFLab;
    NSDictionary *alipayDic;
    NSDictionary *comeBackDic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    self.title = LocatizedStirngForkey(@"RENMINBICHONGZHI");
    
    scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [scrollView setBackgroundColor:UIColorFromRGB(0x0C1319)];
    [self.view addSubview: scrollView];
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    UIButton *zhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zhuBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/6, 44);
    [zhuBtn setTintColor:[UIColor whiteColor]];
    [zhuBtn setTitle:LocatizedStirngForkey(@"CHONGZHIJILU") forState:UIControlStateNormal];
    zhuBtn.titleLabel.font = [UIFont systemFontOfSize: LISHIFONT];
    [zhuBtn setTitleColor:UIColorFromRGB(0x439AFE) forState:UIControlStateNormal];
    [zhuBtn addTarget:self action:@selector(history) forControlEvents:UIControlEventTouchUpInside];
    
    [temporaryBarButtonItem setCustomView:zhuBtn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -12;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, temporaryBarButtonItem, nil];
    
    [self createNavView];
    [self createBodyView];
    [self createTwoBodyView];
    [self createBut];
}
-(void)createNavView{
    float bsHight = (SCREEN_WIDTH-2)/2;
    //网银
    bankingView = [[UIView alloc] initWithFrame: CGRectMake(0, TOP_HEIGHT+8, bsHight, SCREEN_WIDTH/10)];
    bankingView.backgroundColor = UIColorFromRGB(0x192834);
    [scrollView addSubview:bankingView];
    
    bankingView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bankGe:)];
    [bankingView addGestureRecognizer:tapGesture];
    
    UILabel *banklable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    banklable.text = LocatizedStirngForkey(@"WANGYINCHGONGZHI");
    banklable.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    banklable.textColor = [UIColor whiteColor];
    [bankingView addSubview: banklable];
    [banklable sizeToFit];
    [banklable setX:(bankingView.width-banklable.width)/2];
    [banklable setY:(bankingView.height-banklable.height)/2];
    
    
    UIView *buyhenglineoneView = [[UIView alloc] initWithFrame: CGRectMake(0, TOP_HEIGHT+7, bsHight, 1)];
    buyhenglineoneView.backgroundColor = UIColorFromRGB(0x141D25);
    [scrollView addSubview:buyhenglineoneView];
    
    UIView *buylineoneView = [[UIView alloc] initWithFrame: CGRectMake(bankingView.maxX, bankingView.y, 1, SCREEN_WIDTH/10)];
    buylineoneView.backgroundColor = UIColorFromRGB(0x141D25);
    [scrollView addSubview:buylineoneView];
    
    UIView *buylinetwoView = [[UIView alloc] initWithFrame: CGRectMake(buylineoneView.maxX, bankingView.y, 1, SCREEN_WIDTH/10)];
    buylinetwoView.backgroundColor = UIColorFromRGB(0x0D1318);
    [scrollView addSubview:buylinetwoView];
    //支付宝
    alipayView = [[UIView alloc] initWithFrame: CGRectMake(buylinetwoView.maxX, bankingView.y, bsHight, SCREEN_WIDTH/10)];
    alipayView.backgroundColor = UIColorFromRGB(0x0F151A);
    [scrollView addSubview:alipayView];
    
    alipayView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(alipaytGe:)];
    [alipayView addGestureRecognizer:tapGesture2];
    
    UILabel *alipaylable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    alipaylable.text = LocatizedStirngForkey(@"ZHIFUBAOCHONGZHI");
    alipaylable.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    alipaylable.textColor = [UIColor whiteColor];
    [alipayView addSubview: alipaylable];
    [alipaylable sizeToFit];
    [alipaylable setX:(alipayView.width-alipaylable.width)/2];
    [alipaylable setY:(alipayView.height-alipaylable.height)/2];
    
    UIView *buyhenglinetwoView = [[UIView alloc] initWithFrame: CGRectMake(buylinetwoView.maxX, TOP_HEIGHT+7, bsHight, 1)];
    buyhenglinetwoView.backgroundColor = UIColorFromRGB(0x141D25);
    [scrollView addSubview:buyhenglinetwoView];
}
-(void)createBodyView{
    form = [[UIView alloc] initWithFrame: CGRectMake(0, bankingView.maxY + SCREEN_WIDTH/30, SCREEN_WIDTH, SCREEN_HEIGHT*0.39+7)];
    [form setBackgroundColor:UIColorFromRGB(0x293035)];
    [scrollView addSubview: form];
    
    float lineHeight = (form.height-12)/6;
    UIView *line = [[UIView alloc] initWithFrame: CGRectMake(0, lineHeight, SCREEN_WIDTH, 8)];
    UIView *line1 = [[UIView alloc] initWithFrame: CGRectMake(0, lineHeight*2+8, SCREEN_WIDTH, 1)];
    UIView *line2 = [[UIView alloc] initWithFrame: CGRectMake(0, lineHeight*3+9, SCREEN_WIDTH, 1)];
    UIView *line3 = [[UIView alloc] initWithFrame: CGRectMake(0, lineHeight*4+10, SCREEN_WIDTH, 1)];
    UIView *line4 = [[UIView alloc] initWithFrame: CGRectMake(0, lineHeight*5+11, SCREEN_WIDTH, 1)];
    line.backgroundColor = UIColorFromRGB(0x0C1319);
    line1.backgroundColor = UIColorFromRGB(0x0C1319);
    line2.backgroundColor = UIColorFromRGB(0x0C1319);
    line3.backgroundColor = UIColorFromRGB(0x0C1319);
    line4.backgroundColor = UIColorFromRGB(0x0C1319);
    [form addSubview: line];
    [form addSubview: line1];
    [form addSubview: line2];
    [form addSubview: line3];
    [form addSubview: line4];
    
    //选择卡种
    iconLianText = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_price"]];
    [form addSubview: iconLianText];
    [iconLianText setY: (lineHeight - iconLianText.height) / 2.0];
    iconLianText.x = SCREEN_WIDTH/30;
    
    txtLianText = [[UITextField alloc] initWithFrame:CGRectMake(iconLianText.maxX + SCREEN_WIDTH/30 , 0, SCREEN_WIDTH- iconLianText.maxX - SCREEN_WIDTH/30-SCREEN_WIDTH/8, lineHeight)];
    [form addSubview: txtLianText];
    [txtLianText setEnabled:NO];
    txtLianText.textColor = UIColorFromRGB(0x767D85);
    txtLianText.font = [UIFont systemFontOfSize:WITHFONTTWO];
    txtLianText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    txtLianText.placeholder = LocatizedStirngForkey(@"GUOJIA");
    //    [txtLianText setValue:UIColorFromRGB(0x767D85) forKeyPath:@"_placeholderLabel.textColor"];
    //    [txtLianText setValue:[UIFont systemFontOfSize:REGISTERFONTONE]forKeyPath:@"_placeholderLabel.font"];
    
    NSMutableParagraphStyle *style = [txtLianText.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = txtLianText.font.lineHeight - (txtLianText.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    txtLianText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"XUANZEYINHANGKALEIXING")
                                                                        attributes:@{
                                                                                     NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                     NSParagraphStyleAttributeName : style
                                                                                     }];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(txtLianText.maxX, 0, SCREEN_WIDTH/8, lineHeight);
    [backBtn setTintColor:[UIColor whiteColor]];
    [backBtn setTitleColor:UIColorFromRGB(0x293035) forState:UIControlStateNormal];
    UIImage *leftBtnImage = [UIImage imageNamed:@"icon_jt_bo_bl"];
    [backBtn setImage:leftBtnImage forState:UIControlStateNormal];
    [form addSubview: backBtn];
    
    UIView *clickView = [[UIView alloc]initWithFrame:CGRectMake(iconLianText.maxX + SCREEN_WIDTH/30, 0 , form.width - iconLianText.maxX - SCREEN_WIDTH/15, lineHeight)];
    clickView.userInteractionEnabled = YES;
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectbank)];
    
    [clickView addGestureRecognizer:tapGesture];
    [form addSubview: clickView];
    
    //充值帐号
    iconBankId = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_zhanghu"]];
    [form addSubview: iconBankId];
    [iconBankId setY: (lineHeight - iconBankId.height) / 2.0 + line.maxY];
    iconBankId.x = SCREEN_WIDTH/30;
    
    bankId = [[UITextField alloc] initWithFrame:CGRectMake(iconBankId.maxX+SCREEN_WIDTH/30 , line.maxY, SCREEN_WIDTH- iconBankId.maxX - SCREEN_WIDTH/15, lineHeight)];
    [form addSubview: bankId];
    bankId.textColor = UIColorFromRGB(0x767D85);
    bankId.font = [UIFont systemFontOfSize:WITHFONTTWO];
    bankId.clearButtonMode = UITextFieldViewModeWhileEditing;
    bankId.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    NSMutableParagraphStyle *styles = [bankId.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    styles.minimumLineHeight = bankId.font.lineHeight - (bankId.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    bankId.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"CHONGZHIZHANGHAO")
                                                                   attributes:@{
                                                                                NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                NSParagraphStyleAttributeName : styles
                                                                                }];
    
    //充值金额
    cmIconBankId = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_money_bi"]];
    [form addSubview: cmIconBankId];
    [cmIconBankId setY: (lineHeight - cmIconBankId.height) / 2.0 +line1.maxY];
    cmIconBankId.x = SCREEN_WIDTH/30;
    
    cmBankId = [[UITextField alloc] initWithFrame:CGRectMake(iconBankId.maxX+SCREEN_WIDTH/30 , line1.maxY, SCREEN_WIDTH- cmIconBankId.maxX - SCREEN_WIDTH/15, lineHeight)];
    [form addSubview: cmBankId];
    cmBankId.textColor = UIColorFromRGB(0x767D85);
    cmBankId.font = [UIFont systemFontOfSize:WITHFONTTWO];
    cmBankId.clearButtonMode = UITextFieldViewModeWhileEditing;
    cmBankId.keyboardType = UIKeyboardTypeDecimalPad;
    cmBankId.delegate = self;
    
    NSMutableParagraphStyle *style1 = [cmBankId.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style1.minimumLineHeight = cmBankId.font.lineHeight - (cmBankId.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    cmBankId.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"CHONGZHIJINE")
                                                                     attributes:@{
                                                                                  NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                  NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                  NSParagraphStyleAttributeName : style1
                                                                                  }];
    //充值姓名
    iconName = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_men"]];
    [form addSubview: iconName];
    [iconName setY: (lineHeight - iconName.height) / 2.0 +line2.maxY];
    iconName.x = SCREEN_WIDTH/30;
    
    nameText = [[UITextField alloc] initWithFrame:CGRectMake(iconBankId.maxX+SCREEN_WIDTH/30 , line2.maxY, SCREEN_WIDTH- iconName.maxX - SCREEN_WIDTH/15, lineHeight)];
    [form addSubview: nameText];
    nameText.textColor = UIColorFromRGB(0x767D85);
    nameText.font = [UIFont systemFontOfSize:WITHFONTTWO];
    nameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    NSMutableParagraphStyle *style2 = [nameText.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style2.minimumLineHeight = nameText.font.lineHeight - (nameText.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    nameText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"CHONGZHIRENXINGMING")
                                                                     attributes:@{
                                                                                  NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                  NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                  NSParagraphStyleAttributeName : style2
                                                                                  }];
    
    //手机号
    iconBranch = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_phone"]];
    [form addSubview: iconBranch];
    [iconBranch setY: (lineHeight - iconBranch.height) / 2.0 +line3.maxY];
    iconBranch.x = SCREEN_WIDTH/30;
    
    branchText = [[UITextField alloc] initWithFrame:CGRectMake(iconBankId.maxX+SCREEN_WIDTH/30 , line3.maxY, SCREEN_WIDTH- iconBranch.maxX - SCREEN_WIDTH/15, lineHeight)];
    [form addSubview: branchText];
    branchText.textColor = UIColorFromRGB(0x767D85);
    branchText.font = [UIFont systemFontOfSize:WITHFONTTWO];
    branchText.clearButtonMode = UITextFieldViewModeWhileEditing;
    branchText.keyboardType = UIKeyboardTypeNumberPad;
    
    NSMutableParagraphStyle *style3 = [branchText.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style3.minimumLineHeight = branchText.font.lineHeight - (branchText.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    branchText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"SHOUJIHAO")
                                                                       attributes:@{
                                                                                    NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                    NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                    NSParagraphStyleAttributeName : style3
                                                                                    }];
    
    //备注
    iconMoney = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_note"]];
    [form addSubview: iconMoney];
    [iconMoney setY: (lineHeight - iconMoney.height) / 2.0 +line4.maxY];
    iconMoney.x = SCREEN_WIDTH/30;
    
    moneyText = [[UITextField alloc] initWithFrame:CGRectMake(iconBankId.maxX+SCREEN_WIDTH/30 , line4.maxY, SCREEN_WIDTH- iconMoney.maxX - SCREEN_WIDTH/15, lineHeight)];
    [form addSubview: moneyText];
    moneyText.textColor = UIColorFromRGB(0x767D85);
    moneyText.font = [UIFont systemFontOfSize:WITHFONTTWO];
    moneyText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    NSMutableParagraphStyle *style4 = [moneyText.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style4.minimumLineHeight = moneyText.font.lineHeight - (moneyText.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    moneyText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"BEIZHU")
                                                                      attributes:@{
                                                                                   NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                   NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                   NSParagraphStyleAttributeName : style4
                                                                                   }];
    

    form.hidden = NO;
}
-(void)createTwoBodyView{
    twoform = [[UIView alloc] initWithFrame: CGRectMake(0, bankingView.maxY + SCREEN_WIDTH/30, SCREEN_WIDTH, SCREEN_HEIGHT*0.325)];
    [twoform setBackgroundColor:UIColorFromRGB(0x293035)];
    [scrollView addSubview: twoform];
    
    float lineHeight = (twoform.height-4)/5;
    UIView *line = [[UIView alloc] initWithFrame: CGRectMake(0, lineHeight, SCREEN_WIDTH, 1)];
    UIView *line1 = [[UIView alloc] initWithFrame: CGRectMake(0, lineHeight*2+1, SCREEN_WIDTH, 1)];
    UIView *line2 = [[UIView alloc] initWithFrame: CGRectMake(0, lineHeight*3+2, SCREEN_WIDTH, 1)];
    UIView *line3 = [[UIView alloc] initWithFrame: CGRectMake(0, lineHeight*4+3, SCREEN_WIDTH, 1)];
    line.backgroundColor = UIColorFromRGB(0x0C1319);
    line1.backgroundColor = UIColorFromRGB(0x0C1319);
    line2.backgroundColor = UIColorFromRGB(0x0C1319);
    line3.backgroundColor = UIColorFromRGB(0x0C1319);
    [twoform addSubview: line];
    [twoform addSubview: line1];
    [twoform addSubview: line2];
    [twoform addSubview: line3];
    
    //充值帐号
    iconTwoBankId = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_zhanghu"]];
    [twoform addSubview: iconTwoBankId];
    [iconTwoBankId setY: (lineHeight - iconTwoBankId.height) / 2.0];
    iconTwoBankId.x = SCREEN_WIDTH/30;
    
    bankTwoId = [[UITextField alloc] initWithFrame:CGRectMake(iconTwoBankId.maxX+SCREEN_WIDTH/30 , 0, SCREEN_WIDTH- iconTwoBankId.maxX - SCREEN_WIDTH/15, lineHeight)];
    [twoform addSubview: bankTwoId];
    bankTwoId.textColor = UIColorFromRGB(0x767D85);
    bankTwoId.font = [UIFont systemFontOfSize:WITHFONTTWO];
    bankTwoId.clearButtonMode = UITextFieldViewModeWhileEditing;
    bankTwoId.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    NSMutableParagraphStyle *style = [bankTwoId.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = bankTwoId.font.lineHeight - (bankTwoId.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    bankTwoId.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"CHONGZHIZHANGHAO")
                                                                   attributes:@{
                                                                                NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                NSParagraphStyleAttributeName : style
                                                                                }];
    
    //充值金额
    cmIconTwoBankId = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_money_bi"]];
    [twoform addSubview: cmIconTwoBankId];
    [cmIconTwoBankId setY: (lineHeight - cmIconTwoBankId.height) / 2.0 +line.maxY];
    cmIconTwoBankId.x = SCREEN_WIDTH/30;
    
    cmBankTwoId = [[UITextField alloc] initWithFrame:CGRectMake(iconTwoBankId.maxX+SCREEN_WIDTH/30 , line.maxY, SCREEN_WIDTH- cmIconTwoBankId.maxX - SCREEN_WIDTH/15, lineHeight)];
    [twoform addSubview: cmBankTwoId];
    cmBankTwoId.textColor = UIColorFromRGB(0x767D85);
    cmBankTwoId.font = [UIFont systemFontOfSize:WITHFONTTWO];
    cmBankTwoId.clearButtonMode = UITextFieldViewModeWhileEditing;
    cmBankTwoId.keyboardType = UIKeyboardTypeDecimalPad;
    cmBankTwoId.delegate = self;
    
    NSMutableParagraphStyle *style1 = [cmBankTwoId.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style1.minimumLineHeight = cmBankTwoId.font.lineHeight - (cmBankTwoId.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    cmBankTwoId.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"CHONGZHIJINE")
                                                                     attributes:@{
                                                                                  NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                  NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                  NSParagraphStyleAttributeName : style1
                                                                                  }];
    //充值人姓名
    iconTwoName = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_men"]];
    [twoform addSubview: iconTwoName];
    [iconTwoName setY: (lineHeight - iconTwoName.height) / 2.0 +line1.maxY];
    iconTwoName.x = SCREEN_WIDTH/30;
    
    nameTwoText = [[UITextField alloc] initWithFrame:CGRectMake(iconTwoBankId.maxX+SCREEN_WIDTH/30 , line1.maxY, SCREEN_WIDTH- iconTwoName.maxX - SCREEN_WIDTH/15, lineHeight)];
    [twoform addSubview: nameTwoText];
    nameTwoText.textColor = UIColorFromRGB(0x767D85);
    nameTwoText.font = [UIFont systemFontOfSize:WITHFONTTWO];
    nameTwoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    NSMutableParagraphStyle *style2 = [nameTwoText.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style2.minimumLineHeight = nameTwoText.font.lineHeight - (nameTwoText.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    nameTwoText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"CHONGZHIRENXINGMING")
                                                                     attributes:@{
                                                                                  NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                  NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                  NSParagraphStyleAttributeName : style2
                                                                                  }];
    
    //手机号
    iconTwoBranch = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_phone"]];
    [twoform addSubview: iconTwoBranch];
    [iconTwoBranch setY: (lineHeight - iconTwoBranch.height) / 2.0 +line2.maxY];
    iconTwoBranch.x = SCREEN_WIDTH/30;
    
    branchTwoText = [[UITextField alloc] initWithFrame:CGRectMake(iconTwoBankId.maxX+SCREEN_WIDTH/30 , line2.maxY, SCREEN_WIDTH- iconTwoBranch.maxX - SCREEN_WIDTH/15, lineHeight)];
    [twoform addSubview: branchTwoText];
    branchTwoText.textColor = UIColorFromRGB(0x767D85);
    branchTwoText.font = [UIFont systemFontOfSize:WITHFONTTWO];
    branchTwoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    branchTwoText.keyboardType = UIKeyboardTypeNumberPad;
    
    NSMutableParagraphStyle *style3 = [branchTwoText.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style3.minimumLineHeight = branchTwoText.font.lineHeight - (branchTwoText.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    branchTwoText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"SHOUJIHAO")
                                                                       attributes:@{
                                                                                    NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                    NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                    NSParagraphStyleAttributeName : style3
                                                                                    }];
    //备注
    iconTwoMoney = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_zhanghu"]];
    [twoform addSubview: iconTwoMoney];
    [iconTwoMoney setY: (lineHeight - iconTwoMoney.height) / 2.0 +line3.maxY];
    iconTwoMoney.x = SCREEN_WIDTH/30;
    
    moneyTwoText = [[UITextField alloc] initWithFrame:CGRectMake(iconTwoBankId.maxX+SCREEN_WIDTH/30 , line3.maxY, SCREEN_WIDTH- iconTwoMoney.maxX - SCREEN_WIDTH/15, lineHeight)];
    [twoform addSubview: moneyTwoText];
    moneyTwoText.textColor = UIColorFromRGB(0x767D85);
    moneyTwoText.font = [UIFont systemFontOfSize:WITHFONTTWO];
    moneyTwoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    NSMutableParagraphStyle *style4 = [moneyTwoText.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style4.minimumLineHeight = moneyTwoText.font.lineHeight - (moneyTwoText.font.lineHeight - [UIFont systemFontOfSize:LOGINFONTONE].lineHeight) / 2.0 ;
    
    moneyTwoText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocatizedStirngForkey(@"BEIZHU")
                                                                      attributes:@{
                                                                                   NSForegroundColorAttributeName: UIColorFromRGB(0x767D85),
                                                                                   NSFontAttributeName : [UIFont systemFontOfSize:WITHFONTTWO],
                                                                                   NSParagraphStyleAttributeName : style4
                                                                                   }];
    

    twoform.hidden = YES;
}
-(void)createBut{
    drawButton = [[UIButton alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/20, form.maxY + SCREEN_WIDTH/20, SCREEN_WIDTH-SCREEN_WIDTH/10, SCREEN_WIDTH/8)];
    [drawButton setTitle: LocatizedStirngForkey(@"CHONGZHI") forState: UIControlStateNormal];
    drawButton.titleLabel.font = [UIFont systemFontOfSize: LOGINFONTBUTONE];
    [drawButton.layer setMasksToBounds:YES];
    [drawButton.layer setCornerRadius:5.0];
    [drawButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [drawButton setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3178E3)] forState:UIControlStateNormal];
    [drawButton setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3A5FCD)] forState:UIControlStateHighlighted];
    
    [drawButton addTarget: self action: @selector(yTixian) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview: drawButton];
    
    drawTwoButton = [[UIButton alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/20, twoform.maxY + SCREEN_WIDTH/20, SCREEN_WIDTH-SCREEN_WIDTH/10, SCREEN_WIDTH/8)];
    [drawTwoButton setTitle: LocatizedStirngForkey(@"CHONGZHI") forState: UIControlStateNormal];
    drawTwoButton.titleLabel.font = [UIFont systemFontOfSize: LOGINFONTBUTONE];
    [drawTwoButton.layer setMasksToBounds:YES];
    [drawTwoButton.layer setCornerRadius:5.0];
    [drawTwoButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [drawTwoButton setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3178E3)] forState:UIControlStateNormal];
    [drawTwoButton setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x3A5FCD)] forState:UIControlStateHighlighted];
    
    [drawTwoButton addTarget: self action: @selector(zTixian) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview: drawTwoButton];
    drawButton.hidden = NO;
    drawTwoButton.hidden = YES;
    
    NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
    
    CGRect pointValueRect = CGRectMake(SCREEN_WIDTH/24, drawButton.maxY+SCREEN_WIDTH/20 ,1, 1);
    pointValue = [[UILabel alloc] initWithFrame:pointValueRect];
    pointValue.font = [UIFont systemFontOfSize:TRANFONTTWO];
    pointValue.textColor = [UIColor whiteColor];
    pointValue.text = LocatizedStirngForkey(@"YINGHANGKACAOZUOBUZOURUXIA");
    [pointValue sizeToFit];
    [scrollView addSubview: pointValue];
    float heighttwo = 0.0;
    if([language isEqualToString:@"zh-Hans"]){
        heighttwo = SCREEN_WIDTH/4;
    }else if([language isEqualToString:@"en"]){
        heighttwo = SCREEN_WIDTH/2.5;
    }
    CGRect huValueRect = CGRectMake(SCREEN_WIDTH/24, pointValue.maxY+5 ,SCREEN_WIDTH-SCREEN_WIDTH/12, heighttwo);
    
    huValue = [[UILabel alloc] initWithFrame:huValueRect];
    huValue.font = [UIFont systemFontOfSize:WITHFONTONE];
    huValue.textColor = UIColorFromRGB(0x666B70);
    huValue.lineBreakMode = NSLineBreakByCharWrapping;
    huValue.numberOfLines = 0;//上面两行设置多行显示
    huValue.text = LocatizedStirngForkey(@"YINGHANGKACHONGZHIXIEYI");
    [scrollView addSubview: huValue];
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:countryKey];
    NSDictionary* dicPorts = [NSDictionary dictionaryWithContentsOfFile:filename];
    if(dicPorts.count>0){
        NSDictionary *allDict =[dicPorts objectForKey:@"config"];
        alipayDic = [allDict objectForKey:@"alipay"];
        NSArray *twoArray = [allDict objectForKey:@"incomebank_list"];
        comeBackDic = [twoArray objectAtIndex:0];;
        NSLog(@"%@",alipayDic);
        NSLog(@"%@",comeBackDic);
    }
    
    
    oneLab = [[UILabel alloc] initWithFrame:CGRectMake(huValue.x, huValue.maxY+3 ,1, 1)];
    oneLab.font = [UIFont systemFontOfSize:WITHFONTONE];
    oneLab.textColor = UIColorFromRGB(0x666B70);
    
    oneLab.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"SHOUKUANRENXINGMING"),StrValueFromDictionary(comeBackDic, @"name")];
    [scrollView addSubview: oneLab];
    [oneLab sizeToFit];
    
    twoLab = [[UILabel alloc] initWithFrame:CGRectMake(huValue.x, oneLab.maxY+5 ,1, 1)];
    twoLab.font = [UIFont systemFontOfSize:WITHFONTONE];
    twoLab.textColor = UIColorFromRGB(0x666B70);
    twoLab.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"SHOUKUANRENZHANGHAO"),StrValueFromDictionary(comeBackDic, @"bankno")];
    [scrollView addSubview: twoLab];
    [twoLab sizeToFit];
    
    threeLab = [[UILabel alloc] initWithFrame:CGRectMake(huValue.x, twoLab.maxY+5 ,1, 1)];
    threeLab.font = [UIFont systemFontOfSize:WITHFONTONE];
    threeLab.textColor = UIColorFromRGB(0x666B70);
    threeLab.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"SHOUKUANRENKAIHUHANG"),StrValueFromDictionary(comeBackDic, @"bankadd")];
    [scrollView addSubview: threeLab];
    [threeLab sizeToFit];
    
    foreLab = [[UILabel alloc] initWithFrame:CGRectMake(huValue.x, threeLab.maxY+5 ,1, 1)];
    foreLab.font = [UIFont systemFontOfSize:WITHFONTONE];
    foreLab.textColor = UIColorFromRGB(0x666B70);
    foreLab.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"CHONGZHIJINE"),@"0"];
    [scrollView addSubview: foreLab];
    [foreLab sizeToFit];
    
    fiveLab = [[UILabel alloc] initWithFrame:CGRectMake(huValue.x, foreLab.maxY+5 ,1, 1)];
    fiveLab.font = [UIFont systemFontOfSize:WITHFONTONE];
    fiveLab.textColor = UIColorFromRGB(0x666B70);
    fiveLab.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"BEIZHU"),[HQZXUserModel sharedInstance].currentUser.userId];
    [scrollView addSubview: fiveLab];
    [fiveLab sizeToFit];
    
    sixLab = [[UILabel alloc] initWithFrame:CGRectMake(huValue.x, fiveLab.maxY+5 ,SCREEN_WIDTH-SCREEN_WIDTH/12, SCREEN_WIDTH/5)];
    sixLab.font = [UIFont systemFontOfSize:WITHFONTONE];
    sixLab.textColor = UIColorFromRGB(0x666B70);
    sixLab.lineBreakMode = NSLineBreakByCharWrapping;
    sixLab.numberOfLines = 0;//上面两行设置多行显示
    sixLab.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"BEIZHUFUYANZAIYAO"),@""];
    [scrollView addSubview: sixLab];
    
    
    CGRect pointValueRects = CGRectMake(SCREEN_WIDTH/24, drawTwoButton.maxY+SCREEN_WIDTH/20 ,1, 1);
    twopointValue = [[UILabel alloc] initWithFrame:pointValueRects];
    twopointValue.font = [UIFont systemFontOfSize:TRANFONTTWO];
    twopointValue.textColor = [UIColor whiteColor];
    twopointValue.text = LocatizedStirngForkey(@"ZHIFUBAOQINGNINANLIUCHENG");
    [twopointValue sizeToFit];
    [scrollView addSubview: twopointValue];
    float heightone = 0.0;
    if([language isEqualToString:@"zh-Hans"]){
        heightone = SCREEN_WIDTH/2.5;
    }else if([language isEqualToString:@"en"]){
        heightone = SCREEN_WIDTH/2;
    }
    CGRect huValueRects = CGRectMake(SCREEN_WIDTH/24, twopointValue.maxY+5 ,SCREEN_WIDTH-SCREEN_WIDTH/12, heightone);
    twohuValue = [[UILabel alloc] initWithFrame:huValueRects];
    twohuValue.font = [UIFont systemFontOfSize:WITHFONTONE];
    twohuValue.textColor = UIColorFromRGB(0x666B70);
    twohuValue.lineBreakMode = NSLineBreakByCharWrapping;
    twohuValue.numberOfLines = 0;//上面两行设置多行显示
    twohuValue.text = LocatizedStirngForkey(@"ZHIFUBAOFUKUANXIEYI");
    [scrollView addSubview: twohuValue];
    
    oneFLab = [[UILabel alloc] initWithFrame:CGRectMake(twohuValue.x, twohuValue.maxY+5 ,1, 1)];
    oneFLab.font = [UIFont systemFontOfSize:WITHFONTONE];
    oneFLab.textColor = UIColorFromRGB(0x666B70);
    oneFLab.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"CHONGZHIFANGSHI"),LocatizedStirngForkey(@"ZHIFUBAO")];
    [scrollView addSubview: oneFLab];
    [oneFLab sizeToFit];
    
    twoFLab = [[UILabel alloc] initWithFrame:CGRectMake(twohuValue.x, oneFLab.maxY+5 ,1, 1)];
    twoFLab.font = [UIFont systemFontOfSize:WITHFONTONE];
    twoFLab.textColor = UIColorFromRGB(0x666B70);
    twoFLab.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"SHOUKUANZHANGHAO"),StrValueFromDictionary(alipayDic, @"account")];
    [scrollView addSubview: twoFLab];
    [twoFLab sizeToFit];
    
    threeFLab = [[UILabel alloc] initWithFrame:CGRectMake(twohuValue.x, twoFLab.maxY+5 ,1, 1)];
    threeFLab.font = [UIFont systemFontOfSize:WITHFONTONE];
    threeFLab.textColor = UIColorFromRGB(0x666B70);
    threeFLab.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"SHOUKUANRENXINGMING"),StrValueFromDictionary(alipayDic, @"name")];
    [scrollView addSubview: threeFLab];
    [threeFLab sizeToFit];
    
    foreFLab = [[UILabel alloc] initWithFrame:CGRectMake(twohuValue.x, threeFLab.maxY+5 ,1, 1)];
    foreFLab.font = [UIFont systemFontOfSize:WITHFONTONE];
    foreFLab.textColor = UIColorFromRGB(0x666B70);
    foreFLab.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"FUYANNEIRONG"),[HQZXUserModel sharedInstance].currentUser.userId];
    [scrollView addSubview: foreFLab];
    [foreFLab sizeToFit];
    
    fiveFLab = [[UILabel alloc] initWithFrame:CGRectMake(twohuValue.x, foreFLab.maxY+5 ,1, 1)];
    fiveFLab.font = [UIFont systemFontOfSize:WITHFONTONE];
    fiveFLab.textColor = UIColorFromRGB(0x666B70);
    fiveFLab.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"CHONGZHIJINE"),@"0"];
    [scrollView addSubview: fiveFLab];
    [fiveFLab sizeToFit];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, sixLab.maxY);
    
    pointValue.hidden = NO;
    huValue.hidden = NO;
    twopointValue.hidden = YES;
    twohuValue.hidden = YES;
    oneLab.hidden = NO;
    twoLab.hidden = NO;
    threeLab.hidden = NO;
    foreLab.hidden = NO;
    fiveLab.hidden = NO;
    sixLab.hidden = NO;
    
    oneFLab.hidden = YES;
    twoFLab.hidden = YES;
    threeFLab.hidden = YES;
    foreFLab.hidden = YES;
    fiveFLab.hidden = YES;
}
- (void)bankGe:(UITapGestureRecognizer *)gesture {
    bankingView.backgroundColor = UIColorFromRGB(0x192834);
    alipayView.backgroundColor = UIColorFromRGB(0x0F151A);
    form.hidden = NO;
    twoform.hidden = YES;
    drawButton.hidden = NO;
    drawTwoButton.hidden = YES;
    pointValue.hidden = NO;
    huValue.hidden = NO;
    twopointValue.hidden = YES;
    twohuValue.hidden = YES;
    
    oneLab.hidden = NO;
    twoLab.hidden = NO;
    threeLab.hidden = NO;
    foreLab.hidden = NO;
    fiveLab.hidden = NO;
    sixLab.hidden = NO;
    
    oneFLab.hidden = YES;
    twoFLab.hidden = YES;
    threeFLab.hidden = YES;
    foreFLab.hidden = YES;
    fiveFLab.hidden = YES;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, sixLab.maxY);
}
- (void)alipaytGe:(UITapGestureRecognizer *)gesture {
    bankingView.backgroundColor = UIColorFromRGB(0x0F151A);
    alipayView.backgroundColor = UIColorFromRGB(0x192834);
    form.hidden = YES;
    twoform.hidden = NO;
    drawButton.hidden = YES;
    drawTwoButton.hidden = NO;
    pointValue.hidden = YES;
    huValue.hidden = YES;
    twopointValue.hidden = NO;
    twohuValue.hidden = NO;
    
    oneLab.hidden = YES;
    twoLab.hidden = YES;
    threeLab.hidden = YES;
    foreLab.hidden = YES;
    fiveLab.hidden = YES;
    sixLab.hidden = YES;
    
    oneFLab.hidden = NO;
    twoFLab.hidden = NO;
    threeFLab.hidden = NO;
    foreFLab.hidden = NO;
    fiveFLab.hidden = NO;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, fiveFLab.maxY+10);
}
-(void)selectbank{
    HQZXSelectBankForm *selectCountForm = [[HQZXSelectBankForm alloc] initWithPlaceHolder: LocatizedStirngForkey(@"XUANZEYINHANGKALEIXING")];
    __weak typeof(selectCountForm) weakSelectForm = selectCountForm;
    weakSelectForm.beSureComp = HQZXSelectBankComp() {
        [weakSelectForm hideAction:^{
            commBank = BANK;
            NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
            if([language isEqualToString:@"zh-Hans"]){
                txtLianText.text = BANK.bank_name;
            }else if([language isEqualToString:@"en"]){
                txtLianText.text = BANK.bank_ename;
            }
        }];
    };
    [weakSelectForm showAction];
}

-(void)yTixian{
    NSString *bank = bankId.text;
    NSString *imbank = cmBankId.text;
    NSString *name = nameText.text;
    NSString *branch = branchText.text;
    NSString *moneys = moneyText.text;
    if(moneys.length==0){
        moneys = @"0";
    }
    VALIDATE_NOT_NULL(commBank.bank_id, LocatizedStirngForkey(@"XUANZEYINHANGKALEIXING"));
    VALIDATE_NOT_NULL(bank, LocatizedStirngForkey(@"CHONGZHIZHANGHAOBUNENGWEIKONG"));
    VALIDATE_NOT_NULL(imbank, LocatizedStirngForkey(@"CHONGZHIJINEBUNENGWEIKONG"));
    VALIDATE_NOT_NULL(name, LocatizedStirngForkey(@"CHONGZHIRENXINGMINGBUNENGWEIKONG"));
    VALIDATE_NOT_NULL(branch, LocatizedStirngForkey(@"SHOUJIHAOBUNENGWEIKONG"));
//    VALIDATE_NOT_NULL(moneys, LocatizedStirngForkey(@"JIAOYIMIMABUNENGWEIKONG"));
    [ProgressHUD show: [NSString stringWithFormat:@"%@...",LocatizedStirngForkey(@"QINGDENGDAI")] Interaction: NO];
    [[NetHttpClient sharedHTTPClient] request: @"/rmb_paycheck_apply.json" parameters:@{@"recharge_type":@"1", @"bankid":commBank.bank_id, @"account":bank, @"money": imbank,@"name": name,@"mobile": branch,@"message": moneys, @"auth_key":[HQZXUserModel sharedInstance].currentUser.auth_key} completion:^(id obj) {
        [ProgressHUD dismiss];
        if (obj) {
            if ([@"0" isEqualToString:StrValueFromDictionary(obj, ApiKey_ErrorCode)]) {
                [self.view makeToast: LocatizedStirngForkey(@"CAOZUOCHENGGONG") duration: 0.5 position: CSToastPositionCenter];
                bankId.text = @"";
                cmBankId.text = @"";
                nameText.text = @"";
                branchText.text = @"";
                moneyText.text = @"";
                txtLianText.text = @"";
            } else {
                [self.view makeToast:[NSString stringWithFormat:@"%@", [obj objectForKey:@"message"]] duration: 0.5 position:CSToastPositionCenter];
            }
        } else {
            [self.view makeToast:LocatizedStirngForkey(@"LIANJIEFUWUQISHIBAI") duration: 0.5 position:CSToastPositionCenter];
        }
    }];
}
-(void)zTixian{
    NSString *buyTexts = bankTwoId.text;
    NSString *sellTexts = cmBankTwoId.text;
    NSString *names = nameTwoText.text;
    NSString *branchs = branchTwoText.text;
    NSString *moneyTwo = moneyTwoText.text;
    if(moneyTwo.length==0){
        moneyTwo = @"0";
    }
    VALIDATE_NOT_NULL(buyTexts, LocatizedStirngForkey(@"CHONGZHIZHANGHAOBUNENGWEIKONG"));
    VALIDATE_NOT_NULL(sellTexts, LocatizedStirngForkey(@"CHONGZHIJINEBUNENGWEIKONG"));
    VALIDATE_NOT_NULL(names, LocatizedStirngForkey(@"CHONGZHIRENXINGMINGBUNENGWEIKONG"));
    VALIDATE_NOT_NULL(branchs, LocatizedStirngForkey(@"SHOUJIHAOBUNENGWEIKONG"));
//    VALIDATE_NOT_NULL(moneyTwo, LocatizedStirngForkey(@"JIAOYIMIMABUNENGWEIKONG"));
    [ProgressHUD show: [NSString stringWithFormat:@"%@...",LocatizedStirngForkey(@"QINGDENGDAI")] Interaction: NO];
    [[NetHttpClient sharedHTTPClient] request: @"/rmb_paycheck_apply.json" parameters:@{@"recharge_type":@"2", @"account":buyTexts, @"money": sellTexts,@"name": names,@"mobile": branchs,@"message": moneyTwo, @"auth_key":[HQZXUserModel sharedInstance].currentUser.auth_key} completion:^(id obj) {
        [ProgressHUD dismiss];
        if (obj) {
            if ([@"0" isEqualToString:StrValueFromDictionary(obj, ApiKey_ErrorCode)]) {
                [self.view makeToast: LocatizedStirngForkey(@"CAOZUOCHENGGONG") duration: 0.5 position: CSToastPositionCenter];
                bankTwoId.text = @"";
                cmBankTwoId.text = @"";
                nameTwoText.text = @"";
                branchTwoText.text = @"";
                moneyTwoText.text = @"";
            } else {
                [self.view makeToast:[NSString stringWithFormat:@"%@", [obj objectForKey:@"message"]] duration: 0.5 position:CSToastPositionCenter];
            }
        } else {
            [self.view makeToast:LocatizedStirngForkey(@"LIANJIEFUWUQISHIBAI") duration: 0.5 position:CSToastPositionCenter];
        }
    }];
}
-(void)history{
    HQZXRMBRecordViewController *historyView=[[HQZXRMBRecordViewController alloc]init];
    [self.navigationController pushViewController:historyView animated:YES];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == cmBankId) {
        NSMutableString *sellStr = [[NSMutableString alloc]initWithString:cmBankId.text];
        if(string.length>0){
            [sellStr replaceCharactersInRange:range withString:string];
        }else{
            [sellStr deleteCharactersInRange:range];
        }
        foreLab.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"CHONGZHIJINE"),sellStr];
        [foreLab sizeToFit];
    }
    if (textField == cmBankTwoId) {
        NSMutableString *sellStr = [[NSMutableString alloc]initWithString:cmBankTwoId.text];
        if(string.length>0){
            [sellStr replaceCharactersInRange:range withString:string];
        }else{
            [sellStr deleteCharactersInRange:range];
        }
        fiveFLab.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"CHONGZHIJINE"),sellStr];
        [fiveFLab sizeToFit];
    }
    return YES;
}
@end
