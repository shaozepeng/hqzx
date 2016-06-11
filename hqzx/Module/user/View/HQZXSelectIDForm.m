//
//  JHTYaoQingGuanZhuForm.m
//  jht
//
//  Created by 泽鹏邵 on 15/11/9.
//  Copyright © 2015年 dhgh. All rights reserved.
//


#define JHTActionSheetLabel @"label"
#define JHTActionSheetToolBarHeight 44.0
#define JHTActionSheetMarginRL 2.5

#import "HQZXSelectIDForm.h"
#import <JHChainableAnimations.h>
//#import "JHTTextView.h"

#pragma mark - Controller
@interface HQZXSelectIDController : UIViewController
@property (nonatomic, strong) HQZXSelectIDForm *actionView;
@end

@implementation HQZXSelectIDController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view = _actionView;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [UIApplication sharedApplication].statusBarStyle;
}

@end
#pragma mark - View
@interface HQZXSelectIDForm() {
    UIWindow *actionWindow;
    UIView *selectView;
    NSString *placeHolderText;
    
    UITextField *txtXingming;
    UITextField *txtShouji;
    UITextView *txtMiaoshu;
    HQZXSelectIDController *actionSheetController;
    UIPickerView *mypickerView;
    NSMutableArray* aryCountrys;
    HQZXID *IDNew;
}
@end

@implementation HQZXSelectIDForm
- (instancetype)initWithPlaceHolder:(NSString*) placeHolder {
    self = [super init];
    if (self) {
        placeHolderText = placeHolder;
        _card = [[HQZXID alloc] init];
    }
    return self;
}


- (void) closeMe: (Void_Block) didClose {
    WEAK_SELF
    self.makeOpacity(0).animateWithCompletion(0, JHAnimationCompletion() {
        [weakself removeSubviews];
        [weakself removeFromSuperview];
        actionWindow.hidden = YES;
        actionWindow.rootViewController = nil;
        [actionWindow resignKeyWindow];
        [actionWindow removeFromSuperview];
        
        if (didClose) {
            didClose();
        }
    });
}

- (void) hideAction: (Void_Block) didClose  {
    selectView.makeY(SCREEN_HEIGHT).easeInQuad.animateWithCompletion(0.2, JHAnimationCompletion(){
        [self closeMe: didClose];
    });
}

- (IBAction)cancel:(id)sender {
    [self hideAction: nil];
}

- (IBAction)beSure:(id)sender {
    if(aryCountrys.count>0){
        if(!_card.card_name){
            _card = aryCountrys[0];
        }
    }else{
        return;
    }
    
    
    WEAK_SELF
    //    [self hideAction:Void_Block(){
    if (weakself.beSureComp) {
        weakself.beSureComp(_card);
    }
    //    }];
}

- (void) showAction{
    aryCountrys = [NSMutableArray array];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:countryKey];
    NSDictionary* dicPorts = [NSDictionary dictionaryWithContentsOfFile:filename];
    if(dicPorts.count>0){
        NSDictionary *allDict =[dicPorts objectForKey:@"config"];
        NSArray *cards = [allDict objectForKey:@"card_type_list"];
        for(NSDictionary *cardDic in cards){
            HQZXID *idCard = [[HQZXID alloc]init];
            idCard.card_id = StrValueFromDictionary(cardDic, @"id");
            idCard.card_name = StrValueFromDictionary(cardDic, @"name");
            idCard.card_ename = StrValueFromDictionary(cardDic, @"ename");
            [aryCountrys addObject:idCard];
        }
    }
    
    self.backgroundColor = DO_RGBA(0, 0, 0, 0.7);
    
    float viewHeight = STATIC_INPUT_HEIGHT * 2 + COMMON_H_MARGIN + JHTActionSheetToolBarHeight*2 + 60;
    
    UIButton *close = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - viewHeight)];
    [close addTarget: self action: @selector(cancel:) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: close];
    
    
    selectView = [[UIView alloc] initWithFrame: CGRectMake(JHTActionSheetMarginRL, SCREEN_HEIGHT, SCREEN_WIDTH - JHTActionSheetMarginRL*2, viewHeight + JHTActionSheetToolBarHeight + 200)];
    selectView.backgroundColor = UIColorFromRGB(0x293035);
    selectView.layer.masksToBounds = YES;
    selectView.layer.cornerRadius = 2;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, JHTActionSheetToolBarHeight)];
    [selectView addSubview: toolBar];
    toolBar.tintColor = COL_2B;
