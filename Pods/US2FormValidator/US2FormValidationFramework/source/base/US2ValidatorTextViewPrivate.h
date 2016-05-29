//
//  US2ValidatorTextViewPrivate.h
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
#import "US2ValidatorUIDelegate.h"
#import "US2ValidatorUIProtocol.h"

@class US2ValidatorTextView;


#pragma mark - Validator private text view interface

/**
 US2ValidatorTextViewPrivate is a private class within US2ValidatorTextView
 and calls the set validator. The result of the validator will be checked and
 forwarded to the origin delegate and US2ValidatorTextView.
 This private class is needed because the US2ValidatorTextView should not listen
 for itself.
 */
@interface US2ValidatorTextViewPrivate : NSObject <UITextViewDelegate>
{
@private
    id <US2ValidatorUIDelegate, UITextViewDelegate> _delegate;
    US2ValidatorTextView                            *_validatorTextView;
    BOOL                                            _lastIsValid;
    BOOL                                            _didEndEditing;
}

/**
 Origin delegate which was set through US2ValidatorTextView and will
 be served by this private class US2ValidatorTextViewPrivate.
 */
@property (nonatomic, assign) id <US2ValidatorUIDelegate, UITextViewDelegate> delegate;

/**
 Represents the main validation text field which wants to know what went
 wrong when validating in this private class US2ValidatorTextViewPrivate.
 Thus the validation text field is able to change its appearance e.g..
 */
@property (nonatomic, assign) US2ValidatorTextView *validatorTextView;

@end
