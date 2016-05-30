//
//  CommonUtils.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/28.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "CommonUtils.h"
#import "NSString+MD5.h"


@implementation CommonUtils

+ (UINavigationController*) setNavigationControllerStyle:(UINavigationController*) nav {
    //    nav.navigationBar.translucent = NO;
    //顶部状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    nav.navigationBar.barTintColor = UIColorFromRGB(0x1D2228);
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:COL_TEXT_GREEN_WHITE,NSForegroundColorAttributeName,nil];
//    [nav.navigationBar setShadowImage:[UIImage Help_imageWithColor:[UIColor clearColor]]]
    [nav.navigationBar setTitleTextAttributes:attributes];
    nav.navigationBar.tintColor = COL_TEXT_GREEN_WHITE;
    // 透明度设置为0.3
    nav.navigationBar.alpha = 0.300;
    // 设置为半透明
    nav.navigationBar.translucent = YES;
    nav.navigationBar.opaque = YES;
//    nav.navigationBar.multipleTouchEnabled = YES;
    
//    [nav.navigationBar touchesBegan:nil withEvent:nil];
    return nav;
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
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = VALREG_MOBILE_PHONE;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}
+ (NSString*) securityPasswd:(NSString*) pwd {
    return [CommonUtils base64StringFromText: [[pwd MD5String] lowercaseString]];
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
@end
