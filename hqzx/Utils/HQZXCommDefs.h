//
//  HQZXCommDefs.h
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/28.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define APPConfigString(_KEY) ((NSString*)[[[NSBundle mainBundle] infoDictionary] objectForKey: _KEY])

#define APPTEST (((NSNumber*)[[[NSBundle mainBundle] infoDictionary] objectForKey: @"APPPRODUCTION"]).boolValue)

#import <Foundation/Foundation.h>
#import "MacroDefinition.h"
#import "UIView+CBFrameHelpers.h"
#import "NSDate+Helper.h"
#import "AppDelegate.h"
#import "NSString+isEmpty.h"
#import "UIDevice+IdentifierAddition.h"
#import "RegExCategories.h"
#import <Toast/UIView+Toast.h>

#define TESTSTR(_TEST, _PRODUCT) (APPTEST?(_TEST):(_PRODUCT))
//#define ApiServer TESTSTR(@"test.api.jianghai56.com", @"api.jianghai56.com")
#define ApiServer TESTSTR(@"api.globalonline.cc",@"api.50f.cn")
#define ApiPicServer TESTSTR(@"api.globalonline.cc",@"http://coins.zhaojizi.com")

#define AppScheme  [[[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"] objectAtIndex:0] objectForKey: @"CFBundleURLSchemes"] objectAtIndex:0]
//#define ApiServer @"api.jianghai56.com"
//#define ApiServer @"139.196.21.95"
//#define ApiServer @"123.57.9.78"


static const double UP_IMG_MAX_SIZE = 1024 * 100;/**< 150 KB */

static const double UP_IMG_MAX_SIZE4HEADER = 1024 * 20;/**< 15 KB */

@interface HQZXCommDefs : NSObject
typedef void (^JHTDropSelected)(id value, NSString *label);
#define JHTDropSelected() ^void (id JHTDropValue, NSString *JHTDropLabel)

typedef void (^BlockVoid)();
typedef void (^BlockObject)(NSObject *obj);
typedef void (^BlockBool)(BOOL isBool);
typedef void (^BlockInteger)(NSInteger integer);
typedef void (^BlockDouble)(double d);
typedef void (^BlockString)(NSString *str);
typedef void (^BlockArray)(NSArray *array);

typedef void (^JHTDateBlock)(NSDate *date);
#define JHTDateBlock() ^void (NSDate *JHTDropValue)

typedef void (^Void_Block)(void);
#define Void_Block() ^void ()
typedef void (^Bool_Block)(BOOL value);
#define Bool_Block() ^void (BOOL value)
typedef void (^Int_Block)(NSInteger value);
#define Int_Block() ^void (NSInteger value)
typedef void (^Id_Block)(id obj);
#define Id_Block() ^void (id obj)
typedef BOOL (^GesRecognizer_Block)(UIGestureRecognizer*, UITouch*);

typedef void (^Float_Block)(float value);
#define Float_Block() ^void (float value)

typedef void (^Api_Page_Block)(NSString *nextId, NSArray *array);
#define Api_Page_Block() ^void (NSString *nextId, NSArray *array)


#define lastLoginUserNameKey @"Last_Login_UserName"

#define WEAK_SELF __weak typeof(self) weakself = self;
#define WEAK_INSTANCE(instance) __weak typeof(instance) weak##instance = instance;

#define WeixinAppId @"wxd0015b41d39bafb4"
#define WeixinSecret @"f97418a0cb7058c70aed5bbcb9472174"

//国际化
#define  LocatizedStirngForkey(key)     [[GDLocalizableController shareInstance] locatizedStringForkey:key]

//机型相关

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IP5ELSE(_IPHONE5, _OTHER) (IPhone5?_IPHONE5:_OTHER)//判断手机
#define IP4566PELSE(_IPHONE4, _IPHONE5,_IPHONE6,_IPHONE6P,_OTHER) (IS_IPHONE_6P?_IPHONE6P:IS_IPHONE_6?_IPHONE6:IS_IPHONE_5?_IPHONE5:IS_IPHONE_4_OR_LESS?_IPHONE4:_OTHER)//判断手机

