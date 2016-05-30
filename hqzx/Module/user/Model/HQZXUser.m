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
@end
