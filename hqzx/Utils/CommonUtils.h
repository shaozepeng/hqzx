//
//  CommonUtils.h
//  shenzhenwujing
//
//  Created by sunzsh on 15/2/4.
//  Copyright (c) 2015年 51haobaby. All rights reserved.
//

//static const NSString *URLScheme = @"jianghai56://";

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCrypto.h>
#import "HQZXCommDef.h"
#import <CTAssetsPickerController.h>
#import <AssetsLibrary/ALAsset.h>
#define __BASE64( text )        [CommonUtils base64StringFromText:text]
#define __TEXT( base64 )        [CommonUtils textFromBase64String:base64]

#define countryKey @"country.plist"
#define datamd5Key @"data_md5"

//空字符串
#define     LocalStr_None           @""

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@interface CommonUtils : NSObject

/**
 * rect:位置、尺寸信息，当宽/高等于CGFLOAT_DEFINED时为图片的尺寸
 */
+ (UIView*) createHalfXing:(CGRect) rect floatValue:(float) value;

+ (NSDictionary*)dictionaryFromQuery:(NSString*)query usingEncoding:(NSStringEncoding)encoding;
+ (NSString*) securityPasswd:(NSString*) pwd;

+ (void) addUMengAlias:(NSString*) value type:(NSString*) type startFromTime:(int) i;
+ (void) removeUMengAlias:(NSString*) value type:(NSString*) type startFromTime:(int) i;

+ (BOOL) setParameterValue:(NSString*) value key:(NSString*) key target:(NSObject*) target;
+ (void) openUrl:(NSString*) url;

+ (void) gotoPushMsgWithUserInfo:(NSDictionary*) userInfo;

+ (NSString*) getUrlByType:(NSString*) type targetId:(NSString*) targetId userInfo:(NSDictionary*) userInfo;

+(NSString *)countNumAndChangeformat:(NSString *)num;

+ (NSString *)roundUp:(float)number afterPoint:(int)position;

+ (NSMutableAttributedString*) buildAttrString:(NSString*) fullText regex:(NSString*) regex regexFont:(UIFont*) font regexColor:(UIColor*) color offsetBefore:(int) offsetBefore offsetAfter:(int) offsetAfter;
//系统拨号
+ (void)systemDialing:(NSString *)value;
//系统发短信
+ (void)sendMessage:(NSString *)value;

+ (BOOL)validateIDCardNumber:(NSString *)value;

+ (BOOL)textField:(UITextField *)textField shouldChangeZuoji:(NSRange)range replacementString:(NSString *)string;
+ (void) autoHeightLabel:(UILabel*) label maxSize:(CGSize) size;

+ (BOOL)checkTelNumber:(NSString *) telNumber;

+ (UINavigationController*) setNavigationControllerStyle:(UINavigationController*) nav;

+ (BOOL)isVersion:(NSString*)versionA biggerThanVersion:(NSString*)versionB;

+ (id)toArrayOrNSDictionary:(NSData *)jsonData;

+ (id) getImageFromItem:(id) item ori:(BOOL) ori;
+ (NSData*) zipImage:(UIImage*) image maxSize:(double) byteSize;

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
+ (UIImage *)reSizeImage:(UIImage *)image maxSize:(CGSize)maxSize;

+ (UIImage*) getHeaderImage:(UIImage*) image toSize:(CGSize) size;

+ (UIViewController*) getLastTargetViewController:(Class) klazz fromNavigationController:(UINavigationController*) nav;

+ (BOOL) BOOLValueFromDictionary:(NSDictionary*) dictionary key:(NSString*) key;
+ (NSString*) strValueFromDictionary:(NSDictionary*) dictionary key:(NSString*) key valueIfNil:(NSString*) valueIfNil;

+ (NSNumber*) numValueFromDictionary:(NSDictionary*) dictionary key:(NSString*) key valueIfNil:(NSNumber*) valueIfNil;


+ (NSString*) price2ValueFromDictionary:(NSDictionary*) dictionary keyMin:(NSString*) keyMin keyMax:(NSString*) keyMax;
+ (NSString*) priceValueFromDictionary:(NSDictionary*) dictionary key:(NSString*) key;
+ (NSString*) noPointpriceValueFromDictionary:(NSDictionary*) dictionary key:(NSString*) key;
/******************************************************************************
 函数名称 : + (NSString *)base64StringFromText:(NSString *)text
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)text    文本
 输出参数 : N/A
 返回参数 : (NSString *)    base64格式字符串
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64StringFromText:(NSString *)text;

/******************************************************************************
 函数名称 : + (NSString *)textFromBase64String:(NSString *)base64
 函数描述 : 将base64格式字符串转换为文本
 输入参数 : (NSString *)base64  base64格式字符串
 输出参数 : N/A
 返回参数 : (NSString *)    文本
 备注信息 :
 ******************************************************************************/
+ (NSString *)textFromBase64String:(NSString *)base64;


+ (NSString *)LunarForSolar:(NSDate *)solarDate;


+ (UIImage *) createImageWithColor: (UIColor *) color;


//URLEncode
+(NSString*)encodeString:(NSString*)unencodedString;

//URLDEcode
+(NSString *)decodeString:(NSString*)encodedString;
@end
