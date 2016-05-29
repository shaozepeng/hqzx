//
//  CommonUtils.m
//  shenzhenwujing
//
//  Created by sunzsh on 15/2/4.
//  Copyright (c) 2015年 51haobaby. All rights reserved.
//

#import "CommonUtils.h"
#import <CTAssetsPickerController.h>
#import <AssetsLibrary/ALAsset.h>
#import <CommonCrypto/CommonCrypto.h>
#import "JHTUserModel.h"
#import "JHTNeedLoginController.h"
#import "JHTWoDeXiaoXiViewController.h"
#import "NSObject+Properties.h"
#import "UMessage.h"
#import "MobClick.h"
#import "NSString+MD5.h"

//空字符串
#define     LocalStr_None           @""

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation CommonUtils


/**
 * rect:位置、尺寸信息，当宽/高等于CGFLOAT_DEFINED时为图片的尺寸
 */
+ (UIView*) createHalfXing:(CGRect) rect floatValue:(float) value {
    UIImage *backImg=[UIImage imageNamed:@"pingjiadengjitwo"];
    if (rect.size.width == CGFLOAT_DEFINED) {
        rect = CGRectMake(rect.origin.x, rect.origin.y, backImg.size.width, rect.size.height);
    }
    if (rect.size.height == CGFLOAT_DEFINED) {
        rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, backImg.size.height);
    }
    UIView *xingWrapper = [[UIView alloc] initWithFrame: rect];
    xingWrapper.layer.masksToBounds = YES;
    if (backImg.size.height != rect.size.height || backImg.size.width != rect.size.width) {
        backImg = [CommonUtils reSizeImage:backImg toSize: CGSizeMake(rect.size.width,  rect.size.height)];
    }
    
    UIImageView *backImgView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, backImg.size.width, backImg.size.height)];
    [backImgView setImage:backImg];
    [xingWrapper addSubview:backImgView];
    
    UIImage *img = [UIImage imageNamed:@"pingjiadengji"];
    if (img.size.height != rect.size.height || img.size.width != rect.size.width) {
        img = [CommonUtils reSizeImage:img toSize: CGSizeMake(rect.size.width,  rect.size.height)];
    }
    UIImageView *imgView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, img.size.width * value, img.size.height)];
    imgView.contentMode = UIViewContentModeLeft;
    imgView.layer.masksToBounds = YES;
    [imgView setImage:img];
    [xingWrapper addSubview:imgView];
    return xingWrapper;
}

+ (NSString*) securityPasswd:(NSString*) pwd {
    return [CommonUtils base64StringFromText: [[pwd MD5String] lowercaseString]];
}

+ (NSDictionary*)dictionaryFromQuery:(NSString*)query usingEncoding:(NSStringEncoding)encoding {
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:query];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString* value = [[kvPair objectAtIndex:1]
                               stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}

+ (void) removeUMengAlias:(NSString*) value type:(NSString*) type startFromTime:(int) i {
    if (value == nil) {
        return;
    }
    NSString *deviceToken = [[JHTUserModel sharedInstance] getDeviceToken];
    NSString *time = [NSString stringWithFormat:@"%i", i];
    NSString *desc = [NSString stringWithFormat:@"%@-%@-%@-%@", (APPTEST?@"TEST":@"PRODUCT"), value, deviceToken, time];
    if (i > 20) {
        if (deviceToken || [deviceToken isEmpty]) {
            [MobClick event:@"removeUMengAliasFail" attributes: @{@"TEST":(APPTEST?@"YES":@"NO"), type:value, @"times":time, @"desc": desc, @"deviceToken": deviceToken}];
        }
        return;
    }
    
    [UMessage removeAlias:value type:type response:^(id responseObject, NSError *error) {
        if (error) {
            [CommonUtils removeUMengAlias: value type: type startFromTime: i+1];
        }
        if (deviceToken || [deviceToken isEmpty]) {
            [MobClick event:@"removeUMengAliasSuccess" attributes: @{@"TEST":(APPTEST?@"YES":@"NO"), type:value, @"times":time, @"desc": desc, @"deviceToken": deviceToken}];
        }
    }];
}

