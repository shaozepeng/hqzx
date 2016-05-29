//
//  JHTUserModel.m
//  jht
//
//  Created by 孙泽山 on 15/6/24.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#import "HQZXUserModel.h"
#import "NetHttpClient.h"
//#import "UMessage.h"
#import "MJExtension.h"
#import "CommonUtils.h"
//#import <Bugtags/Bugtags.h>

@implementation HQZXUserModel
SYNTHESIZE_SINGLETON_FOR_CLASS(HQZXUserModel)

-(HQZXUser*) currentUser {
    if (_currentUser == nil) {
        NSData *userData = [USER_DEFAULT objectForKey:CURRENT_USER_KEY];
        if (userData) {
            NSDictionary *userDic = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
            _currentUser = [[HQZXUser alloc] init];
            _currentUser.userId = StrValue(userDic, @"userid");
            _currentUser.userName = StrValue(userDic, @"username");
            _currentUser.userImgUrl = StrValue(userDic, @"user_img_url");
            _currentUser.userGender = StrValue(userDic, @"user_gender");
            _currentUser.userRole = StrValue(userDic, @"user_role");
            _currentUser.userStatus = StrValue(userDic, @"user_status");
            _currentUser.timestamp = StrValue(userDic, @"timestamp");
        }
    }
    return _currentUser;
}

- (void) login:(NSString*) phoneNo pwd:(NSString*) password completion:(Id_Block) completion {
    
    [[NetHttpClient sharedHTTPClient] request: @"/login" parameters:@{@"mobile":phoneNo, @"pwd": [CommonUtils securityPasswd:password], @"device_id": DeviceId, @"device_type": DeviceType, @"app_version": AppVersion, @"pwd_type": @"1"} completion:^(id obj) {
        if (obj) {
            id errorCode = [obj objectForKey:ApiKey_ErrorCode];
            NSString *errorCodeStr = [NSString stringWithFormat:@"%@", errorCode];
            if ([@"0" isEqualToString: errorCodeStr]) {
                NSData *arc = [NSKeyedArchiver archivedDataWithRootObject: obj];
                [USER_DEFAULT setObject: arc forKey: CURRENT_USER_KEY];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:JHTLoginNotification object:nil];
                HQZXUser *currentUser = [HQZXUserModel sharedInstance].currentUser;
                NSString *userId = currentUser.userId;
//                [Bugtags setUserData:currentUser.mobile forKey:@"user"];
//                NSLog(@"LOGIN SUCCESS, userId:%@,userName:%@,userMobile:%@", currentUser.userId, currentUser.userName, currentUser.mobile?:@"<NULL>");
//                [CommonUtils addUMengAlias:userId type:@"userid" startFromTime: 1];
//                [UMessage addAlias:userId type: @"userid" response:^(id responseObject, NSError *error) {
//                    NSLog(@"%@", responseObject);
//                }];
                
                if (completion) {
                    completion(obj);
                }
            } else {
                if (completion) {
                    completion([obj objectForKey:@"message"]);
                }
            }
        } else {
            if (completion) {
                completion(nil);
            }
        }
    }];
}

- (void) updateUserHeaderImage:(NSString*) headerImage {
    HQZXUser *currentuser = [HQZXUserModel sharedInstance].currentUser;
    currentuser.userImgUrl = headerImage;
    
    NSDictionary *dic = @{@"userid":currentuser.userId, @"username":currentuser.userName, @"user_img_url": currentuser.userImgUrl, @"user_gender": currentuser.userGender, @"user_role":currentuser.userRole, @"user_status":currentuser.userStatus, @"timestamp": currentuser.timestamp};
    NSData *arc = [NSKeyedArchiver archivedDataWithRootObject: dic];
    //    [USER_DEFAULT removeObjectForKey:CURRENT_USER_KEY];
    [USER_DEFAULT setObject: arc forKey: CURRENT_USER_KEY];
}

