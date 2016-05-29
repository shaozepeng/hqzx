//
//  US2ValidatorTextViewPrivateDelegate.h
//  US2FormValidator
//
//  Copyright (C) 2012 ustwo™
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//  of the Software, and to permit persons to whom the Software is furnished to do
//  so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//  

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class US2ValidatorTextViewPrivate;
@class US2ConditionCollection;


#pragma mark - Validator text field private delegate

/**
 A private delegate protocol which is used by class US2ValidatorTextView and served by internal
 class US2ValidatorTextViewPrivate
 */
@protocol US2ValidatorTextViewPrivateDelegate <UITextViewDelegate>

/**
 @param textViewPrivate Private instance in US2ValidatorTextField which checks the validation process.
 @param conditions Collection of type US2ConditionCollection listing all violated conditions.
 */
- (void)validatorTextViewDelegate:(US2ValidatorTextViewPrivate *)textViewPrivate violatedConditions:(US2ConditionCollection *)conditions;

/**
 @param textViewPrivate Private instance in US2ValidatorTextField which checks the validation process.
 */
- (void)validatorTextViewDelegateSuccededConditions:(US2ValidatorTextViewPrivate *)textViewPrivate;

@end
