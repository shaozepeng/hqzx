//
//  HQZXUser.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/28.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXUser.h"

@implementation HQZXUser


-(void)setUserImgUrl:(NSString*) url {
    id urlId = url;
    if (urlId == [NSNull null]) {
        _userImgUrl = @"";
        return;
    }
    if ([url isKindOfClass:[NSString class]]) {
        _userImgUrl = url;
    } else {
        _userImgUrl = [NSString stringWithFormat: @"%@", url];
    }
}
-(void)setIdentity_info:(NSDictionary *)value{
    _identity_info = [[NSMutableDictionary alloc]init];
    [_identity_info setValue:[value objectForKey:@"name"] forKey:@"name"];
    [_identity_info setValue:StrValueFromDictionary(value, @"identitytype") forKey:@"identitytype"];
    [_identity_info setValue:[value objectForKey:@"identityno"] forKey:@"identityno"];
}
@end
