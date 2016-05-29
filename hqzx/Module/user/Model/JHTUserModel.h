//
//  JHTUserModel.h
//  jht
//
//  Created by 孙泽山 on 15/6/24.
//  Copyright (c) 2015年 zthz. All rights reserved.
//
#define CURRENT_USER_KEY @"CURRENT_USER"
#define CURRENT_USER_CONTACT_KEY @"CURRENT_USER_CONTACT"
#define IS_CHUANZHU_KEY @"IS_CHUANZHU"
#define IS_HUOZHU_KEY @"IS_HUOZHU"
#define JHTHomeDoAnimateNotification @"JHTHomeDoAnimate"
#define JHTLoginNotification @"JHTLogin"
#define JHTLogoutNotification @"JHTLogout"
#define JHTUserChangedNotification @"JHTUserInfoChanged"

#import "JHTUserContact.h"
#import "JHTUser.h"
#import <UIKit/UIKit.h>

typedef void (^Contact_Block)(JHTUserContact *userContact);
#define Contact_Block() ^void (JHTUserContact *userContact)

enum JHTRenzheng
{
    JHTRenzhengWeirenzheng = 0,
    JHtRenzhengShenhezhong = 1,
    JHtRenzhengYirenzheng = 2,
    JHtRenzhengWeitongguo = 3
};

@interface JHTUserModel : UIView
SYNTHESIZE_SINGLETON_FOR_HEADER


@property (nonatomic, strong) JHTUser *currentUser;


-(void) setDeviceToken:(NSString*) deviceToken;
-(NSString*) getDeviceToken;
-(BOOL) isLogined;
- (NSString*) userId;
- (void) logout;
- (void) login:(NSString*) phoneNo pwd:(NSString*) password completion:(Id_Block) completion;


- (void) updateUserHeaderImage:(NSString*) headerImage;

-(void) removeCacheForContactInfo;
-(void) getContactInfo:(Contact_Block) callback beginRequestNet:(Void_Block) beginRequestNet;

-(void) isShipHost:(Id_Block) callback beginRequestNet:(Void_Block) beginRequestNet;
-(void) isGoodsHost:(Id_Block) callback beginRequestNet:(Void_Block) beginRequestNet;
@end