+ (void) addUMengAlias:(NSString*) value type:(NSString*) type startFromTime:(int) i {
    if (value == nil) {
        return;
    }
    
    NSString *deviceToken = [[JHTUserModel sharedInstance] getDeviceToken];
    NSString *time = [NSString stringWithFormat:@"%i", i];
    NSString *desc = [NSString stringWithFormat:@"%@-%@-%@-%@", (APPTEST?@"TEST":@"PRODUCT"), value, deviceToken, time];
    if (i > 20) {
        if (deviceToken || [deviceToken isEmpty]) {
            [MobClick event:@"addUMengAliasFail" attributes: @{@"TEST":(APPTEST?@"YES":@"NO"), type:value, @"times":time, @"desc": desc, @"deviceToken": deviceToken}];
        }
        return;
    }
    [UMessage addAlias:value type:type response:^(id responseObject, NSError *error) {
        if (error) {
            [CommonUtils addUMengAlias: value type: type startFromTime: i+1];
        }
        if (deviceToken || [deviceToken isEmpty]) {
            [MobClick event:@"addUMengAliasSuccess" attributes: @{@"TEST":(APPTEST?@"YES":@"NO"), type:value, @"times":time, @"desc": desc, @"deviceToken": deviceToken}];
        }
    }];
}


+ (BOOL) setParameterValue:(NSString*) value key:(NSString*) key target:(NSObject*) target {
    NSString *type = [NSString stringWithUTF8String:[target typeOfPropertyNamed: key]];
    
    SEL selector = [target setterForPropertyNamed: key];
    
    
    if ([@"T@\"NSString\"" isEqualToString: type]) {
        [target performSelector:selector withObject:value];
        return YES;
    } else if ([@"T@\"NSArray\"" isEqualToString: type]) {
        if (value == nil) {
            return NO;
        }
        [target performSelector:selector withObject:[value split:RX(@"\\s*\\,\\s*")]];
        return YES;
    } else if ([@"T@\"NSNumber\"" isEqualToString: type]) {
        if (value == nil) {
            return NO;
        }
        [target performSelector:selector withObject:[NSNumber numberWithDouble:[value doubleValue]]];
        return YES;
    } else if ([@"T@\"NSDate\"" isEqualToString: type]) {
        if (value == nil) {
            return NO;
        }
        if (type.length == 10) {
            [target performSelector:selector withObject:[NSDate dateFromString:value withFormat:@"yyyy-MM-dd"]];
            return YES;
        } else if (type.length == 19) {
            return [target performSelector:selector withObject:[NSDate dateFromString:value withFormat:@"yyyy-MM-dd HH:mm:ss"]];
            return YES;
        } else {
            return nil;
        }
    } else if ([@"TB" isEqualToString: type]) {
        NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        BOOL b = [value boolValue];
        [invocation setArgument:&b atIndex:2];
        [invocation setSelector: selector];
        [invocation setTarget:target];
        [invocation invoke];
        return YES;
    } else if ([@"Ti" isEqualToString: type]) {
        NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        int i = [value intValue];
        [invocation setArgument:&i atIndex:2];
        [invocation setSelector: selector];
        [invocation setTarget:target];
        [invocation invoke];
        return YES;
    } else if ([@"Td" isEqualToString: type]) {
        NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        double d = [value doubleValue];
        [invocation setArgument:&d atIndex:2];
        [invocation setSelector: selector];
        [invocation setTarget:target];
        [invocation invoke];
        return YES;
    } else if ([@"Tf" isEqualToString: type]) {
        NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        float f = [value floatValue];
        [invocation setArgument:&f atIndex:2];
        [invocation setSelector: selector];
        [invocation setTarget:target];
        [invocation invoke];
        return YES;
    } else if ([@"Tq" isEqualToString: type]) {
        NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        NSInteger ni = [value integerValue];
        [invocation setArgument:&ni atIndex:2];
        [invocation setSelector: selector];
        [invocation setTarget:target];
        [invocation invoke];
    } else {
        return NO;
    }
    return NO;
}

+ (void) openUrl:(NSString*) url {
    //    WEAK_SELF
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^{
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    });
}