// 友盟开发模式
#define UMengDevMode NO
/*****************************设备相关宏定义*********************************/

// 基本设备信息
#define STATUSBAR_HEIGHT                           20.f
#define TOP_HEIGHT          (NavigationBar_HEIGHT + STATUSBAR_HEIGHT)
#define SCREEN_SCALE         ([UIScreen            mainScreen].scale)

#define COMMON_H_MARGIN                            12.f
#define COMMON_V_GAP                               10.f
#define COMMON_H_GAP                               3.f

/*****************************使用到的颜色定义*****************************/
#define COL_BLUE            UIColorFromRGB(0x0292D3)
#define COL_BLUE_NAV        UIColorFromRGB(0x00a0ea)
#define COL_BLUE_DEEP        UIColorFromRGB(0x008fe9)
#define COL_HOME_GRAY        UIColorFromRGB(0xfafafa)
#define COL_HOME_GRAY_LINE   UIColorFromRGB(0xdfddde)
#define COL_HOME_PANEL_FONT  UIColorFromRGB(0x444444)
#define COL_GRAY_BG          UIColorFromRGB(0xFAFAFA)
#define  COL_2B               UIColorFromRGB(0x2b2b2b)
#define COL_GRAY_CB UIColorFromRGB(0xCBCBCD)
#define COL_GREEN UIColorFromRGB(0x2A9A63)
#define COL_GREEN2 UIColorFromRGB(0x38A63F)

#define TableHeaderBgColor   UIColorFromRGB(0xdfe1e3)
#define TableBgColor         UIColorFromRGB(0xEFEFF1)

#define COL_TEXT_GREEN_WHITE UIColorFromRGB(0xDCF3FC)

#define COL_TEXT_GRAY2 UIColorFromRGB(0xA5A5A5)
#define COL_TEXT_GRAY3 UIColorFromRGB(0x7A7A7A)
#define COL_TEXT_BLUE  UIColorFromRGB(0x1BA6FE)

#define COL_TEXT_6C  UIColorFromRGB(0x6C6C6C)
#define COL_TEXT_7DE UIColorFromRGB(0x7d7d7e)
#define COL_TEXT_33  UIColorFromRGB(0x333333)
/*
 * 字体
 * 18号字体：导航栏title
 * 16号字体：标题
 * 14号字体：正文
 * 12号字体：次要
 */
#define FONT_LIGHT(s)    {[UIFont systemFontOfSize:s];}
#define FONT_BOLD(s)     {[UIFont boldSystemFontOfSize:s];}

#define FONT_20             (FONT_LIGHT(20))
#define FONT_18             (FONT_LIGHT(18))
#define FONT_16             (FONT_LIGHT(16))
#define FONT_14             (FONT_LIGHT(14))
#define FONT_12             (FONT_LIGHT(12))
#define FONT_10             (FONT_LIGHT(10))

#define FONT_20B            (FONT_BOLD(20))
#define FONT_18B            (FONT_BOLD(18))
#define FONT_16B            (FONT_BOLD(16))
#define FONT_14B            (FONT_BOLD(14))
#define FONT_12B            (FONT_BOLD(12))
#define FONT_10B            (FONT_BOLD(10))



#define appDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define rootNav ((UINavigationController*)appDelegate.nav)


/*****************************使用到的正则表达式*****************************/
// 手机号
#define VALREG_MOBILE_PHONE @"^1[3578]\\d{9}$"
#define VALREG_TEL @"^([0-9]{3,4}-)?[0-9]{7,8}$"

/*****************************表单验证*****************************/

#define VALIDATE_NOT_NULL_ALERT(STRVALUE, MSG, _VIEW, ALERT_POSITION) if (STRVALUE == nil || [STRVALUE isEmpty]) { [_VIEW makeToast: MSG duration: 1.0 position:ALERT_POSITION]; return; }
#define VALIDATE_NOT_NULL(STRVALUE, MSG) VALIDATE_NOT_NULL_ALERT(STRVALUE, MSG, self.view, CSToastPositionCenter)

