//
//  HQZXUser.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/28.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQZXUser : NSObject
@property NSString *userId;
@property NSString *userName;
@property NSString *mobile;
@property NSString *auth_key;
@property NSString *identity;
@property (strong, nonatomic) NSMutableDictionary *identity_info;
@property (nonatomic) NSString *userImgUrl;
@property NSString *userGender;
@property NSString *userRole;
@property NSString *userStatus;
@property NSString *timestamp;
@end
