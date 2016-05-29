//
//  JHTUser.m
//  jht
//
//  Created by 孙泽山 on 15/7/4.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#import "JHTUser.h"

@implementation JHTUser


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
