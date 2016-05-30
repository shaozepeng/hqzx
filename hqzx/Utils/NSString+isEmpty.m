//
//  NSString+isEmpty.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/28.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
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
