//
//  JHTYaoQingGuanZhuForm.h
//  jht
//
//  Created by 泽鹏邵 on 15/11/9.
//  Copyright © 2015年 dhgh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHTCommDef.h"
#import "JHTCommonAlert.h"
#import "JHTShip.h"
#import "JHTDropSelectView.h"
#import "JHTDictionary.h"
#import "JHTConcernedPeople.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

typedef void (^JHTYaoQingGuanZhuComp)(JHTConcernedPeople*);
#define JHTYaoQingGuanZhuComp() ^void (JHTConcernedPeople* concerPeople)

@interface JHTYaoQingGuanZhuForm : UIView<ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic, strong) JHTYaoQingGuanZhuComp beSureComp;

@property (nonatomic, strong) JHTConcernedPeople* concerPeople;

- (instancetype)initWithPlaceHolder:(NSString*) placeHolder ;

- (void) showAction;

- (void) hideAction: (Void_Block) didClose;

@end
