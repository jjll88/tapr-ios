//
//  TPBaseVC.h
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface TPBaseVC : UIViewController

// Flags
@property (nonatomic, getter = shouldAddMenuBarBtn) BOOL addMenuBarBtn;
@property (nonatomic, getter = shouldAddPlusBarBtn) BOOL addPlusBarBtn;             // NOT used anymore
@property (nonatomic, getter = shouldAddMenuPanGesture) BOOL addMenuPanGesture;
@property (nonatomic, getter = shouldAddMenuTapGesture) BOOL addMenuTapGesture;

@property (nonatomic, weak) MBProgressHUD *progressHUD;

- (void) setupNavBarTitle:(NSString *) navTitle;

#pragma mark - ProgressHUD and Toast functions
- (void)showHUD:(BOOL)animated;
- (void)showHUDWithMessage:(NSString *)message animated:(BOOL)animated;
- (void)showHUDWithMessage:(NSString *)message detailedMessage:(NSString *)detailedMessage animated:(BOOL)animated;
- (void)showPieHUD:(BOOL)animated;
- (void)hideHUD:(BOOL)animated;
- (void)showHUDForLogIn;
- (void)showHUDForProcessing;

#pragma mark - Helpers
- (BOOL) isLeftMenuVisible;

#pragma mark - Alert view & Toast message
- (void) showAlert:(NSString *)message;

/**
 * show a one time toast message, duration 2 seconds; after hide, hud will be removed from superview
 */
- (void)toastMessage:(NSString *)message;
- (void)toastNetworkUnavailableMessage;
- (void)toastTokenExpiredMessage;

@end
