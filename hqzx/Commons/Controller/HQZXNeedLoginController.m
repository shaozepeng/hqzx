//
//  JHTNeedLoginController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/19.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXNeedLoginController.h"
#import "HQZXUserModel.h"
#import "HQZXLoginViewController.h"

@implementation HQZXNeedLoginController

-(instancetype)initWithController:(UIViewController*) controller {
    self = [self init];
    if (self) {
        self.controller = controller;
        self.url = nil;
    }
    return self;
}

-(instancetype)initWithUrl:(NSString *)url {
    self = [self init];
    if (self) {
        self.url = url;
        self.controller = nil;
    }
    return self;
}
- (void)showFrom:(UIViewController*) parentController navigationController:(UINavigationController*) navigationController isPresent:(BOOL) isPresent animated: (BOOL)animated loginCompletion:(void (^)(void))completion NS_AVAILABLE_IOS(5_0) {
    [self validateFrom: parentController completion:^(BOOL value) {
        if (value) {
            if ([[HQZXUserModel sharedInstance] isAuthen] == NO) {
                [parentController showAlert:parentController andtitle:LocatizedStirngForkey(@"TISHI") andMsg:LocatizedStirngForkey(@"RENZHENGTISHI") andComm:^{
                    HQZXRealNameAuthenticationViewController *loginController = [[HQZXRealNameAuthenticationViewController alloc] init];
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController: loginController];
                    [CommonUtils setNavigationControllerStyle: nav];
                    [parentController presentViewController: nav animated: YES completion:^{
                        HQZXRealNameAuthenticationViewController *regView = [nav.viewControllers objectAtIndex: 0];
                        regView.successBlock = ^() {
                            if (isPresent) {
                                [self successPresent: parentController animated:animated completion:completion];
                            } else {
                                [self successPush: navigationController animated: animated];
                            }
                        };
                    }];
                }];
            } else {
                if (isPresent) {
                    [self successPresent: parentController animated:animated completion:completion];
                } else {
                    [self successPush: navigationController animated: animated];
                }
            }
        } else {
            
        }
    }];
}

- (void)validateFrom:(UIViewController*) parentController completion:(Bool_Block) completion{
    if ([[HQZXUserModel sharedInstance] isLogined] == NO) {
        [parentController showAlert:parentController andtitle:LocatizedStirngForkey(@"TISHI") andMsg:LocatizedStirngForkey(@"DENGLUTISHI") andComm:^{
            UINavigationController *login = [HQZXLoginViewController getLoginController];
            [parentController presentViewController: login animated: YES completion:^{
                HQZXLoginViewController *loginView = [login.viewControllers objectAtIndex: 0];
                if (completion != nil) {
                    loginView.successBlock = ^() {
                        completion(YES);
                    };
                    loginView.cancelBlock = ^() {
                        completion(NO);
                    };
                }
            }];
        
        }];
    } else {
        completion(YES);
    }
}

- (void)presentFrom:(UIViewController *)parentController animated: (BOOL)flag completion:(void (^)(void))completion NS_AVAILABLE_IOS(5_0) {
    [self showFrom: parentController navigationController: nil isPresent: YES animated: flag loginCompletion:completion];
}


- (void)pushFrom:(UIViewController*) parentController inNavigationController:(UINavigationController*) navigationController animated: (BOOL)flag {
    [self showFrom: parentController navigationController:navigationController isPresent: NO animated:flag loginCompletion: nil];
}

- (void)pushFrom:(UIViewController*) parentController animated: (BOOL)flag {
    [self showFrom: parentController navigationController:parentController.navigationController isPresent: NO animated:flag loginCompletion: nil];
}

-(void) successPresent:(UIViewController*) parentController animated: (BOOL)flag completion:(void (^)(void))completion NS_AVAILABLE_IOS(5_0){
    if (self.url) {
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: self.url]];
        return;
    }
    [parentController presentViewController: self.controller animated: flag completion: completion];
}

-(void) successPush:(UINavigationController*) nav animated: (BOOL)flag{
    if (self.url) {
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: self.url]];
        return;
    }
    [nav pushViewController: self.controller animated: YES];
}
@end