+ (void) gotoPushMsgWithUserInfo:(NSDictionary*) userInfo {
    id nl = [userInfo objectForKey:@"nl"];
    if (nl == nil) {    // 默认是1
        nl = @"1";
    }
    nl = [NSString stringWithFormat:@"%@", nl];
    NSString *type = [userInfo objectForKey:@"type"];
    NSString *targetId = [userInfo objectForKey:@"id"];
    NSString *openUrl = [userInfo objectForKey:@"o"];
    if (openUrl == nil || [openUrl isEmpty]) {
        openUrl = [CommonUtils getUrlByType:type targetId:targetId userInfo:userInfo];
    }
    if (openUrl != nil && [openUrl isNotEmpty]) {
        if ([nl isEqualToString:@"0"]) {
            //            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: openUrl]];
            [CommonUtils openUrl: openUrl];
        } else {
            if([[JHTUserModel sharedInstance] isLogined]) {
                [CommonUtils openUrl: openUrl];
            } else {
                JHTNeedLoginController *needLogin = [[JHTNeedLoginController alloc] initWithUrl: openUrl];
                [needLogin pushFrom: rootNav.topViewController inNavigationController:rootNav animated: YES];
            }
        }
    } else {
        JHTWoDeXiaoXiViewController *xiaoxi=[[JHTWoDeXiaoXiViewController alloc]init];
        JHTNeedLoginController *needLogin = [[JHTNeedLoginController alloc] initWithController: xiaoxi];
        [needLogin pushFrom: rootNav.topViewController inNavigationController: rootNav animated: YES];
    }
}

