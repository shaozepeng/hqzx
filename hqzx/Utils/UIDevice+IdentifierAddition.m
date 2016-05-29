//
//  UIDevice(Identifier).m
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//
#define KEY_UUID @"UUID"

#import "UIDevice+IdentifierAddition.h"
#import <SSKeychain/SSKeychain.h>
@interface UIDevice(Private)

- (NSString *) macaddress;

@end

@implementation UIDevice (IdentifierAddition)



-(NSString*) uuid {
    NSString *str =nil;
    
    NSError *error = nil;
    
    SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
    query.service = KEY_UUID;
    query.account = KEY_UUID;
    query.password = nil;
    if (![query fetch:&error]) {
        
        query = [[SSKeychainQuery alloc] init];
        query.service = KEY_UUID;
        query.account = KEY_UUID;
        query.label = KEY_UUID;
        CFUUIDRef puuid = CFUUIDCreate(nil);
        CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
        NSString *myUUIDStr = (NSString*) CFBridgingRelease(CFStringCreateCopy(NULL, uuidString)); //[[[UIDevice currentDevice] identifierForVendor] UUIDString];
        myUUIDStr = [myUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        query.password = myUUIDStr;
        if (![query save:&error]) {
            str = @"";  // 错误时返回一个空字符串
        } else {
            str = myUUIDStr;
        }
    } else {
        str = query.password;
    }
    return str;
}
@end
