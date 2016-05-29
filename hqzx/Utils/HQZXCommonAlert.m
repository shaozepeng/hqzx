//
//  JHTCommonAlert.m
//  jht
//
//  Created by 孙泽山 on 15/6/24.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#import "XQZXCommonAlert.h"

@implementation XQZXCommonAlert

+ (void) alertMsg:(NSString*) msg yes:(DoAlertViewHandler)yes
               no:(DoAlertViewHandler) no{
    DoAlertView *alertView = [[DoAlertView alloc] init];
    alertView.bDestructive = NO;
    alertView.nAnimationType = DoTransitionStylePop;
    [alertView doYesNo:@"提示"
                  body: msg
                   yes: yes no: no];
}
+ (void) alertBodyTextMsg:(NSString*) msg title:(NSString*) title yesBtn:(NSString*)strYes noBtn:(NSString*)strtNo yes:(DoAlertViewHandler)yes no:(DoAlertViewHandler)no{
    DoAlertView *alertView = [[DoAlertView alloc] init];
    alertView.bDestructive = NO;
    alertView.nAnimationType = DoTransitionStylePop;
    [alertView doYesNo:title bodyStr:msg yesBtn:strYes noBtn:strtNo yes:yes no:no];
}
+ (void) alertBodyTextMsg:(NSString*) msg yesBtn:(NSString*)strYes noBtn:(NSString*)strtNo yes:(DoAlertViewHandler)yes
                       no:(DoAlertViewHandler)no {
    [XQZXCommonAlert alertBodyTextMsg: msg title:@"提示" yesBtn:strYes noBtn:strtNo yes: yes no: no];
}

+ (void) alertCustomMsg:(UIView*)bodyview title:(NSString*) title yesBtn:(NSString*)strYes noBtn:(NSString*)strtNo yes:(DoAlertViewHandler)yes no:(DoAlertViewHandler)no{
    DoAlertView *alertView = [[DoAlertView alloc] init];
    alertView.bDestructive = NO;
    alertView.nAnimationType = DoTransitionStylePop;
    [alertView doYesNo:title body:bodyview yesBtn:strYes noBtn:strtNo yes: yes no: no];
}

+ (void) alertCustomMsg:(UIView*)bodyview yesBtn:(NSString*)strYes noBtn:(NSString*)strtNo yes:(DoAlertViewHandler)yes
                     no:(DoAlertViewHandler)no{
    [XQZXCommonAlert alertCustomMsg:bodyview title: @"提示" yesBtn: strYes noBtn: strtNo yes: yes no: no];
}

+ (void) alertCustomButtonContent:(NSArray*)btnArray custom:(DoAlertBtnHandler)customBlock{
    DoAlertView *alertView = [[DoAlertView alloc] init];
    alertView.bDestructive = NO;
    alertView.nAnimationType = DoTransitionStylePop;
    [alertView doYesNo:btnArray customdo:customBlock];
}
+ (void) alertCustomTitleButtonContent:(NSArray*)btnArray title:(NSString*) title custom:(DoAlertBtnHandler)customBlock{
    DoAlertView *alertView = [[DoAlertView alloc] init];
    alertView.bDestructive = NO;
    alertView.nAnimationType = DoTransitionStylePop;
    [alertView doYesNo:btnArray title: @"提示" customdo:customBlock];
}
//+ (void) alertCustomTableContent:(UITableView*)bodyTableView yes:(DoAlertViewHandler)yes
//                              no:(DoAlertViewHandler)no{
//    DoAlertView *alertView = [[DoAlertView alloc] init];
//    alertView.bDestructive = NO;
//    alertView.nAnimationType = DoTransitionStylePop;
//    [alertView doYesNo:@"船舶交易平台" body:bodyview yesBtn:strYes noBtn:strtNo yes: yes no: no];
//}
@end
