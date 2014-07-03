//
//  TPLoginVC.m
//  tapr
//
//  Created by David Regatos on 20/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPLoginVC.h"
#import <QuartzCore/QuartzCore.h>

@interface TPLoginVC ()

@property (weak, nonatomic) IBOutlet UIButton *loginFBBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginEmailBtn;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
@property (weak, nonatomic) IBOutlet UIButton *forgotBtn;

// Autolayout
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoToCenterYConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnsToCenterYConstrain;
@end

@implementation TPLoginVC

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
    
    [self setupUI];
}

#pragma mark - Set up UI
- (void) setupUI {
        
    self.emailTextField.text = testUserEmail;
    self.emailTextField.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_Cell_LightTitle];
    self.emailTextField.layer.borderColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_LightBlueTintColor].CGColor;
    self.emailTextField.layer.borderWidth = 1.0;
    
    self.passTextField.text = testUserPassword;
    self.passTextField.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_Cell_LightTitle];
    self.passTextField.layer.borderColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_LightBlueTintColor].CGColor;
    self.passTextField.layer.borderWidth = 1.0;
    
    [self.forgotBtn setTitleColor:[[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor] forState:UIControlStateNormal];
    [self.forgotBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    // Layout
    self.logoToCenterYConstrain.constant = self.view.bounds.size.height/4;
    self.btnsToCenterYConstrain.constant = -self.logoToCenterYConstrain.constant;
}

#pragma mark - IBActions
- (IBAction)loginFBBtnPressed:(id)sender {
    [self toastMessage:@"Under construction"];
}

- (IBAction)loginEmailBtnPressed:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *obj = [storyboard instantiateViewControllerWithIdentifier:@"RevealVC"];
    obj.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:obj animated:YES completion:nil];
}

- (IBAction)forgotBtnPressed:(UIButton *)sender {
    [self toastMessage:@"Under construction"];
}

#pragma mark - Others
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
