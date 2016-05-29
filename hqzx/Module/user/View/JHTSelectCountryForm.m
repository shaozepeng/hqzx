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

#import "JHTYaoQingGuanZhuForm.h"
#import <JHChainableAnimations.h>
#import "JHTTextView.h"

#pragma mark - Controller
@interface JHTYaoQingGuanZhuFormController : JHTBaseController
@property (nonatomic, strong) JHTYaoQingGuanZhuForm *actionView;
@end

@implementation JHTYaoQingGuanZhuFormController

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
@interface JHTYaoQingGuanZhuForm() {
    UIWindow *actionWindow;
    UIView *selectView;
    NSString *placeHolderText;
    
    UITextField *txtXingming;
    UITextField *txtShouji;
    UITextView *txtMiaoshu;
    JHTYaoQingGuanZhuFormController *actionSheetController;
}
@end

@implementation JHTYaoQingGuanZhuForm
- (instancetype)initWithPlaceHolder:(NSString*) placeHolder {
    self = [super init];
    if (self) {
        placeHolderText = placeHolder;
        _concerPeople = [[JHTConcernedPeople alloc] init];
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
    NSString *userName = txtXingming.text;
    NSString *userShouji = txtShouji.text;
    NSString *userMiaoshu = txtMiaoshu.text;

    VALIDATE_NOT_NULL_ALERT(userName, @"请输入联系人姓名", self, CSToastPositionCenter);
    VALIDATE_NOT_NULL_ALERT(userShouji, @"请输入联系人手机", self, CSToastPositionCenter);
    VALIDATE_NOT_NULL_ALERT(_concerPeople.types, @"请选择社会关系", self, CSToastPositionCenter);
    
    if (userName.length > 10) {
        [self makeToast:@"联系人姓名过长！" duration: 1.0 position:CSToastPositionCenter];
        return;
    }
    VALIDATE_REGEX_ALERT(userShouji, VALREG_MOBILE_PHONE, @"手机号码不正确",self,CSToastPositionCenter);
    _concerPeople.user_name=userName;
    _concerPeople.mobile=userShouji;
    _concerPeople.desc=userMiaoshu;
    WEAK_SELF
    //    [self hideAction:Void_Block(){
    if (weakself.beSureComp) {
        weakself.beSureComp(_concerPeople);
    }
    //    }];
}

- (void) showAction{
    self.backgroundColor = DO_RGBA(0, 0, 0, 0.7);
    
    float viewHeight = STATIC_INPUT_HEIGHT * 2 + COMMON_H_MARGIN + JHTActionSheetToolBarHeight*2 + 60;
    
    UIButton *close = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - viewHeight)];
    [close addTarget: self action: @selector(cancel:) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: close];
    
    
    selectView = [[UIView alloc] initWithFrame: CGRectMake(JHTActionSheetMarginRL, SCREEN_HEIGHT, SCREEN_WIDTH - JHTActionSheetMarginRL*2, viewHeight + JHTActionSheetToolBarHeight + 200)];
    selectView.backgroundColor = [UIColor whiteColor];
    selectView.layer.masksToBounds = YES;
    selectView.layer.cornerRadius = 2;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, JHTActionSheetToolBarHeight)];
    [selectView addSubview: toolBar];
    toolBar.tintColor = COL_2B;
    
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCancel setTitleColor: UIColorFromRGB(0x46a9e6) forState: UIControlStateNormal];
    [btnCancel setTitleColor: UIColorFromRGB(0xbbbbbb) forState: UIControlStateHighlighted];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel sizeToFit];
    [btnCancel addTarget: self action:@selector(cancel:) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *btnCancelItem = [[UIBarButtonItem alloc] initWithCustomView:btnCancel];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                           target:nil
                                                                           action:nil];
    UILabel *labelPlaceHoder = [[UILabel alloc] init];
    [labelPlaceHoder setText: placeHolderText];
    [labelPlaceHoder setTextColor: COL_TEXT_GRAY2];
    [labelPlaceHoder sizeToFit];
    UIBarButtonItem *placeHolder = [[UIBarButtonItem alloc] initWithCustomView:labelPlaceHoder];
    
    NSMutableArray *toolBarItems = [NSMutableArray array];
    [toolBarItems addObject:btnCancelItem];
    [toolBarItems addObject:space];
    [toolBarItems addObject:placeHolder];
    
    UIButton *btnSure = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSure setTitleColor: COL_BLUE_DEEP forState: UIControlStateNormal];
    [btnSure setTitleColor: UIColorFromRGB(0xbbbbbb) forState: UIControlStateHighlighted];
    [btnSure setTitle:@"确定" forState:UIControlStateNormal];
    [btnSure sizeToFit];
    [btnSure addTarget: self action:@selector(beSure:) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *btnSureItem = [[UIBarButtonItem alloc] initWithCustomView:btnSure];
    
    [toolBarItems addObject:space];
    [toolBarItems addObject:btnSureItem];
    
    [toolBar setItems:toolBarItems animated:YES];
    
    
    float halfWidth = (selectView.width - COMMON_H_MARGIN*2 - FORM_INPUT_MARGIN) / 2.0;
    
    JHTTextView *huowumingcheng = [[JHTTextView alloc] initWithMyFrame: CGRectMake(COMMON_H_MARGIN,  toolBar.maxY + FORM_INPUT_MARGIN, halfWidth, CGSizeZero.height) requied: YES placeholder: @"联系人姓名"];
    txtXingming = (UITextField*)huowumingcheng.textField;
    //    txtHuowumingcheng.keyboardType = UIKeyboardTypeNumberPad;
    [selectView addSubview: huowumingcheng];
    
    JHTTextView *huowudunwei = [[JHTTextView alloc] initWithMyFrame: CGRectMake(huowumingcheng.maxX + FORM_INPUT_MARGIN,  huowumingcheng.y, halfWidth*0.8, CGSizeZero.height) requied: YES placeholder: @"联系人手机"];
    txtShouji = (UITextField*)huowudunwei.textField;
    txtShouji.keyboardType = UIKeyboardTypeNumberPad;
    [selectView addSubview: huowudunwei];
    
    UIButton *mjuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mjuBtn.frame = CGRectMake(huowudunwei.maxX+5, huowumingcheng.y+(huowudunwei.height-halfWidth*0.17)/2, halfWidth*0.17, halfWidth*0.17);
    [mjuBtn setTintColor:[UIColor whiteColor]];
    //icon_tann_pressed incomingletter
    [mjuBtn setImage:[UIImage imageNamed:@"jhtgroup"] forState:UIControlStateNormal];
    [mjuBtn addTarget:self action:@selector(mjuPhone) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:mjuBtn];
    
    JHTDropSelectView *sociologyModel = [[JHTDropSelectView alloc] initWithPoint: FORM_INPUT_BOTTOM(huowumingcheng) dataSource: JHTDIC_KEY_SOCIETY_TYPE defaultValue: self.concerPeople.types requied: YES placeholder: nil];
    sociologyModel.emptyLabel = @"社会关系";
    sociologyModel.autoClose = YES;
    WEAK_SELF
    sociologyModel.callback = JHTDropSelected() {
        weakself.concerPeople.types = JHTDropValue;
        weakself.concerPeople.typeName = JHTDropLabel;
    };
    [selectView addSubview: sociologyModel];
    
    JHTTextView *miaoshu = [[JHTTextView alloc] initWithMyFrame: CGRectMake(COMMON_H_MARGIN, sociologyModel.maxY + COMMON_H_MARGIN, selectView.width - COMMON_H_MARGIN*2, 75) requied:NO placeholder:@"描述"];
    txtMiaoshu = (UITextView*)miaoshu.textField;
    [selectView addSubview: miaoshu];
    
    [self addSubview: selectView];
    
    
    
    actionSheetController = [[JHTYaoQingGuanZhuFormController alloc] init];
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
-(void)mjuPhone{
    ABPeoplePickerNavigationController * vc = [[ABPeoplePickerNavigationController alloc] init];
    vc.peoplePickerDelegate = self;
    [actionSheetController presentViewController:vc animated:YES completion:nil];
}
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    //电话号码
    CFStringRef telValue = ABMultiValueCopyValueAtIndex(valuesRef,index);
    
    //读取firstname
    //获取个人名字（可以通过以下两个方法获取名字，第一种是姓、名；第二种是通过全名）。
    //第一中方法
    //    CFTypeRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    //    CFTypeRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
    //    //姓
    //    NSString * nameString = (__bridge NSString *)firstName;
    //    //名
    //    NSString * lastString = (__bridge NSString *)lastName;
    //第二种方法：全名
//    CFStringRef anFullName = ABRecordCopyCompositeName(person);
    
    [actionSheetController dismissViewControllerAnimated:YES completion:^{
        NSString * tempStr = (__bridge NSString *)telValue;
        NSString *newtempStr;
        if ([tempStr rangeOfString:@"+86 "].location != NSNotFound) {
            newtempStr = [tempStr substringFromIndex:(4)];
        }else if ([tempStr rangeOfString:@"+86"].location != NSNotFound) {
            newtempStr = [tempStr substringFromIndex:(3)];
        }else{
            newtempStr = tempStr;
        }
        txtShouji.text = newtempStr;
//        self.telLabel.text = (__bridge NSString *)telValue;
        //        self.nameLabel.text = [NSString stringWithFormat:@"%@%@",nameString,lastString];
//        self.nameLabel.text = [NSString stringWithFormat:@"%@",anFullName];
        
    }];
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
@end