- (void) logout {
    [USER_DEFAULT removeObjectForKey:IS_HUOZHU_KEY];
    [USER_DEFAULT removeObjectForKey:IS_CHUANZHU_KEY];
    [self removeCacheForContactInfo];
    [CommonUtils removeUMengAlias:[HQZXUserModel sharedInstance].currentUser.userId type:@"userid" startFromTime: 1];
    _currentUser = nil;
//    [Bugtags setUserData:nil forKey:@"user"];
    [USER_DEFAULT removeObjectForKey: CURRENT_USER_KEY];
    [[NSNotificationCenter defaultCenter] postNotificationName:JHTLogoutNotification object:nil];
//    MyMeViewController *myMeView = [[MyMeViewController alloc]init];
//    [myMeView onExitUpInClick:nil];
}
-(void) setDeviceToken:(NSString*) deviceToken {
    [USER_DEFAULT setObject: deviceToken forKey: @"deviceTokenForNotification"];
}
-(NSString*) getDeviceToken {
    return [USER_DEFAULT objectForKey: @"deviceTokenForNotification"];
}
-(BOOL) isLogined {
    return self.currentUser != nil;
}
-(void) removeCacheForContactInfo {
    [USER_DEFAULT removeObjectForKey:CURRENT_USER_CONTACT_KEY];
}
-(void) getContactInfo:(Contact_Block) callback beginRequestNet:(Void_Block) beginRequestNet {
    NSData *userData = [USER_DEFAULT objectForKey:CURRENT_USER_CONTACT_KEY];
    if (!userData) {
        if (beginRequestNet) {
            beginRequestNet();
        }
        [[NetHttpClient sharedHTTPClient] request:@"/user_info" parameters:nil completion:^(id obj) {
            if (obj == nil) { return; }
            if(!ApiResultSuccess(obj)) {
                callback(nil);
                return;
            }
            NSDictionary *info = [obj objectForKey:@"info"];
            NSString *status = StrValueFromDictionary(info, @"is_authed");
            if (![@"2" isEqualToString: status]) {  // 不是认证通过
                callback(nil);
                return;
            }
            HQZXUserContact *userContact = [[HQZXUserContact alloc] init];
            userContact.name = StrValueFromDictionary(info, @"name");
            userContact.mobile = StrValueFromDictionary(info, @"mobile");
            userContact.tel = StrValueFromDictionary(info, @"tel");
            NSData *arc = [NSKeyedArchiver archivedDataWithRootObject: userContact.keyValues];
            [USER_DEFAULT setObject: arc forKey: CURRENT_USER_CONTACT_KEY];
            callback(userContact);
            
        }];
        return;
    }

    HQZXUserContact *userContact = [[HQZXUserContact alloc] init];
    NSDictionary *userDic = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    userContact.name = [userDic objectForKey:@"name"];
    userContact.mobile = [userDic objectForKey:@"mobile"];
    userContact.tel = [userDic objectForKey:@"tel"];
    callback(userContact);
    return;

}

-(void) isShipHost:(Id_Block) callback beginRequestNet:(Void_Block) beginRequestNet {
    if([USER_DEFAULT objectForKey:IS_CHUANZHU_KEY]){
        callback(nil);
    }else{
        if (beginRequestNet) {
            beginRequestNet();
        }
        [[NetHttpClient sharedHTTPClient] request: @"/my_id_auth" parameters: @{@"types":@"2"} completion:^(id obj) {
            if (obj == nil) {
                callback(@"连接服务器失败，请检查网络！");
                return;
            }
            if (!ApiResultSuccess(obj)) {
                NSString *msg = [obj objectForKey:@"message"];
                callback(msg);
                return;
            }
            NSString *isAuthed = [obj objectForKey:@"is_authed"];
            if([isAuthed isEqualToString:@"2"]==YES){
                [USER_DEFAULT setObject: @"YES" forKey:IS_CHUANZHU_KEY];
                callback(nil);
            } else {
                callback([NSNumber numberWithDouble:isAuthed.doubleValue]);
            }
        }];
    }
}
-(void) isGoodsHost:(Id_Block) callback beginRequestNet:(Void_Block) beginRequestNet {
    
    if([USER_DEFAULT objectForKey:IS_HUOZHU_KEY]){
        callback(nil);
    }else{
        if (beginRequestNet) {
            beginRequestNet();
        }
        [[NetHttpClient sharedHTTPClient] request: @"/my_id_auth" parameters: @{@"types":@"1"} completion:^(id obj) {
            if (obj == nil) {
                callback(@"连接服务器失败，请检查网络！");
                return;
            }
            if (!ApiResultSuccess(obj)) {
                NSString *msg = [obj objectForKey:@"message"];
                callback(msg);
                return;
            }
            NSString *isAuthed = [obj objectForKey:@"is_authed"];
            if([isAuthed isEqualToString:@"2"]==YES){
                [USER_DEFAULT setObject: @"YES" forKey:IS_HUOZHU_KEY];
                callback(nil);
            } else {
                callback([NSNumber numberWithDouble:isAuthed.doubleValue]);
            }
        }];
    }
}

- (NSString*) userId {
    if (self.currentUser) {
        return self.currentUser.userId;
    } else {
        return @"0";
    }
}

@end
