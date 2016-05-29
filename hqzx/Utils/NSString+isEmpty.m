//
//  NSString+isEmpty.m
//  haikou
//
//  Created by sunzsh on 15/1/19.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#import "NSString+isEmpty.h"

@implementation NSString (isEmpty)

-(BOOL) isEmpty {
    if ([self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return YES;
    }
    return NO;
}
-(BOOL) isNotEmpty {
    return ![self isEmpty];
}
@end
