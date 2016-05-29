//
//  AppDelegate.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/18.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "AppDelegate.h"
#import "CommonUtils.h"
#import "LCNewFeatureVC.h"
#import "MacroDefinition.h"

@interface AppDelegate (){
    /** 新特性界面(如果是通过Block方式进入主界面则不需要声明该属性) */
    LCNewFeatureVC *_newFeatureVC;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"changeLanguage" object:nil];
    
    //初始国际化
    [[GDLocalizableController  shareInstance] initUserLanguage];
    [[GDLocalizableController shareInstance]  saveDefineUserLanguage:@"zh-Hans"] ;
    
    //window底层view的背景
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //初始化更新特性图片插件
    BOOL showNewFeature = [LCNewFeatureVC shouldShowNewFeature];
//    BOOL showNewFeature = YES;
    
    self.launchOptions = launchOptions;
    //    NSDictionary *pushInfo = @{@"type":@"order_port_weather",@"load_port":@"504",@"unload_port":@"4008"};
    //    NSDictionary *opt = @{@"UIApplicationLaunchOptionsRemoteNotificationKey":pushInfo};
    //    self.launchOptions = opt;
    
    // 演示--每次都进入新特性界面, 实际项目不需要此句代码
    //    showNewFeature = YES;
    if (showNewFeature) {
        [self initNewFeatureVC];
    } else {
        [self enterMainVC];
    }
    //初始化IQKeyboardManager框架
    [self initIQKeyboardManager];
    
    [self playStopNet];
    return YES;
}
- (void) initNewFeatureVC {
    // 进入主界面按钮
    UIButton *enterBtn = [[UIButton alloc] init];
    [enterBtn setBackgroundColor: nil];
    [enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [enterBtn setTitleColor:UIColorFromRGB(0x027FC9) forState:UIControlStateHighlighted];
    enterBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [enterBtn setTitle:@"点击进入" forState:UIControlStateNormal];
    
    enterBtn.layer.borderWidth = 1;
    // 设置圆角
    enterBtn.layer.cornerRadius = 4.5;
    // 设置颜色空间为rgb，用于生成ColorRef
    
    enterBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    float height = 28.0f;
    [enterBtn setFrame:(CGRect){10.0f, SCREEN_SIZE.height - height - 10, SCREEN_SIZE.width - 20.0f, height}];
    [enterBtn addTarget:self action:@selector(didClickedBtn) forControlEvents:UIControlEventTouchUpInside];
    
    LCNewFeatureVC *newFeatureVC = [LCNewFeatureVC newFeatureWithImageName:@"NewFeature"
                                                                imageCount:3
                                                           showPageControl:YES
                                                               enterButton:enterBtn];
    // 当前点颜色, 默认[UIColor darkGrayColor]
    newFeatureVC.pointCurrentColor = [UIColor whiteColor];
    
    // 其他点颜色, 默认[UIColor lightGrayColor]
    newFeatureVC.pointOtherColor = UIColorFromRGB(0xA4E5FB);
    
    _newFeatureVC = newFeatureVC;
    self.window.rootViewController = _newFeatureVC;
}
- (void)didClickedBtn {
    
//       [self enterMainVC];
    [UIView animateWithDuration:0.4f animations:^{
        
        _newFeatureVC.view.transform = CGAffineTransformMakeTranslation(-SCREEN_SIZE.width, 0);
        
    } completion:^(BOOL finished) {
        
        [self enterMainVC];
    }];
}
-(void)changeLanguage:(NSNotification *)note{
     NSString *phlnum = [[note userInfo] objectForKey:@"selectPlu"];
    _selectSum = [phlnum integerValue];
     [self enterMainVC];
}
- (void)enterMainVC {
    HQZYTabBarController *tabBarVC = [[HQZYTabBarController alloc]init];
    tabBarVC.selectSum = _selectSum?_selectSum:0;
    
    self.nav = [[UINavigationController alloc] initWithRootViewController: tabBarVC];
    self.nav.delegate = self;
    [CommonUtils setNavigationControllerStyle: self.nav];

    self.window.rootViewController = self.nav;
    [self.window makeKeyAndVisible];
    
}
-(void) initIQKeyboardManager {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = NO;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)playStopNet{
    [[NetHttpClient sharedHTTPClient] request:@"/get_config.json" parameters: @{@"is_data":@"1"} completion:^(id obj) {
        NSString *errorCode = StrValueFromDictionary(obj, ApiKey_ErrorCode);
        if ([@"0" isEqualToString: errorCode]) {
            //创建一个本地plist文件
            NSString *isPlistMd5 = [USER_DEFAULT objectForKey:datamd5Key];
            if(isPlistMd5){
                NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *path=[paths objectAtIndex:0];
                NSString *filename=[path stringByAppendingPathComponent:countryKey];
                NSDictionary* dicPorts = [NSDictionary dictionaryWithContentsOfFile:filename];
                NSString *newMd5 = StrValueFromDictionary(dicPorts, datamd5Key);
                NSString *oldMd5 = [USER_DEFAULT objectForKey:datamd5Key];
                if(![newMd5 isEqualToString:oldMd5]){
                    [[NetHttpClient sharedHTTPClient] request:@"/get_config.json" parameters: @{@"is_data":@"0"} completion:^(id obj) {
                        NSString *errorCodes = StrValueFromDictionary(obj, ApiKey_ErrorCode);
                        if ([@"0" isEqualToString: errorCodes]) {
                            NSArray *clearArray = [NSArray array];
                            [clearArray writeToFile:[USER_DEFAULT objectForKey:countryKey] atomically:YES];
                            [obj writeToFile:[USER_DEFAULT objectForKey:countryKey] atomically:YES];
                        }
                    }];
                }
            }else{
                [[NetHttpClient sharedHTTPClient] request:@"/get_config.json" parameters: @{@"is_data":@"0"} completion:^(id obj) {
                    NSString *errorCoded = StrValueFromDictionary(obj, ApiKey_ErrorCode);
                    if ([@"0" isEqualToString: errorCoded]) {
                        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                        NSString *path=[paths objectAtIndex:0];
                        NSString *filename=[path stringByAppendingPathComponent:countryKey];
                        NSString *md5Value = StrValueFromDictionary(obj, datamd5Key);
                        [USER_DEFAULT setObject: md5Value forKey: datamd5Key];
                        NSFileManager* fm = [NSFileManager defaultManager];
                        [fm createFileAtPath:filename contents:nil attributes:nil];
                        
                        //写入plist文件里
                        [obj writeToFile:filename atomically:YES];
                    }
                }];
                
            }
           
            
//            //读取plist文件
//            NSDictionary* dicPorts = [NSDictionary dictionaryWithContentsOfFile:filename];
//            
//            //清空plist
//            NSArray *clearArray = [NSArray array];
//            [clearArray writeToFile:filename atomically:YES];
//            
//            //写入plist
//            [savePortDic writeToFile:filename atomically:YES];
        } else {
            
        }
    }];
}
@end
