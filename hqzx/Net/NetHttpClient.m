//
//  NetHttpClient.m
//  alijk
//
//  Created by easy on 14/7/23.
//  Copyright (c) 2014年 zhongxin. All rights reserved.
//

#import "NetHttpClient.h"
#import "AFNetworkReachabilityManager.h"
#import "AFNetworking.h"
#import "HQZXUserModel.h"
#import "NSString+MD5.h"
#import "AFHTTPRequestOperationManager.h"
#import "CommonUtils.h"


#define SERVER_BASE_URL ([NSString stringWithFormat:@"http://%@/mapi", ApiServer])

@interface NetHttpClient ()

@end

@implementation NetHttpClient

#pragma mark init

+(NetHttpClient*)sharedHTTPClient
{
    static NetHttpClient *_sharedHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"%@",SERVER_BASE_URL);
        _sharedHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:SERVER_BASE_URL]];
    });
    
    return _sharedHTTPClient;
}

-(instancetype)initWithBaseURL:(NSURL*)url
{
    if (self = [super initWithBaseURL:url]) {
    }
    
    return self;
}


#pragma mark post request


- (void) upImages:(NSArray*) images currentIndex:(int) index completion:(JHTImageUpLoadCallBack) completion {
    [self upImages:images currentIndex: index maxSize:UP_IMG_MAX_SIZE completion:completion];
}

- (void) upImages:(NSArray*) images currentIndex:(int) index maxSize:(double) maxSize completion:(JHTImageUpLoadCallBack) completion {
    if (images == nil || index == images.count) {
        completion(index, TRUE, nil);
        return;
    }
    
    id imageObj = [images objectAtIndex: index];
    if ([imageObj isKindOfClass: [NSString class]]) {
        completion(index, YES, imageObj);
        [self upImages: images currentIndex: index+1 maxSize: maxSize completion:completion];
        return;
    }
    __block UIImage *img = [CommonUtils getImageFromItem: imageObj ori: YES];
    WEAK_SELF
    dispatch_queue_t queue = dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        // 异步执行代码
        img = [CommonUtils reSizeImage:img maxSize: CGSizeMake(1200,  900)];
        NSData *zipedImg = [CommonUtils zipImage:img maxSize:UP_IMG_MAX_SIZE];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 回到主线程执行
            [[NetHttpClient sharedHTTPClient] upLoadImg: zipedImg type: UpImageTypeHuoPan completion:^(id obj) {
                if (!obj) {
                    completion(index, NO, nil);
                    if (index < images.count) {
                        [weakself upImages: images currentIndex: index+1 maxSize: maxSize completion:completion];
                    }
                    return;
                }
                
                id errorCode = [obj objectForKey:ApiKey_ErrorCode];
                NSString *errorCodeStr = [NSString stringWithFormat:@"%@", errorCode];
                if ([@"0" isEqualToString: errorCodeStr]) {
                    NSString *url = [obj objectForKey:@"img_url"];
                    completion(index, YES, url);
                } else {
                    NSString *msg = [obj objectForKey:@"message"];
                    completion(index, NO, msg);
                }
                [weakself upImages: images currentIndex: index+1 maxSize: maxSize completion:completion];
            }];
        });
    });
    
}


- (AFHTTPRequestOperation*) upLoadImg:(NSData*) img type:(UpImageType) type completion:(Id_Block)compBlock{
    HQZXImageFormParam *imgFormParam = [[HQZXImageFormParam alloc] initWithImage: img type: type];
    return [self requestForm:@"/imgUpload" param:nil parameters: imgFormParam completion: compBlock];
}
//- (AFHTTPRequestOperation*) postContent:(NSString*) body {
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:@"http://api.jianghai56.com/mapi/test"]];
//    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Contsetent-Type"];
//    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//    }];
//    [operation start];
//    return operation;
//}

-(AFHTTPRequestOperation*)requestForm:(NSString *)path param:(NSDictionary*)param parameters:(NetFormParam *)parameters completion:(Id_Block)compBlock{
    AFHTTPRequestOperationManager *httpRequestOperationManager = [AFHTTPRequestOperationManager manager];
    
    httpRequestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/html", nil];
    
    [httpRequestOperationManager.requestSerializer setValue:AppVersion forHTTPHeaderField:@"app_version"];
    [httpRequestOperationManager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"app_type"];
    NSString *url = [NSString stringWithFormat:@"%@%@",SERVER_BASE_URL,path];
    AFHTTPRequestOperation *operation = [httpRequestOperationManager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        formData = [parameters formData:formData];

    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (compBlock) {
            compBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (compBlock) {
            compBlock(nil);
        }
    }];
    return operation;
}