#define VALIDATE_NOT_NULL_ID(IDVALUE, MSG) if (IDVALUE == nil) { [self.view makeToast: MSG duration: 1.0 position:CSToastPositionCenter]; return; }

#define VALIDATE_REGEX_ALERT(STRVALUE, REGEX, MSG, _VIEW, ALERT_POSITION) if ([STRVALUE isMatch:RX(REGEX)] == NO) { [_VIEW makeToast: MSG duration: 1.0 position: ALERT_POSITION]; return; }

#define VALIDATE_REGEX(STRVALUE, REGEX, MSG) VALIDATE_REGEX_ALERT(STRVALUE, REGEX, MSG, self.view, CSToastPositionCenter)

#define VALIDATE_STR_IS_DECIMAL(STRVALUE, MSG) VALIDATE_REGEX(STRVALUE, @"^\\d+(\\.\\d+)?$", MSG)
//校验网址
#define VALIDATE_STR_IS_DECIMAL_URL(STRVALUE, MSG) VALIDATE_REGEX(STRVALUE, @"[a-zA-z]+://[^s]*", MSG)
#define VALIDATE_STR_IS_DECIMAL_IGNORE_SIGN(STRVALUE, MSG) VALIDATE_REGEX(STRVALUE, @"^(\\-|\\+)?\\d+(\\.\\d+)?$", MSG)
#define VALIDATE_STR_IS_NUMBER(STRVALUE, MSG) VALIDATE_REGEX(STRVALUE, @"^\\d+?$", MSG)
#define VALIDATE_STR_IS_NUMBER_IGNORE_SIGN(STRVALUE, MSG) VALIDATE_REGEX(STRVALUE, @"^(\\-|\\+)?(\\-?)\\d+?$", MSG)

#define VALIDATE_STR_IS_DECIMAL_ALERT(STRVALUE, MSG, _VIEW, _ALERT_POSITION) VALIDATE_REGEX_ALERT(STRVALUE, @"^\\d+(\\.\\d+)?$", MSG, _VIEW, _ALERT_POSITION)
#define VALIDATE_STR_IS_DECIMAL_IGNORE_SIGN_ALERT(STRVALUE, MSG, _VIEW, _ALERT_POSITION) VALIDATE_REGEX_ALERT(STRVALUE, @"^(\\-|\\+)?\\d+(\\.\\d+)?$", MSG, _VIEW, _ALERT_POSITION)
#define VALIDATE_STR_IS_NUMBER_ALERT(STRVALUE, MSG, _VIEW, _ALERT_POSITION) VALIDATE_REGEX_ALERT(STRVALUE, @"^\\d+?$", MSG, _VIEW, _ALERT_POSITION)
#define VALIDATE_STR_IS_NUMBER_IGNORE_SIGN_ALERT(STRVALUE, MSG, _VIEW, _ALERT_POSITION) VALIDATE_REGEX_ALERT(STRVALUE, @"^(\\-|\\+)?(\\-?)\\d+?$", MSG, _VIEW, _ALERT_POSITION)



/*****************************布局*****************************/
#define FORM_INPUT_MARGIN 10
#define STATIC_INPUT_WIDTH (SCREEN_WIDTH - COMMON_H_MARGIN * 2 - FORM_INPUT_MARGIN) / 2
#define STATIC_INPUT_HEIGHT 40

#define FORM_INPUT_LEFT(_VIEW) CGPointMake((_VIEW).maxX + FORM_INPUT_MARGIN, (_VIEW).y)
#define FORM_INPUT_BOTTOM(_VIEW) CGPointMake(COMMON_H_MARGIN, (_VIEW).maxY + 8)


/*****************************工具方法*****************************/
#define smallImg(_IMGURL) [_IMGURL stringByAppendingPathComponent:@"?imageView2/2/w/120/h/120"]
#define smallImg60(_IMGURL) [_IMGURL stringByAppendingPathComponent:@"?imageView2/2/w/60/h/60"]

