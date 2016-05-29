//
//  DoAlertView.h
//  TestAlert
//
//  Created by Donobono on 2013. 12. 19..
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CustomRowView.h"

#define DO_RGB(r, g, b)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define DO_RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// color set 1
//#define DO_TITLE_BOX                DO_RGB(113, 208, 243)
//#define DO_NORMAL_BOX               DO_RGB(57, 185, 238)
//#define DO_BUTTON_BOX               DO_RGB(113, 208, 243)
//#define DO_DESTRUCTIVE_BOX          DO_RGB(235, 15, 93)
//#define DO_TEXT_COLOR               DO_RGB(255, 255, 255)
//#define DO_DESTRUCTIVE_TEXT_COLOR   DO_RGB(255, 255, 255)
//#define DO_DIMMED_COLOR             DO_RGBA(0, 0, 0, 0.7)

// color set 2
#define DO_TITLE_BOX                COL_BLUE_NAV
#define DO_NORMAL_BOX               DO_RGB(255, 255, 255)
#define DO_BUTTON_BOX               UIColorFromRGB(0xf3f3f3)
#define DO_DESTRUCTIVE_BOX          DO_RGB(255, 255, 255)
#define DO_TEXT_COLOR               UIColorFromRGB(0x444444)
#define DO_DESTRUCTIVE_TEXT_COLOR   UIColorFromRGB(0x444444)
#define DO_DIMMED_COLOR             DO_RGBA(0, 0, 0, 0.7)
#define DO_TITLE_COLOR              DO_RGB(255, 255, 255)
#define DO_YES_COLOR                UIColorFromRGB(0x31a838)
#define DO_NO_COLOR                 UIColorFromRGB(0x9d9d9d)

// color set 3
//#define DO_TITLE_BOX                DO_RGB(213, 204, 181)
//#define DO_NORMAL_BOX               DO_RGB(236, 236, 236)
//#define DO_BUTTON_BOX               DO_RGB(83, 34, 54)
//#define DO_DESTRUCTIVE_BOX          DO_RGB(193, 40, 66)
//#define DO_TEXT_COLOR               DO_RGB(83, 34, 54)
//#define DO_DESTRUCTIVE_TEXT_COLOR   DO_RGB(236, 236, 236)
//#define DO_DIMMED_COLOR             DO_RGBA(0, 0, 0, 0.7)

#define DO_TEXT_FONT        [UIFont systemFontOfSize: 16.0]
#define DO_BOLD_FONT        [UIFont systemFontOfSize: 16.0]

#define DO_LABEL_INSET      UIEdgeInsetsMake(30, 10, 30, 10)
#define DO_TITLE_INSET      UIEdgeInsetsMake(13, 10, 13, 10)
#define DO_VIEW_WIDTH       (SCREEN_WIDTH - 25*2)

#define DO_YES_TAG          100
#define DO_NO_TAG           200

#define DO_ROUND            3

typedef NS_ENUM(int, DoAlertViewTransitionStyle) {
    DoTransitionStyleTopDown = 0,
    DoTransitionStyleBottomUp,
    DoTransitionStyleFade,
    DoTransitionStylePop,
    DoTransitionStyleLine,
};

typedef NS_ENUM(int, DoAlertViewContentType) {
    DoContentNone = 0,
    DoContentImage,
    DoContentMap,
};

@class DoAlertView;
typedef void(^DoAlertViewHandler)(DoAlertView *alertView);
typedef void(^DoAlertBtnHandler)(NSInteger alertBtn);

@interface DoAlertView : UIView <MKMapViewDelegate>
{
@private
    NSString                *_strAlertTitle;
    NSString                *_strAlertBody;
    NSString                *_strYesBtn;
    NSString                *_strNoBtn;
    BOOL                    _bNeedNo;

    DoAlertViewHandler      _doYes;
    DoAlertViewHandler      _doNo;
    DoAlertViewHandler      _doDone;
    DoAlertBtnHandler      _docustom;

    UIWindow                *_alertWindow;
    UIView                  *_vAlert;
    UIView                  *_bodyView;
    NSArray                 *_btnArray;
}

@property (readwrite)   int         nAnimationType;
@property (readwrite)   int         nContentMode;

@property (readwrite)   double      dRound;
@property (readwrite)   BOOL        bDestructive;

@property (readonly)    int         nTag;

// add content
// for UIImageView
@property (nonatomic, strong)   UIImage         *iImage;
// for Map view
@property (nonatomic, strong)   NSDictionary    *dLocation; // latitude, longitude
- (void)doYesNo:(NSArray*)btnArray title:(NSString *)strTitle
       customdo:(DoAlertBtnHandler)docustom;
// With Title, Alert body, Yes button, No button,Yes button and label, No button and label
- (void)doYesNo:(NSString *)strTitle
        bodyStr:(NSString *)strBody
         yesBtn:(NSString *)strYesBtn
          noBtn:(NSString *)strNoBtn
            yes:(DoAlertViewHandler)yes
             no:(DoAlertViewHandler)no;

// With more NSMutableArray, Multi line button
- (void)doYesNo:(NSArray*)btnArray
       customdo:(DoAlertBtnHandler)docustom;

// With Title, Alert bodyView, Yes button and label, No button and label
- (void)doYesNo:(NSString *)strTitle
           body:(UIView *)bodyView
         yesBtn:(NSString *)strYesBtn
          noBtn:(NSString *)strNoBtn
            yes:(DoAlertViewHandler)yes
             no:(DoAlertViewHandler)no;

// With Title, Alert body, Yes button, No button
- (void)doYesNo:(NSString *)strTitle
           body:(NSString *)strBody
            yes:(DoAlertViewHandler)yes
             no:(DoAlertViewHandler)no;

// With Alert body, Yes button, No button
- (void)doYesNo:(NSString *)strBody
            yes:(DoAlertViewHandler)yes
             no:(DoAlertViewHandler)no;

// With Title, Alert body, Only yes button
- (void)doYes:(NSString *)strTitle
         body:(NSString *)strBody
          yes:(DoAlertViewHandler)yes;

// With Alert body, Only yes button
- (void)doYes:(NSString *)strBody
          yes:(DoAlertViewHandler)yes;

// Without any button
- (void)doAlert:(NSString *)strTitle
           body:(NSString *)strBody
       duration:(double)dDuration
           done:(DoAlertViewHandler)done;
- (void)hideAlert;
- (void)hideAlertView;
@end
