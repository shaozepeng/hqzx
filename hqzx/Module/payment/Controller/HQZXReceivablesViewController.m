//
//  HQZXReceivablesViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/4.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXReceivablesViewController.h"
#import "SYQrCode.h"

@interface HQZXReceivablesViewController (){
    UIImageView *imageView;
}
@end

@implementation HQZXReceivablesViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    self.title = LocatizedStirngForkey(@"WOYAOSHOUKUAN");
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5, TOP_HEIGHT+SCREEN_WIDTH/5, SCREEN_WIDTH/5*3, SCREEN_WIDTH/5*3)];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saveQrCodeImage:)];
    
    [imageView addGestureRecognizer:tap];
    [self drawImage];
    
    CGRect pointValueRect = CGRectMake(SCREEN_WIDTH/24, imageView.maxY+SCREEN_WIDTH/TRANFONTHEIGHT ,SCREEN_WIDTH-SCREEN_WIDTH/12, 50);
    UILabel *pointValue = [[UILabel alloc] initWithFrame:pointValueRect];
    pointValue.font = [UIFont systemFontOfSize:TRANFONTTWO];
    pointValue.textColor = UIColorFromRGB(0x666B70);
    pointValue.lineBreakMode = NSLineBreakByCharWrapping;
    pointValue.numberOfLines = 0;//上面两行设置多行显示
    pointValue.text = LocatizedStirngForkey(@"SHOUKUANSHUOMING");
    [self.view addSubview: pointValue];
    
}
- (void)drawImage{
    NSString *jsonString;
    NSMutableDictionary *chongDic = [[NSMutableDictionary alloc]init];
    [chongDic setObject:_sysId forKey:@"sysid"];
    [chongDic setObject:_sysName forKey:@"sysname"];
    [chongDic setObject:[HQZXUserModel sharedInstance].currentUser.userId forKey:@"userid"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:chongDic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    if(jsonData){
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
//    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",ApiPicServer,_sysLogo ];
    UIImage *image = [UIImage generateImageWithQrCode:jsonString QrCodeImageSize:0];
//    UIImage *image = [UIImage generateImageWithQrCode:jsonString QrCodeImageSize:0 insertImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: imageUrl]]] radius:16];
    [imageView setImage:image];
}
- (void)saveQrCodeImage:(UITapGestureRecognizer *)tap
{
    if (imageView.image != nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:LocatizedStirngForkey(@"BAOCUNDAOSHOUJI") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImageWriteToSavedPhotosAlbum(imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }];
        [alert addAction:action];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:LocatizedStirngForkey(@"QUXIAO") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action1];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [self.view makeToast:LocatizedStirngForkey(@"BAOCUNCHENGGONG") duration:1 position:CSToastPositionCenter];
    }else{
        [self.view makeToast:LocatizedStirngForkey(@"BAOCUNSHIBAI") duration:1 position:CSToastPositionCenter];
    }
    
}
@end
