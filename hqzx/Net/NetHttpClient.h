//
//  NetHttpClient.h
//  alijk
//
//  Created by easy on 14/7/23.
//  Copyright (c) 2014年 zhongxin. All rights reserved.
//

static const NSString *NET_PK = @"1234567890";

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "NetFormParam.h"
#import "HQZXImageFormParam.h"
@interface NetHttpClient : AFHTTPSessionManager

+(NetHttpClient*)sharedHTTPClient;
-(instancetype)initWithBaseURL:(NSURL*)url;

- (void) upImages:(NSArray*) images currentIndex:(int) index completion:(JHTImageUpLoadCallBack) completion;

- (void) upImages:(NSArray*) images currentIndex:(int) index maxSize:(double) maxSize completion:(JHTImageUpLoadCallBack) completion;

-(AFHTTPRequestOperation*)requestForm:(NSString *)path param:(NSDictionary*)param parameters:(NetFormParam *)parameters completion:(Id_Block)compBlock;
-(AFHTTPRequestOperation*)request:(NSString *)path parameters:(NSDictionary *)parameters completion:(Id_Block)compBlock;
-(void)cancelTask:(NSURLSessionDataTask*)task;
-(void)deleteCookies;

- (AFHTTPRequestOperation*) upLoadImg:(NSData*) img type:(UpImageType) type completion:(Id_Block)compBlock;


//- (AFHTTPRequestOperation*) postContent:(NSString*) body;
@end