//    toolBar.backgroundColor = UIColorFromRGB(0x0C1319);
    
    [toolBar setBackgroundImage:[CommonUtils createImageWithColor: UIColorFromRGB(0x545454)] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCancel setTitleColor: UIColorFromRGB(0x46a9e6) forState: UIControlStateNormal];
    [btnCancel setTitleColor: UIColorFromRGB(0xbbbbbb) forState: UIControlStateHighlighted];
    [btnCancel setTitle:LocatizedStirngForkey(@"QUXIAO") forState:UIControlStateNormal];
    [btnCancel sizeToFit];
    [btnCancel addTarget: self action:@selector(cancel:) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *btnCancelItem = [[UIBarButtonItem alloc] initWithCustomView:btnCancel];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                           target:nil
                                                                           action:nil];
    UILabel *labelPlaceHoder = [[UILabel alloc] init];
    [labelPlaceHoder setText: placeHolderText];
    [labelPlaceHoder setTextColor: COL_TEXT_GRAY2];
//    [labelPlaceHoder sizeToFit];
    CGSize textSize = JHTCalcStringSizeWithFontSize(@"AAAAAAAAAAAAAAAAAAAA", 13);
    CGSize textSize2 = JHTCalcStringSizeWithFontSize(placeHolderText, 13);
    [labelPlaceHoder sizeToFit];
    [labelPlaceHoder setAdjustsFontSizeToFitWidth:YES];
    if(textSize2.width>textSize.width){
        [labelPlaceHoder setW:textSize.width];
        [labelPlaceHoder setH:textSize.height];
    }else{
        [labelPlaceHoder setW:labelPlaceHoder.width];
        [labelPlaceHoder setH:labelPlaceHoder.height];
    }
    
    UIBarButtonItem *placeHolder = [[UIBarButtonItem alloc] initWithCustomView:labelPlaceHoder];
    
    NSMutableArray *toolBarItems = [NSMutableArray array];
    [toolBarItems addObject:btnCancelItem];
    [toolBarItems addObject:space];
    [toolBarItems addObject:placeHolder];
    
    UIButton *btnSure = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSure setTitleColor: COL_BLUE_DEEP forState: UIControlStateNormal];
    [btnSure setTitleColor: UIColorFromRGB(0xbbbbbb) forState: UIControlStateHighlighted];
    [btnSure setTitle:LocatizedStirngForkey(@"QUEDING") forState:UIControlStateNormal];
    [btnSure sizeToFit];
    [btnSure addTarget: self action:@selector(beSure:) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *btnSureItem = [[UIBarButtonItem alloc] initWithCustomView:btnSure];
    
    [toolBarItems addObject:space];
    [toolBarItems addObject:btnSureItem];
    
    [toolBar setItems:toolBarItems animated:YES];
    
    mypickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(JHTActionSheetMarginRL, toolBar.maxY, SCREEN_WIDTH - JHTActionSheetMarginRL*2, SCREEN_WIDTH/2)];
    // 显示选中框
    mypickerView.showsSelectionIndicator=YES;
//    mypickerView.backgroundColor = UIColorFromRGB(0x293035);
    mypickerView.dataSource = self;
    mypickerView.delegate = self;
    [selectView addSubview:mypickerView];
    
    [self addSubview: selectView];
    
    
    
    actionSheetController = [[HQZXSelectIDController alloc] init];
    actionSheetController.view = self;
    
    if (!actionWindow) {
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        window.opaque = NO;
        window.windowLevel = ((UIWindow*)[[[UIApplication sharedApplication] windows] lastObject]).windowLevel + 1;
        window.rootViewController = actionSheetController;
        actionWindow = window;
        self.frame = window.frame;
    }
    
    [actionWindow makeKeyAndVisible];
    
    
    selectView.makeY(SCREEN_HEIGHT - viewHeight).easeOutQuad.animate(0.28);
    
}
-(NSArray*) getLabelAndValueByItem:(id) item {
    if (item == nil) {
        return nil;
    }
    id value = nil;
    if ([item isKindOfClass: [NSString class]]) {
        value = item;
    } else if ([item isKindOfClass: [NSArray class]]) {
        value = [item objectAtIndex: 1];
    } else {
        value = item;
    }
    
    NSString *lable = nil;
    if ([item isKindOfClass: [NSString class]]) {
        lable = item;
    } else if ([item isKindOfClass: [NSArray class]]) {
        lable = [item objectAtIndex: 0];
    } else {
        lable = @"";
    }
    return @[lable, value];
}
#pragma mark - 该方法的返回值决定该控件包含多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}
#pragma mark - 该方法的返回值决定该控件指定列包含多少个列表项
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return aryCountrys.count;
}
#pragma mark - 该方法返回的NSString将作为UIPickerView中指定列和列表项的标题文本

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    HQZXID *card = aryCountrys[row];
    UILabel *label = [[UILabel alloc] init];
    NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
    if([language isEqualToString:@"zh-Hans"]){
        label.text = card.card_name;
    }else if([language isEqualToString:@"en"]){
        label.text = card.card_ename;
    }
    
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    [label setX:(SCREEN_WIDTH - JHTActionSheetMarginRL*2-label.width)/2];
    return label;
}
#pragma mark - 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _card = aryCountrys[row];
}
@end