#define JHTCalcStringSizeWithUIFont(_TEXT, _FONT) ([(_TEXT) sizeWithAttributes:@{NSFontAttributeName:(_FONT)}])
#define JHTCalcStringSizeWithFontSize(_TEXT, _FONTSIZE) (JHTCalcStringSizeWithUIFont(_TEXT, [UIFont systemFontOfSize:_FONTSIZE]))

#define JHTAttributedOffsetDecimal(_FULL_TEXT, _FONT, _COLOR, _OFFSET_BEFORE, _OFFSET_AFTER) [CommonUtils buildAttrString:(_FULL_TEXT) regex:@"(-?\\d((\\d)|(,))*)(\\.((\\d)|(,))+)?" regexFont: _FONT regexColor: _COLOR offsetBefore:(_OFFSET_BEFORE) offsetAfter:(_OFFSET_AFTER)]
#define JHTAttributedOffsetTextLong(_FULL_TEXT, _FONT, _COLOR, _OFFSET_BEFORE, _OFFSET_AFTER) [CommonUtils buildAttrString:(_FULL_TEXT) regex:@"-?\\d((\\d)|(,))*" regexFont: _FONT regexColor: _COLOR offsetBefore:(_OFFSET_BEFORE) offsetAfter:(_OFFSET_AFTER)]
#define JHTAttributedOffsetTextDate(_FULL_TEXT, _FONT, _COLOR, _OFFSET_BEFORE, _OFFSET_AFTER) [CommonUtils buildAttrString:(_FULL_TEXT) regex:@"\\d{4}(\\-|\\/|\\.)\\d{1,2}\\1\\d{1,2}" regexFont: _FONT regexColor: _COLOR offsetBefore:(_OFFSET_BEFORE) offsetAfter:(_OFFSET_AFTER)]


#define JHTAttributedTextDecimal(_FULL_TEXT, _FONT, _COLOR) JHTAttributedOffsetDecimal(_FULL_TEXT, _FONT, _COLOR, 0, 0)
#define JHTAttributedTextLong(_FULL_TEXT, _FONT, _COLOR) JHTAttributedOffsetTextLong(_FULL_TEXT, _FONT, _COLOR, 0, 0)
#define JHTAttributedTextDate(_FULL_TEXT, _FONT, _COLOR) JHTAttributedOffsetTextDate(_FULL_TEXT, _FONT, _COLOR, 0, 0)


#define JHTAttributedYellowLong(_FULL_TEXT, _LABLE) JHTAttributedTextLong(_FULL_TEXT, [UIFont systemFontOfSize: _LABLE.font.pointSize*1.25], UIColorFromRGB(0xFC5300))
#define JHTAttributedYellowDecimal(_FULL_TEXT, _LABLE) JHTAttributedTextDecimal(_FULL_TEXT, [UIFont systemFontOfSize: _LABLE.font.pointSize*1.25], UIColorFromRGB(0xFC5300))
#define JHTAttributedYellowDate(_FULL_TEXT, _LABLE) JHTAttributedTextDate(_FULL_TEXT, [UIFont systemFontOfSize: _LABLE.font.pointSize*1.25], UIColorFromRGB(0xFC5300))

#define reLoadTableCell(TABLE, ROW, SECTION) [TABLE reloadRowsAtIndexPaths: [NSArray arrayWithObjects:[NSIndexPath indexPathForRow: ROW inSection: SECTION], nil] withRowAnimation:UITableViewRowAnimationNone]
#define NilToEmpty(VALUE_) (VALUE_?VALUE_:@"")
#define StrValue(DIC_, KEY_) (NilToEmpty([DIC_ objectForKey: KEY_]))

#define Bold_Font(FONT) ([UIFont boldSystemFontOfSize:FONT.pointSize])
#define Bold_Label(LABEL) (LABEL.font = Bold_Font(LABEL.font))


#define DeviceId [[UIDevice currentDevice] uuid]
#define DeviceType @"ios"
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey: @"CFBundleShortVersionString"]

#define ApiKey_ErrorCode @"ErrorCode"
#define ApiKey_Message @"message"

#define isEnable(_DIC, _KEY) [@"1" isEqualToString:[NSString stringWithFormat:@"%@",[_DIC objectForKey: _KEY]]]

