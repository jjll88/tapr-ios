//
//  TPBaseVC.m
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPBaseVC.h"
#import "TPMeasureVC.h"
//#import "TPSummaryVC.h"

@interface TPBaseVC ()

@end

@implementation TPBaseVC

#pragma mark - init
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if	(self) [self setup];
    return self;
}

- (void) awakeFromNib {
    [self setup];
}

- (void) setup {
    // Initialization that can't wait until viewDidLoad
    
}

#pragma mark - view events
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.shouldAddMenuBarBtn) {
        [self setupMenuBarButton];
    }
    
    if (self.shouldAddPlusBarBtn) {
        [self setupPlusBarButton];
    }
    
    if (self.shouldAddMenuPanGesture) {
        [self addMenuPanGestureRecognizer];
    }
    
    if (self.shouldAddMenuTapGesture) {
        [self addMenuTapGestureRecognizer];
    }
    
    // Navigation bar bkg
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = NO;
    CGFloat lineThickness = 1.;
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bounds.size.height-lineThickness,
                                                                     self.navigationController.navigationBar.bounds.size.width, lineThickness)];
    separatorLine.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_LightOrange];
    [self.navigationController.navigationBar addSubview:separatorLine];
}

#pragma mark - Set up UI
- (void) setupMenuBarButton {
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn-nav-hamburger"]
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:self
                                                                     action:@selector(menuBarPressed)];
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.tintColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_OrangeTintColor];
    [self.navigationItem addLeftBarButtonItem:customBarItem];
}

- (void) setupPlusBarButton {
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                   target:self action:@selector(plusBarButtonPressed)];
    self.navigationController.navigationBar.tintColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_OrangeTintColor];
    [self.navigationItem addRightBarButtonItem:customBarItem];
}

- (void) setupNavBarTitle:(NSString *) navTitle {
    // Nav bar Title
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    title.text = navTitle;
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_BlueTintColor];
    title.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_NavBarTitle];
    
    self.navigationItem.titleView = title;
}

#pragma mark - UIActions
- (void)navigateBack {
    // Don't go back if progressHUD is in progress
    if (!self.progressHUD.taskInProgress) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void) menuBarPressed {
    // Do something before revealToggle:
    [self.view endEditing:YES];
    
    [self.revealViewController revealToggle:nil];
}

- (void) plusBarButtonPressed {
    [self performSegueWithIdentifier:@"segueMeasureVC" sender:nil];
}

#pragma mark - Gesture recognizer

- (void) addMenuPanGestureRecognizer {
    [self.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
}

- (void) addMenuTapGestureRecognizer {
    [self.view addGestureRecognizer: self.revealViewController.tapGestureRecognizer];
}

#pragma mark - ProgressHUD and Toast Functions
- (MBProgressHUD *)progressHUD {
    if (!_progressHUD) {
        MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:progressHud];
        _progressHUD = progressHud;
    }
    return _progressHUD;
}

- (void)showPieHUD:(BOOL)animated {
    [self.view bringSubviewToFront:self.progressHUD];
    self.progressHUD.mode = MBProgressHUDModeDeterminate;
    self.progressHUD.progress = 0.0;
    [self.progressHUD show:animated];
}

- (void)showHUD:(BOOL)animated {
    [self showHUDWithMessage:nil detailedMessage:nil animated:animated];
}

- (void)showHUDWithMessage:(NSString *)message animated:(BOOL)animated {
    [self showHUDWithMessage:message detailedMessage:nil animated:animated];
}

- (void)showHUDWithMessage:(NSString *)message detailedMessage:(NSString *)detailedMessage animated:(BOOL)animated {
    [self.view bringSubviewToFront:self.progressHUD];
    self.progressHUD.taskInProgress = YES;
    self.progressHUD.graceTime = 0.3;
    self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    self.progressHUD.labelText = message;
    self.progressHUD.labelFont = [UIFont fontWithName:@"Quicksand-Bold" size:18];
    self.progressHUD.detailsLabelText = detailedMessage;
    self.progressHUD.detailsLabelFont = [UIFont fontWithName:@"Quicksand-Bold" size:16];
    [self.progressHUD show:animated];
}


- (void)hideHUD:(BOOL)animated {
    self.progressHUD.taskInProgress = NO;
    [self.progressHUD hide:animated];
}

- (void)showHUDForLogIn {
    self.progressHUD.taskInProgress = YES;
    self.progressHUD.dimBackground = YES;
    [self showHUDWithMessage:@"Logging in..." detailedMessage:nil animated:YES];
}

- (void)showHUDForProcessing {
    self.progressHUD.taskInProgress = YES;
    self.progressHUD.dimBackground = YES;
    [self showHUDWithMessage:@"Processing..." detailedMessage:nil animated:YES];
}

- (void)toastMessage:(NSString *)message {
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;                         // we are using detailsLabelText because this one is multiline
    hud.detailsLabelFont = [UIFont fontWithName:@"Quicksand-Bold" size:18];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2.0];
}

- (void)toastNetworkUnavailableMessage {
    [self toastMessage:@"Network is not available"];
}

- (void)toastTokenExpiredMessage {
    [self toastMessage:@"Session expired. You must login again."];
}

#pragma mark - Helpers
- (BOOL) isLeftMenuVisible {
    return self.revealViewController.frontViewPosition <= FrontViewPositionLeft ? YES : NO;
}

#pragma mark - Alert view
- (void) showAlert:(NSString *)message {
    [[[UIAlertView alloc]initWithTitle:nil
                               message:message
                              delegate:nil
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil] show];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueMeasureVC"]) {
//        TPMeasureVC *measureVC = segue.destinationViewController;
        
    } else if ([segue.identifier isEqualToString:@"segueMeasureVC"]) {
//        TPSummaryVC *summaryVC = segue.destinationViewController;
        
    }
}


@end