+ (NSString*) getUrlByType:(NSString*) type targetId:(NSString*) targetId userInfo:(NSDictionary*) userInfo {
    if (type == nil || [type isEmpty]) {
        return nil;
    }
    NSString *urlScheme = [NSString stringWithFormat:@"%@://", AppScheme];
    
    if ([type isEqualToString:@"channel_danger"]) {
        return [NSString stringWithFormat:@"%@%@?msgId=%@", urlScheme, @"JHTMsgDetailViewController", targetId];
    } else if ([type isEqualToString:@"water_line"]) {
        return [NSString stringWithFormat:@"%@%@?msgId=%@", urlScheme, @"JHTMsgDetailViewController", targetId];
    } else if ([type isEqualToString:@"xianqing"]) {
        return [NSString stringWithFormat:@"%@%@?msgId=%@", urlScheme, @"JHTMsgDetailViewController", targetId];
    } else if ([type isEqualToString:@"sys_notice"]) {
        return [NSString stringWithFormat:@"%@%@?tongid=%@", urlScheme, @"JHTTongZhiXiangQingViewController", targetId];
    } else if ([type isEqualToString:@"juli_mudiport"]) {
        NSString *pagejuli = [userInfo objectForKey: @"page"];
        if(pagejuli && pagejuli.length>0){
            if([pagejuli isEqualToString:@"up_status"]){
                return [NSString stringWithFormat:@"%@%@?yundanId=%@", urlScheme, @"JHTHangyunGenzongShipStatusViewController", targetId];
            }else if([pagejuli isEqualToString:@"yundan_manage"]){
                return [NSString stringWithFormat:@"%@%@?orderId=%@&readCanEditFromServer=1&readCanPaichuanFromServer=1", urlScheme, @"JHTHangyunGenzongViewController", targetId];
            }
        }else{
            return [NSString stringWithFormat:@"%@%@?rizhiId=%@", urlScheme, @"JHTHangyunGenzongLocationViewController", targetId];
        }
    } else if ([type isEqualToString:@"juli_zhuangzaiport"]) {
        NSString *pagejuli = [userInfo objectForKey: @"page"];
        if(pagejuli && pagejuli.length>0){
            if([pagejuli isEqualToString:@"up_status"]){
                return [NSString stringWithFormat:@"%@%@?yundanId=%@", urlScheme, @"JHTHangyunGenzongShipStatusViewController", targetId];
            }else if([pagejuli isEqualToString:@"yundan_manage"]){
                return [NSString stringWithFormat:@"%@%@?orderId=%@&readCanEditFromServer=1&readCanPaichuanFromServer=1", urlScheme, @"JHTHangyunGenzongViewController", targetId];
            }
        }else{
            return [NSString stringWithFormat:@"%@%@?rizhiId=%@", urlScheme, @"JHTHangyunGenzongLocationViewController", targetId];
        } 
    } else if ([type isEqualToString:@"fabu_ship_bid"] || [type isEqualToString:@"cancel_ship_bid"]) {
        return [NSString stringWithFormat:@"%@%@?chuanbiaoId=%@", urlScheme, @"JHTChuanbiaoDetailViewController", targetId];
    } else if ([type isEqualToString:@"fabu_goods_bid"] || [type isEqualToString:@"cancel_goods_bid"]) {
        return [NSString stringWithFormat:@"%@%@?huobiaoId=%@", urlScheme, @"JHTHuobiaoDetailViewController", targetId];
    } else if ([type isEqualToString:@"join_goods_bid"]) {
        return [NSString stringWithFormat:@"%@%@?huobiaoId=%@", urlScheme, @"JHTXuanZeZhongBiaoChuanPanViewController", targetId];
    } else if ([type isEqualToString:@"join_ship_bid"]) {
        return [NSString stringWithFormat:@"%@%@?chuanbiaoId=%@", urlScheme, @"JHTXuanZeZhongBiaoHuoPanViewController", targetId];
    } else if ([type isEqualToString:@"win_ship_bid"]) {
        return [NSString stringWithFormat:@"%@%@?dingdanid=%@", urlScheme, @"JHTWoDeDingDanXiangQingViewController", targetId];
    } else if ([type isEqualToString:@"win_goods_bid"]) {
        return [NSString stringWithFormat:@"%@%@?dingdanid=%@", urlScheme, @"JHTWoDeDingDanXiangQingViewController", targetId];
    } else if ([type isEqualToString:@"send_ship"]) {
        return [NSString stringWithFormat:@"%@%@?rizhiId=%@", urlScheme, @"JHTHangyunGenzongLocationViewController", targetId];
    } else if ([type isEqualToString:@"goods_receive"]) {
        return [NSString stringWithFormat:@"%@%@?dingdanid=%@", urlScheme, @"JHTWoDeDingDanXiangQingViewController", targetId];
    } else if ([type isEqualToString:@"ship_receive"]) {
        return [NSString stringWithFormat:@"%@%@?dingdanid=%@", urlScheme, @"JHTWoDeDingDanXiangQingViewController", targetId];
    } else if ([type isEqualToString:@"both_receive"]) {
        return [NSString stringWithFormat:@"%@%@?dingdanid=%@", urlScheme, @"JHTWoDeDingDanXiangQingViewController", targetId];
    } else if ([type isEqualToString:@"order_create"]) {
        NSString *load_port = [userInfo objectForKey: @"load_port"];
        NSString *unload_port = [userInfo objectForKey: @"unload_port"];
        return [NSString stringWithFormat:@"%@%@?queryPortIds=%@,%@", urlScheme, @"JHTTianQiViewController", load_port, unload_port];
    } else if ([type isEqualToString:@"status_change"]) {
        return [NSString stringWithFormat:@"%@%@?orderId=%@&readCanEditFromServer=1&readCanPaichuanFromServer=1", urlScheme, @"JHTHangyunGenzongViewController", targetId];
    } else if ([type isEqualToString:@"create_bill_data"]) {
        return [NSString stringWithFormat:@"%@%@?rizhiId=%@", urlScheme, @"JHTRizhiDetailViewController", targetId];
    } else if ([type isEqualToString:@"unusual_stop"]) {
        return [NSString stringWithFormat:@"%@%@?orderId=%@&readCanEditFromServer=1&readCanPaichuanFromServer=1", urlScheme, @"JHTHangyunGenzongViewController", targetId];
    } else if ([type isEqualToString:@"apply_bind_ship_pass"]) {
        return [NSString stringWithFormat:@"%@%@?detilid=%@", urlScheme, @"JHTChuanBoXiangQingViewController",targetId];
    } else if ([type isEqualToString:@"apply_bind_ship_unpass"]) {
        return [NSString stringWithFormat:@"%@%@?gotoWeirenzheng=1", urlScheme, @"JHTWoDeChuanBoViewController"];
    } else if ([type isEqualToString:@"confirm_load_date"]) {
        return [NSString stringWithFormat:@"%@%@?dingdanid=%@", urlScheme, @"JHTWoDeDingDanXiangQingViewController",targetId];
    } else if ([type isEqualToString:@"update_load_date"]) {
        return [NSString stringWithFormat:@"%@%@?dingdanid=%@", urlScheme, @"JHTWoDeDingDanXiangQingViewController",targetId];
    } else if ([type isEqualToString:@"order_detail"]) {
        return [NSString stringWithFormat:@"%@%@?dingdanid=%@", urlScheme, @"JHTWoDeDingDanXiangQingViewController", targetId];
    }
    return  nil;
}



