//
//  GDLocalizableController.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/21.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define kUserLanguage @"userLanguage"

@interface GDLocalizableController : NSObject
@property (nonatomic,strong)NSString *currentLanguage;
@property (nonatomic,strong)NSBundle *languageBundle;

+(GDLocalizableController *)shareInstance;
-(void)initUserLanguage;
-(void)saveDefineUserLanguage:(NSString *)userLanguage;
-(NSString *)defineUserLanguage;

-(NSString *)locatizedStringForkey:(NSString *)keyStr;
-(UIStoryboard *)locatizedStoryboardWithName:(NSString *)storyBoardName;
@end
