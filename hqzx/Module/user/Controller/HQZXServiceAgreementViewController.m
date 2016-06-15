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
     [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
//    self.title = LocatizedStirngForkey(@"RENZHENGCHENGGONG");
    self.title = LocatizedStirngForkey(@"HUANQIUZAIXIANXIEYITWO");
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - TOP_HEIGHT)];
    [self.view addSubview: webView];
    [webView setScalesPageToFit:NO];
    
    NSString *path;
    NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
    if([language isEqualToString:@"zh-Hans"]){
        path = @"http://api.50f.cn/page/service_agreement_zh.html";
    }else if([language isEqualToString:@"en"]){
        path = @"http://api.50f.cn/page/service_agreement_en.html";
    }
    
    NSURL *url = [[NSURL alloc] initWithString:path];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    webView.delegate = self; 
//    [webView loadHTMLString:@"<center style=\"color:#999999\"><h3>加载中...</h3></center>" baseURL: nil];
//    [webView loadHTMLString:@"http://api.50f.cn/page/service_agreement_zh.html" baseURL: nil];
    
//    scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT)];
//    scrollView.backgroundColor = UIColorFromRGB(0x0C1319);
//    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
//    [self.view addSubview:scrollView];
//    
//    NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
//    
//    UILabel *tongguorenzheng = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
//    tongguorenzheng.text = LocatizedStirngForkey(@"HUANQIUZAIXIANXIEYITWO");
//    tongguorenzheng.font = [UIFont systemFontOfSize: SUCCESSFONTONETWO];
//    tongguorenzheng.textColor = [UIColor whiteColor];
//    [tongguorenzheng sizeToFit];
//    [scrollView addSubview: tongguorenzheng];
//    [tongguorenzheng setX:(SCREEN_WIDTH-tongguorenzheng.width)/2];
//    [tongguorenzheng setY:SCREEN_WIDTH/20];
////
//    UILabel *shenfenInfo = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
//    shenfenInfo.text = LocatizedStirngForkey(@"ZHUCEXIEYIONE");
//    shenfenInfo.font = [UIFont systemFontOfSize: 12];
//    shenfenInfo.textColor = [UIColor whiteColor];
//    shenfenInfo.lineBreakMode = NSLineBreakByCharWrapping;
//    shenfenInfo.numberOfLines = 0;
//    [shenfenInfo setX:SCREEN_WIDTH/30 ];
//    [shenfenInfo setW:SCREEN_WIDTH-SCREEN_WIDTH/15 ];
//    if([language isEqualToString:@"zh-Hans"]){
//        [shenfenInfo setH:SCREEN_WIDTH/5];
//    }else if([language isEqualToString:@"en"]){
//        [shenfenInfo setH:SCREEN_WIDTH/4];
//    }
//    
//    [shenfenInfo setY:tongguorenzheng.maxY+SCREEN_WIDTH/40];
//    [scrollView addSubview: shenfenInfo];
//    
//    UILabel *nameInfo = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
//    nameInfo.text = LocatizedStirngForkey(@"ZHUCEXIEYITWO");
//    nameInfo.font = [UIFont systemFontOfSize: SUCCESSFONTONE];
//    nameInfo.textColor = [UIColor whiteColor];
//    nameInfo.lineBreakMode = NSLineBreakByCharWrapping;
//    nameInfo.numberOfLines = 0;
//    [scrollView addSubview: nameInfo];
//    [nameInfo sizeToFit];
//    [nameInfo setW:SCREEN_WIDTH-SCREEN_WIDTH/15 ];
//    if([language isEqualToString:@"zh-Hans"]){
//        [nameInfo setH:SCREEN_WIDTH/4.5];
//    }else if([language isEqualToString:@"en"]){
//        [nameInfo setH:SCREEN_WIDTH/1.5];
//    }
//    [nameInfo setX:SCREEN_WIDTH/30 ];
//    [nameInfo setY:shenfenInfo.maxY+SCREEN_WIDTH/40];
//    
//    UILabel *cardInfo = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
//    cardInfo.text = LocatizedStirngForkey(@"ZHUCEXIEYITHREE");
//    cardInfo.font = [UIFont systemFontOfSize: 12];
//    cardInfo.textColor = [UIColor whiteColor];
//    cardInfo.lineBreakMode = NSLineBreakByCharWrapping;
//    cardInfo.numberOfLines = 0;
//    [cardInfo setX:SCREEN_WIDTH/30 ];
//    [cardInfo setW:SCREEN_WIDTH-SCREEN_WIDTH/15 ];
//    [cardInfo setH:SCREEN_WIDTH/5];
//    [cardInfo setY:nameInfo.maxY+SCREEN_WIDTH/40];
//    [scrollView addSubview: cardInfo];
//    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, cardInfo.maxY);
}
- (NSString *)htmlAdjustWithPageWidth:(CGFloat )pageWidth
                                 html:(NSString *)html
                              webView:(UIWebView *)webView
{
    NSMutableString *str = [NSMutableString stringWithString:html];
    //计算要缩放的比例
    CGFloat initialScale = webView.frame.size.width/pageWidth;
    //将</head>替换为meta+head
    NSString *stringForReplace = [NSString stringWithFormat:@"<meta name=\"viewport\" content=\" initial-scale=%f, minimum-scale=0.1, maximum-scale=2.0, user-scalable=yes\"></head>",initialScale];
    
    NSRange range =  NSMakeRange(0, str.length);
    //替换
    [str replaceOccurrencesOfString:@"</head>" withString:stringForReplace options:NSLiteralSearch range:range];
    return str;
}
@end
