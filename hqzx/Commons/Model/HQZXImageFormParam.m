//
//  JHTImageFormParam.m
//  jht
//
//  Created by 孙泽山 on 15/7/22.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#import "HQZXImageFormParam.h"
#import "HQZXUserModel.h"
#import "NetHttpClient.h"
#import "NSString+MD5.h"

@implementation HQZXImageFormParam

- (instancetype) initWithImage:(NSData*) image type:(UpImageType) type {
    self = [super init];
    if (self) {
        self.imgupload = image;
        self.type = type;
    }
    return self;
}


-(id)formData:(id<AFMultipartFormData>)formData{
    NSString *userId = [[HQZXUserModel sharedInstance] currentUser].userId;
    NSTimeInterval ins = [[NSDate date] timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat: @"%.0f", ins];
    
    NSString *ori = [NSString stringWithFormat:@"%@|%d|%@|%@", timeString, self.type, userId, NET_PK];
    
    [formData appendPartWithFormData:[timeString dataUsingEncoding:NSUTF8StringEncoding] name:@"timestamp"];
    [formData appendPartWithFormData:[[NSString stringWithFormat:@"%d", self.type] dataUsingEncoding:NSUTF8StringEncoding] name:@"types"];
    [formData appendPartWithFormData:[userId dataUsingEncoding:NSUTF8StringEncoding] name:@"userid"];
    [formData appendPartWithFormData:[[[ori MD5String] lowercaseString] dataUsingEncoding:NSUTF8StringEncoding] name:@"token"];
    
    NSData *data = self.imgupload;
    NSString *name = [NSString stringWithFormat:@"image%.0f", [NSDate timeIntervalSinceReferenceDate]];
    NSString *fileName = [name stringByAppendingString:@".png"];
    [formData appendPartWithFileData:data name:@"upimage" fileName:fileName mimeType:@"multipart/form-data"];
    
    return formData;
}
@end