+(NSString *)countNumAndChangeformat:(NSString *)num{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)    {
        count++;        a /= 10;    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}
+ (NSString *)roundUp:(float)number afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:number];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

+ (NSMutableAttributedString*) buildAttrString:(NSString*) fullText regex:(NSString*) regex regexFont:(UIFont*) font regexColor:(UIColor*) color offsetBefore:(int) offsetBefore offsetAfter:(int) offsetAfter {
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc]initWithString: fullText];
    NSRange range = [fullText rangeOfString:regex options:NSRegularExpressionSearch];
    if (range.location == NSNotFound) {
        return result;
    }
    if (offsetBefore < 0) {
        if((long)range.location + offsetBefore > 0) {
            range.location = range.location + offsetBefore;
        }
    } else if (offsetBefore > 0) {
        if ((long)range.location - offsetBefore < fullText.length) {
            range.location = range.location - offsetBefore;
        }
    }
    if (offsetAfter != 0) {
        if ((long)(range.location + range.length + offsetAfter) <= fullText.length) {
            if (offsetAfter < 0 && -offsetAfter > range.length) {
            } else {
                range.length = range.length + offsetAfter;
            }
        }
    }
    [result addAttribute:NSFontAttributeName value:font range:range];
    [result addAttribute:NSForegroundColorAttributeName value:color range:range];
    return result;
}

+ (void)systemDialing:(NSString *)value {
    [[JHTUserModel sharedInstance] getContactInfo:^(JHTUserContact *userContact) {
        [ProgressHUD dismiss];
        NSString *from = userContact?userContact.mobile:[JHTUserModel sharedInstance].currentUser.userId;
        NSString *desc = [NSString stringWithFormat:@"[%@]%@-%@", [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"], from, value];
        [MobClick event:@"begin_dial" attributes: @{@"desc": desc, @"to": value, @"from": from}];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",value ]]];
    } beginRequestNet:^{
        [ProgressHUD show:@"请稍后..." Interaction: NO];
    }];
//    [MobClick event:@"tel" attributes: @{@"TEST":(APPTEST?@"YES":@"NO"), @"type":value, @"desc": desc, @"targetTel": value}];
}
+ (void)sendMessage:(NSString *)value {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",value]]];
}
+ (BOOL)validateIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length =0;
    if (!value) {
        return NO;
    }else {
        length=[[NSString stringWithFormat:@"%lu",(unsigned long)value.length] intValue];
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [[value substringWithRange:NSMakeRange(6,2)] intValue] +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            //            [regularExpression release];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            //            [regularExpression release];
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}

+ (BOOL)textField:(UITextField *)textField shouldChangeZuoji:(NSRange)range replacementString:(NSString *)string {
    NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    
    string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        
        return NO;
        
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    
    text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSMutableString *temString = [NSMutableString stringWithString:text];
    if ([text isMatch:RX(@"^(010|021|022|023|024|025|026|027|028|029|020|852).+")]) {
        [temString insertString:@"-" atIndex: 3];
    } else if ([text isMatch:RX(@"^((0[3-9][1-9]{2})|(0[3−9][1−9]2)).+")]) {
        [temString insertString:@"-" atIndex: 4];
    }
    
    if (temString.length >= 13) {
        
        return NO;
        
    }
    [textField setText:temString];
    
    return NO;
    
}


+ (void) autoHeightLabel:(UILabel*) label maxSize:(CGSize) size {
    CGRect labelsize = [label.text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:label.font forKey:NSFontAttributeName] context:nil];
    [label setNumberOfLines:0];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [label setW:labelsize.size.width andH:labelsize.size.height];
}

+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = VALREG_MOBILE_PHONE;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}


+ (NSData*) zipImage:(UIImage*) image maxSize:(double) byteSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    
    while ([imageData length] > byteSize && compression > maxCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    return imageData;
}

