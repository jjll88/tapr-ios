//
//  TPMeasureInputVC.m
//  tapr
//
//  Created by David Regatos on 16/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPMeasureInputVC.h"

@interface TPMeasureInputVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *dataInput;
@property (weak, nonatomic) IBOutlet UIButton *enterBtn;

@end

@implementation TPMeasureInputVC

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.dataInput becomeFirstResponder];
}

#pragma mark - Set up UI
- (void) setupUI {
    self.dataInput.delegate = self;
    self.dataInput.placeholder = [TPDataManager sharedManager].unitsStr;
    
    UIColor *highlightedColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_LightBlueTintColor];
    UIColor *normalColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_RegularBlueTintColor];
    
    self.enterBtn.tintColor = [UIColor clearColor];
    self.enterBtn.backgroundColor = [UIColor clearColor];
    [self.enterBtn setBackgroundColor:normalColor forState:UIControlStateNormal];
    [self.enterBtn setBackgroundColor:highlightedColor forState:UIControlStateHighlighted];
    
    [self.enterBtn setTitle:@"Enter" forState:UIControlStateNormal];
}

#pragma mark - UITextField Delegates
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return  YES;
}

#pragma mark - IBActions
- (IBAction) closeBtnPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)enterBtnPressed:(id)sender {
    if (![NSString isEmpty:self.dataInput.text]) {
        NSNumber *value = [NSNumber numberWithDouble:[self.dataInput.text doubleValue]];
        [self.delegate TPMeasureInputVC:self didFinishEnteringMeasure:[NSString numberToStringWithSeparator:value andDecimals:1] atDate:[NSDate date]];
        
        [self.dataInput resignFirstResponder];
        [self closeBtnPressed];
    } else {
        [self showAlert:@"Please, enter a value"];
    }
}
     
#pragma mark - Helpers

#pragma mark - Others
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
