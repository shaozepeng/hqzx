//
//  JHTCommonAlert.h
//  jht
//
//  Created by 孙泽山 on 15/6/24.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

/*

 1. 自定义弹出框，body中提示文字，固定YES按钮：是的、NO按钮：取消
    JHTConfirm(@"使用此功能需要登录，您需要登录吗？", ^(DoAlertView *alertView) {
     
    }, ^(DoAlertView *alertView) {

    });
 2.自定义弹出框，body中提示文字，自定义YES按钮、NO按钮上的文字
     JHTBodyTextConfirm(@"使用此功能需要登录，您需要登录吗？",@"科比",@"杜兰特", ^(DoAlertView *alertView) {
     }, ^(DoAlertView *alertView) {
     
     });
 3.自定义弹出框分行布局按钮，没有YES按钮、NO按钮
     JHTButtonsConfirm((@[@"订单详情",@"关闭交易",@"取消"]),^(NSInteger index) {
         if(index==0){
             [weakself firstClick];
         }
         if(index==1){
             [weakself secondClick];
         }
         if(index==2){
             [weakself thirdClick];
         }
     });
 4.自定义body体view，自定义YES按钮、NO按钮上的文字
     JHTCustomConfirm(noticeView, @"现在就去", @"先这样",^(DoAlertView *alertView) {
      }, ^(DoAlertView *alertView) {
      });
 
 */

#import <Foundation/Foundation.h>
#import "DoAlertView.h"

@interface XQZXCommonAlert : NSObject

+ (void) alertMsg:(NSString*) msg yes:(DoAlertViewHandler)yes
               no:(DoAlertViewHandler)no;
+ (void) alertBodyTextMsg:(NSString*) msg title:(NSString*) title yesBtn:(NSString*)strYes noBtn:(NSString*)strtNo yes:(DoAlertViewHandler)yes no:(DoAlertViewHandler)no;
+ (void) alertBodyTextMsg:(NSString*) msg yesBtn:(NSString*)strYes noBtn:(NSString*)strtNo yes:(DoAlertViewHandler)yes
               no:(DoAlertViewHandler)no;

+ (void) alertCustomMsg:(UIView*)bodyview title:(NSString*) title yesBtn:(NSString*)strYes noBtn:(NSString*)strtNo yes:(DoAlertViewHandler)yes no:(DoAlertViewHandler)no;
+ (void) alertCustomMsg:(UIView*)bodyview yesBtn:(NSString*)strYes noBtn:(NSString*)strtNo yes:(DoAlertViewHandler)yes
               no:(DoAlertViewHandler)no;
+ (void) alertCustomButtonContent:(NSArray*)btnArray custom:(DoAlertBtnHandler)customBlock;
+ (void) alertCustomTitleButtonContent:(NSArray*)btnArray title:(NSString*) title custom:(DoAlertBtnHandler)customBlock;
@end
#define JHTConfirm(MSG, YESBLOCK, NOBLOCK) [JHTCommonAlert alertMsg:MSG yes:YESBLOCK no:NOBLOCK]
#define JHTBodyTextConfirm(MSG,strYes,strtNo,YESBLOCK, NOBLOCK) [JHTCommonAlert alertBodyTextMsg:MSG yesBtn:strYes noBtn:strtNo yes:YESBLOCK no:NOBLOCK]
#define JHTBodyTextConfirmWithTitle(MSG, TITLE_,strYes,strtNo,YESBLOCK, NOBLOCK) [JHTCommonAlert alertBodyTextMsg:MSG title: TITLE_ yesBtn:strYes noBtn:strtNo yes:YESBLOCK no:NOBLOCK]

#define JHTCustomConfirmWithTitle(bodyview,TITLE_,strYes,strtNo,YESBLOCK, NOBLOCK) [JHTCommonAlert alertCustomMsg:bodyview title:TITLE_ yesBtn:strYes noBtn:strtNo yes:YESBLOCK no:NOBLOCK]
#define JHTCustomConfirm(bodyview,strYes,strtNo,YESBLOCK, NOBLOCK) [JHTCommonAlert alertCustomMsg:bodyview yesBtn:strYes noBtn:strtNo yes:YESBLOCK no:NOBLOCK]
#define JHTButtonsConfirm(btnArray,customBlock) [JHTCommonAlert alertCustomButtonContent:(btnArray) custom:customBlock]
#define JHTTiltleButtonsConfirm(btnArray,titleStr,customBlock) [JHTCommonAlert alertCustomTitleButtonContent:(btnArray) title:titleStr custom:customBlock]
//#define JHTCustomTableConfirm(bodyTableView,YESBLOCK, NOBLOCK) [JHTCommonAlert alertCustomTableContent:bodyTableView yes:YESBLOCK no:NOBLOCK]