+ (id) getImageFromItem:(id) item ori:(BOOL) ori {
    UIImage *image = nil;
    if ([item isKindOfClass: [UIImage class]]) {
        image = item;
    } else if ([item isKindOfClass: [ALAsset class]]) {
        if (ori) {
            image = [UIImage imageWithCGImage:[[((ALAsset*) item) defaultRepresentation] fullResolutionImage]];
        } else {
            image = [UIImage imageWithCGImage:((ALAsset*) item).thumbnail];
        }
    } else if ([item isKindOfClass: [NSString class]]){
        return item;
    } else {}
    return image;
}

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}
+ (UIImage*) getHeaderImage:(UIImage*) image toSize:(CGSize) size {
    
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    
    if (image.size.width <= image.size.height) {
        float widthScale = size.width / image.size.width;
        float h = image.size.height*widthScale;
        float y = 0 - (h - size.height)/2.f;
        
        [image drawInRect:CGRectMake(0, y, size.width, h)];
    } else {
        float heightScale = size.height / image.size.height;
        float w = image.size.width * heightScale;
        float x = 0 - (w - size.width)/2.f;
        [image drawInRect:CGRectMake(x, 0, w, size.height)];
    }
    
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

+ (UIImage *)reSizeImage:(UIImage *)image maxSize:(CGSize)maxSize {
    if ([image isKindOfClass:[NSString class]]) {
        return image;
    }
    double oldWidth = image.size.width;
    double oldHeight = image.size.height;
    
    double scale = 1.0;
    if (oldWidth > oldHeight && oldWidth > maxSize.width) {
        scale = maxSize.width / oldWidth;
    } else if (oldHeight > oldWidth && oldHeight > maxSize.height) {
        scale = maxSize.height / oldHeight;
    }
    if (scale == 1.0) {
        return image;
    }
    double newWidth = oldWidth * scale;
    double newHeight = oldHeight * scale;
    
    return [CommonUtils reSizeImage:image toSize: CGSizeMake(newWidth, newHeight)];
}
+ (BOOL) BOOLValueFromDictionary:(NSDictionary*) dictionary key:(NSString*) key {
    id value = [dictionary objectForKey: key];
    if (value == nil || value == [NSNull null]) {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *valueNum = (NSNumber*) value;
        return valueNum.boolValue;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSString *upper = [value uppercaseString];
        if ([upper isEqualToString: @"1"]) {
            return YES;
        } else if ([upper isEqualToString: @"0"]) {
            return NO;
        } else if ([upper isEqualToString: @"YES"]) {
            return YES;
        } else if ([upper isEqualToString:@"NO"]) {
            return NO;
        } else if ([upper isEqualToString: @"yes"]) {
            return YES;
        } else if ([upper isEqualToString:@"no"]) {
            return NO;
        } else if ([upper isEqualToString:@"TRUE"]) {
            return YES;
        } else if ([upper isEqualToString:@"FALSE"]) {
            return NO;
        } else if ([upper isEqualToString:@"true"]) {
            return YES;
        } else if ([upper isEqualToString:@"false"]) {
            return NO;
        }
    }
    return NO;
}
+ (NSNumber*) numValueFromDictionary:(NSDictionary*) dictionary key:(NSString*) key valueIfNil:(NSNumber*) valueIfNil {
    if (dictionary == nil) {
        return valueIfNil;
    }
    if(![dictionary isKindOfClass:[NSDictionary class]]){
        return valueIfNil;
    }
    id value = [dictionary objectForKey: key];
    if (value == nil || value == [NSNull null] || ([value isKindOfClass:[NSString class]] && [value isEmpty])) {
        return valueIfNil;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        if ([value isEmpty]) {
            return nil;
        }
    }
    return [NSNumber numberWithDouble:[NSString stringWithFormat:@"%@", value].doubleValue];
}
+ (NSString*) strValueFromDictionary:(NSDictionary*) dictionary key:(NSString*) key valueIfNil:(NSString*) valueIfNil {
    if (dictionary == nil) {
        return valueIfNil;
    }
    if(![dictionary isKindOfClass:[NSDictionary class]]){
        return valueIfNil;
    }
    id value = [dictionary objectForKey: key];
    if (value == nil || value == [NSNull null] || ([value isKindOfClass:[NSString class]] && [value isEmpty])) {
        return (valueIfNil?:@"");
    }
    return [NSString stringWithFormat:@"%@", value];
}
+ (NSString*) price2ValueFromDictionary:(NSDictionary*) dictionary keyMin:(NSString*) keyMin keyMax:(NSString*) keyMax {
    NSString *priceMin = PriceFromDictionary(dictionary, keyMin);
    NSString *priceMax = PriceFromDictionary(dictionary, keyMax);
    NSString *price = nil;
    if ([priceMax isEqualToString:@"0"] && [priceMin isEqualToString:@"0"]) {
        price = @"不限";
    } else {
        price = [NSString stringWithFormat:@"%@－%@",
                 ([priceMin isEqualToString:@"0"]?@"不限":[@"¥" stringByAppendingString: priceMin]),
                 ([priceMax isEqualToString:@"0"]?@"不限":[@"¥" stringByAppendingString: priceMax])];
    }
    return price;
}
+ (NSString*) priceValueFromDictionary:(NSDictionary*) dictionary key:(NSString*) key {
    id value = [dictionary objectForKey: key];
    if (value == nil || value == [NSNull null]) {
        return @"0";
    }
    double oriPrice = 0;
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        oriPrice = ((NSString*)value).doubleValue;
    }
    
    NSString *priceOri = [CommonUtils roundUp:(oriPrice/100.0) afterPoint:2];
    return [CommonUtils countNumAndChangeformat: priceOri];
}
+ (NSString*) noPointpriceValueFromDictionary:(NSDictionary*) dictionary key:(NSString*) key {
    id value = [dictionary objectForKey: key];
    if (value == nil || value == [NSNull null]) {
        return @"0";
    }
    double oriPrice = 0;
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        oriPrice = ((NSString*)value).doubleValue;
    }
    
    NSString *priceOri = [CommonUtils roundUp:(oriPrice/100.0) afterPoint:2];
    return priceOri;
}
+ (NSString*) priceFormatValueFromDictionary:(NSDictionary*) dictionary key:(NSString*) key {
    return [CommonUtils countNumAndChangeformat: [CommonUtils priceFormatValueFromDictionary:dictionary key:key]];
}

