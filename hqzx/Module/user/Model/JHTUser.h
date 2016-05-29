//
//  JHTUser.h
//  jht
//
//  Created by 孙泽山 on 15/7/4.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHTUser : NSObject
@property NSString *userId;
@property NSString *userName;
@property NSString *mobile;
@property (nonatomic) NSString *userImgUrl;
@property NSString *userGender;
@property NSString *userRole;
@property NSString *userStatus;
@property NSString *timestamp;
@end