#define ServerError(_OBJ, _VIEW) if (_OBJ == nil) { [_VIEW makeToast:@"连接服务器异常" duration:1.0 position: CSToastPositionCenter];return; }
#define ServerErrorWithBlock(_OBJ, _VIEW, _BLOCK) if (_OBJ == nil) { [_VIEW makeToast:@"连接服务器异常" duration:1.0 position: CSToastPositionCenter];if(_BLOCK){_BLOCK(nil);}return; }
#define ApiResultSuccess(_OBJ) [@"0" isEqualToString:[NSString stringWithFormat:@"%@", [_OBJ objectForKey: ApiKey_ErrorCode]]]
#define ApiResultMakToastIfErrorCallBack(_VIEW, _OBJ, _BLOCK) if (!ApiResultSuccess(_OBJ)) { [_VIEW makeToast:[_OBJ objectForKey:ApiKey_Message] duration: 1.0 position: CSToastPositionBottom]; if(_BLOCK){_BLOCK(nil);} return; }
#define ApiResultMakToastIfError(_VIEW, _OBJ) if (!ApiResultSuccess(_OBJ)) { [_VIEW makeToast:[_OBJ objectForKey:ApiKey_Message] duration: 1.0 position: CSToastPositionCenter]; return; }

#define ApiResultMakToastIfErrorCallBackPage(_VIEW, _OBJ, _BLOCK) if (!ApiResultSuccess(_OBJ)) { [_VIEW makeToast:[_OBJ objectForKey:ApiKey_Message] duration: 1.0 position: CSToastPositionBottom]; if(_BLOCK){_BLOCK(nil, nil);} return; }


#define BOOLValueFromDictionary(_DIC, _KEY) ([CommonUtils BOOLValueFromDictionary:_DIC key: _KEY])
#define StrValueFromDictionary(_DIC, _KEY) ([CommonUtils strValueFromDictionary:_DIC key: _KEY valueIfNil:nil])
#define NumValueFromDictionary(_DIC, _KEY) ([CommonUtils numValueFromDictionary:_DIC key: _KEY valueIfNil:nil])
#define StrValueFromDictionaryWithDefault(_DIC, _KEY, _DEFAULT) ([CommonUtils strValueFromDictionary:_DIC key: _KEY valueIfNil:_DEFAULT])
#define NumValueFromDictionaryWithDefault(_DIC, _KEY, _DEFAULT) ([CommonUtils numValueFromDictionary:_DIC key: _KEY valueIfNil:_DEFAULT])


#define Price2FromDictionary(_DIC, _KEYMIN, _KEYMAX) [CommonUtils price2ValueFromDictionary:_DIC keyMin:_KEYMIN keyMax:_KEYMAX]
//带，分割的钱数
#define PriceFromDictionary(_DIC, _KEY) [CommonUtils priceValueFromDictionary:_DIC key: _KEY]
//不带，分割的钱数
#define NoPointPriceFromDictionary(_DIC, _KEY) [CommonUtils noPointpriceValueFromDictionary:_DIC key: _KEY]

// 名字保留第一个字符，后面用*代替
#define MakeNameSecurity(_NAME) [[_NAME substringToIndex:1] stringByAppendingString: [@"" stringByPaddingToLength:_NAME.length - 1 withString:@"*" startingAtIndex:0]]

// 手机号中间4位*代替
#define MakeMobileSecurity(_MOBILE) [[[_MOBILE substringWithRange: NSMakeRange(0, (_MOBILE.length - 8))] stringByAppendingString: [@"" stringByPaddingToLength:_MOBILE.length - (_MOBILE.length - 8) - 4 withString:@"*" startingAtIndex:0]] stringByAppendingString: [_MOBILE substringFromIndex:(_MOBILE.length - 8) + 4]]

// 身份证号生日用*代替
#define MakeIDNOSecurity(_IDNO) [[[_IDNO substringWithRange: NSMakeRange(0, 3)] stringByAppendingString: [@"" stringByPaddingToLength:11 withString:@"*" startingAtIndex:0]] stringByAppendingString: [_IDNO substringFromIndex:14]]
@end