+ (UIViewController*) getLastTargetViewController:(Class) klazz fromNavigationController:(UINavigationController*) nav {
    NSArray *viewControllers = nav.childViewControllers;
    if (nav == nil || viewControllers.count == 0) {
        return nil;
    }
    for (long i = viewControllers.count - 1; i >=0 ; i--) {
        UIViewController *controller = [viewControllers objectAtIndex: i];
        if ([controller isKindOfClass:klazz]) {
            return controller;
        }
    }
    return nil;
}

+ (UINavigationController*) setNavigationControllerStyle:(UINavigationController*) nav {
//    nav.navigationBar.translucent = NO;
    nav.navigationBar.barTintColor = COL_BLUE_NAV;
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:COL_TEXT_GREEN_WHITE,NSForegroundColorAttributeName,nil];
    [nav.navigationBar setTitleTextAttributes:attributes];
    nav.navigationBar.tintColor = COL_TEXT_GREEN_WHITE;
    
    // 透明度设置为0.3
    nav.navigationBar.alpha = 0.300;
    // 设置为半透明
    nav.navigationBar.translucent = YES;
    nav.navigationBar.opaque = YES;
    return nav;
}

+ (BOOL)isVersion:(NSString*)versionA biggerThanVersion:(NSString*)versionB
{
    NSArray *arrayNow = [versionB componentsSeparatedByString:@"."];
    NSArray *arrayNew = [versionA componentsSeparatedByString:@"."];
    BOOL isBigger = NO;
    NSInteger i = arrayNew.count > arrayNow.count? arrayNow.count : arrayNew.count;
    NSInteger j = 0;
    BOOL hasResult = NO;
    for (j = 0; j < i; j ++) {
        NSString* strNew = [arrayNew objectAtIndex:j];
        NSString* strNow = [arrayNow objectAtIndex:j];
        if ([strNew integerValue] > [strNow integerValue]) {
            hasResult = YES;
            isBigger = YES;
            break;
        }
        if ([strNew integerValue] < [strNow integerValue]) {
            hasResult = YES;
            isBigger = NO;
            break;
        }
    }
    if (!hasResult) {
        if (arrayNew.count > arrayNow.count) {
            NSInteger nTmp = 0;
            NSInteger k = 0;
            for (k = arrayNow.count; k < arrayNew.count; k++) { 
                nTmp += [[arrayNew objectAtIndex:k]integerValue]; 
            } 
            if (nTmp > 0) { 
                isBigger = YES; 
            } 
        } 
    } 
    return isBigger; 
}