-(AFHTTPRequestOperation*)request:(NSString *)path parameters:(NSDictionary *)parameters completion:(Id_Block)compBlock
{
    //    [httpRequestOperationManager.requestSerializer setValue: [[UserHelper sharedHelper] getCurrentMeta] forHTTPHeaderField:@"loginstate"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary: parameters];
    [parameter setObject: [HQZXUserModel sharedInstance].userId forKey: @"userid"];
    
    NSTimeInterval ins = [[NSDate date] timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat: @"%.0f", ins];
    [parameter setObject: timeString forKey: @"timestamp"];
    
    NSRange range = [path rangeOfString:@"?"];
    NSMutableDictionary *sumParameter = [NSMutableDictionary dictionaryWithDictionary: parameter];
    
    NSString *pathWithNoParamter = path;
    if (range.location != NSNotFound) {
        NSString *urlParamStr = [path substringFromIndex: range.location + 1];
        NSArray *urlParams = [urlParamStr componentsSeparatedByString: @"&"];
        for (NSString *eachParam in urlParams) {
            NSArray *eachParamAndValue = [eachParam componentsSeparatedByString: @"="];
            NSString *paramName = [eachParamAndValue objectAtIndex:0];
            NSString *paramValue = eachParamAndValue.count >= 2 ? [eachParamAndValue objectAtIndex:1] : @"";
            [sumParameter setObject: paramValue forKey: paramName];
        }
        pathWithNoParamter = [pathWithNoParamter substringToIndex: range.location];
    }
    
//    if (parameter != nil) {
//        NSEnumerator *enumerator = parameter.keyEnumerator;
//        NSString *key = enumerator.nextObject;
//        NSString *customParamter = @"";
//        while (key != nil) {
//            NSObject *value = [parameter objectForKey: key];
//            NSString *valueStr = (value == nil ? @"" :[NSString stringWithFormat:@"%@", value]);
//            customParamter = [customParamter stringByAppendingFormat:@"&%@=%@", key, valueStr];
//            key = enumerator.nextObject;
//        }
//        if (range.location == NSNotFound) {
//            customParamter = [NSString stringWithFormat: @"?%@", [customParamter substringFromIndex: 1]];
//        }
//        path = [path stringByAppendingString: customParamter];
//    }
    
    
    NSString *paramterStrAfterSort = @"";
    if (sumParameter != nil && sumParameter.count > 0) {
        NSArray *keys = [sumParameter allKeys];
        NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        for (NSString *key in sortedArray) {
            NSObject *value = [sumParameter objectForKey: key];
            NSString *valueStr = (value == nil ? @"" :[NSString stringWithFormat:@"%@", value]);
            paramterStrAfterSort = [paramterStrAfterSort stringByAppendingFormat: @"%@|", valueStr];
        }
    }
    /*
     * xxx?k1=v9&k2=v8&k3=v7
     * <v9|v8|v7>|<PRIVATE_KEY>
     */
    NSString *oriString = [NSString stringWithFormat: @"%@%@", paramterStrAfterSort, NET_PK];
    NSString *token = [[oriString MD5String] lowercaseString];
    [sumParameter setObject: token forKey: @"token"];
    
    
    AFHTTPRequestOperationManager *httpRequestOperationManager = [AFHTTPRequestOperationManager manager];

    
    [httpRequestOperationManager.requestSerializer setValue:AppVersion forHTTPHeaderField:@"app_version"];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *isoStr = [infoDictionary objectForKey:@"APP_TYPE"];
    NSString *channel = [infoDictionary objectForKey:@"ChannelId"];
    [httpRequestOperationManager.requestSerializer setValue:isoStr forHTTPHeaderField:@"app_type"];
    [httpRequestOperationManager.requestSerializer setValue:channel forHTTPHeaderField:@"channel"];
    //发送请求
    httpRequestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/html", nil];
//    httpRequestOperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [((AFJSONResponseSerializer*)httpRequestOperationManager.responseSerializer) setRemovesKeysWithNullValues: YES];
    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_BASE_URL, pathWithNoParamter];
    AFHTTPRequestOperation *operation = [httpRequestOperationManager GET:url parameters:sumParameter
                              success:^(AFHTTPRequestOperation *operation, id responseObject){
                                  if (compBlock) {
                                      compBlock(responseObject);
                                      NSString *errorCode = StrValueFromDictionary(responseObject, ApiKey_ErrorCode);
                                      if ([errorCode isEqualToString:@"100004"] || [errorCode isEqualToString:@"100012"]) {
                                          if ([[HQZXUserModel sharedInstance] isLogined]) {
                                              [[HQZXUserModel sharedInstance] logout];
                                          }
                                      }
                                  }
                              }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                  if (compBlock) {
                                      compBlock(nil);
                                  }
                              }];
    return operation;
}

#pragma mark Cancel request

/* 取消请求
 * task：请求的标志
 */
- (void)cancelTask:(NSURLSessionDataTask*)task
{
    [task cancel];
}


#pragma mark Cookies

/* 删除cookies
 */
- (void)deleteCookies{
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [cookieStorage cookiesForURL:[NSURL URLWithString:SERVER_BASE_URL]];
    for (NSHTTPCookie *cookie in cookies)
    {
        [cookieStorage deleteCookie:cookie];
    }
}

@end