+ (NSString *)base64StringFromText:(NSString *)text
{
    if (text && ![text isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY  改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin  改动了此处
        //data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else {
        return LocalStr_None;
    }
}

+ (NSString *)textFromBase64String:(NSString *)base64
{
    if (base64 && ![base64 isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY   改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [self dataWithBase64EncodedString:base64];
        //IOS 自带DES解密 Begin    改动了此处
        //data = [self DESDecrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return LocalStr_None;
    }
}

/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}
// 将JSON串转化为字典或者数组
+ (id)toArrayOrNSDictionary:(NSData *)jsonData{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}

/******************************************************************************
 函数名称 : + (NSData *)dataWithBase64EncodedString:(NSString *)string
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 :
 ******************************************************************************/
+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

/******************************************************************************
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

+(NSString *)LunarForSolar:(NSDate *)solarDate{
    //天干名称
    NSArray *cTianGan = [NSArray arrayWithObjects:@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸", nil];
    
    //地支名称
    NSArray *cDiZhi = [NSArray arrayWithObjects:@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",nil];
    
    //属相名称
    NSArray *cShuXiang = [NSArray arrayWithObjects:@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪",nil];
    
    //农历日期名
    NSArray *cDayName = [NSArray arrayWithObjects:@"*",@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",
                         @"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",
                         @"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十",nil];
    
    //农历月份名
    NSArray *cMonName = [NSArray arrayWithObjects:@"*",@"正",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"腊",nil];
    
    //公历每月前面的天数
    const int wMonthAdd[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
    
    //农历数据
    const int wNongliData[100] = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
        ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
        ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
        ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
        ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
        ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
        ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
        ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
        ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
        ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877};
    
    static int wCurYear,wCurMonth,wCurDay;
    static int nTheDate,nIsEnd,m,k,n,i,nBit;
    
    //取当前公历年、月、日
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit |NSMonthCalendarUnit | NSYearCalendarUnit fromDate:solarDate];
    wCurYear = (int)[components year];
    wCurMonth = (int)[components month];
    wCurDay = (int)[components day];
    
    //计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)
    nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38;
    if((!(wCurYear % 4)) && (wCurMonth > 2))
        nTheDate = nTheDate + 1;
    
    //计算农历天干、地支、月、日
    nIsEnd = 0;
    m = 0;
    while(nIsEnd != 1)
    {
        if(wNongliData[m] < 4095)
            k = 11;
        else
            k = 12;
        n = k;
        while(n>=0)
        {
            //获取wNongliData(m)的第n个二进制位的值
            nBit = wNongliData[m];
            for(i=1;i<n+1;i++)
                nBit = nBit/2;
            
            nBit = nBit % 2;
            
            if (nTheDate <= (29 + nBit))
            {
                nIsEnd = 1;
                break;
            }
            
            nTheDate = nTheDate - 29 - nBit;
            n = n - 1;
        }
        if(nIsEnd)
            break;
        m = m + 1;
    }
    wCurYear = 1921 + m;
    wCurMonth = k - n + 1;
    wCurDay = nTheDate;
    if (k == 12)
    {
        if (wCurMonth == wNongliData[m] / 65536 + 1)
            wCurMonth = 1 - wCurMonth;
        else if (wCurMonth > wNongliData[m] / 65536 + 1)
            wCurMonth = wCurMonth - 1;
    }
    
    //生成农历天干、地支、属相
    NSString *szShuXiang = (NSString *)[cShuXiang objectAtIndex:((wCurYear - 4) % 60) % 12];
    NSString *szNongli = [NSString stringWithFormat:@"(%@) %@%@年",szShuXiang, (NSString *)[cTianGan objectAtIndex:((wCurYear - 4) % 60) % 10],(NSString *)[cDiZhi objectAtIndex:((wCurYear - 4) % 60) %12]];
    
    //生成农历月、日
    NSString *szNongliDay;
    if (wCurMonth < 1){
        szNongliDay = [NSString stringWithFormat:@"闰%@",(NSString *)[cMonName objectAtIndex:-1 * wCurMonth]];
    }
    else{
        szNongliDay = (NSString *)[cMonName objectAtIndex:wCurMonth];
    }
    
    NSString *lunarDate = [NSString stringWithFormat:@"%@ %@月%@",szNongli,szNongliDay,(NSString*)[cDayName objectAtIndex:wCurDay]];
    
    return lunarDate;
}


+ (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//URLEncode
+(NSString*)encodeString:(NSString*)unencodedString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

//URLDEcode
+(NSString *)decodeString:(NSString*)encodedString

{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}
@end
