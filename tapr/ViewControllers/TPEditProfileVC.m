//
//  TPEditProfileVC.m
//  tapr
//
//  Created by David Regatos on 01/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPEditProfileVC.h"
#import "EditNameView.h"
#import "EditBirthdayView.h"
#import "EditHeightView.h"
#import "EditWeightView.h"
#import "EditGenderView.h"

#define topDistance 10

@interface TPEditProfileVC () <UITextFieldDelegate, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet EditNameView *editNameContainer;
@property (weak, nonatomic) IBOutlet EditBirthdayView *editBirthdayContainer;
@property (weak, nonatomic) IBOutlet EditHeightView *editHeightContainer;
@property (weak, nonatomic) IBOutlet EditWeightView *editWeightContainer;
@property (weak, nonatomic) IBOutlet EditGenderView *editGenderContainer;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

// ** Collection. Useful to loop over the editable txtFields ** //
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *txtFieldCollection;

// Autolayout
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topNameContainerConstrain;

// Local variables
@property (nonatomic, strong) TPUserProfile *user;
@property (nonatomic, strong) UITextField *currentlyEditedTxtField;

@end

@implementation TPEditProfileVC

- (TPUserProfile *)user  {
    if  (!_user) _user = [TPProfileManager sharedManager].user;
    return _user;
}

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
    self.addMenuBarBtn = NO;
    self.addMenuPanGesture = NO;
    self.addPlusBarBtn = NO;
    
    // Notifications **********************
    [self registerForNotifications];
}

#pragma mark - view events
- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateUI];
}

#pragma mark - NSNotification
- (void) dealloc {
    [self unregisterForNotifications];
}

- (void) registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeywordFromView:) name:kNotification_HideKeyword object:nil];
}

- (void) unregisterForNotifications {
    // Clear out _all_ observations that this object was making
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Set up UI
- (void) setupUI {
    
    // Nav bar
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                   target:self action:@selector(saveBarButtonPressed)];
    self.navigationController.navigationBar.tintColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_DarkBlueTintColor];
    [self.navigationItem setRightBarButtonItem:customBarItem];
    
    // Date Picker
    self.datePicker.hidden = YES;
    self.datePicker.tintColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_TurquoiseTintColor];
    self.datePicker.date = self.user.birthday;
    [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    // Autolayout
    self.topNameContainerConstrain.constant = topDistance;
    
    // Delegate
    self.editBirthdayContainer.birthdayTxtField.delegate = self;
}

- (void) updateUI {
    
}

#pragma mark - IBActions
- (void) saveBarButtonPressed {
    
    TPUserProfile *newUser = [[TPUserProfile alloc] init];
    newUser.name = self.editNameContainer.nameTxtField.text;
    newUser.birthday = self.datePicker.date;
    newUser.height = [NSNumber numberWithFloat:[self.editHeightContainer.heightTxtField.text floatValue]];
    newUser.heightUnits = self.editHeightContainer.heightControl.selectedSegmentIndex == heightUnits_cm ? heightUnits_cm : heightUnits_ft;
    newUser.weight = [NSNumber numberWithFloat:[self.editWeightContainer.weightTxtField.text floatValue]];
    newUser.weightUnits = self.editWeightContainer.weightControl.selectedSegmentIndex == weightUnits_kg ? weightUnits_kg : weightUnits_lb;
    newUser.gender = self.editGenderContainer.genderControl.selectedSegmentIndex == 0 ? gender_female : gender_male;
    newUser.avatar = self.user.avatar;
    newUser.joinedDate = self.user.joinedDate;
    newUser.email = self.user.email;
    
    // Save. KVObserved
    [TPProfileManager sharedManager].user = newUser;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selfViewTapped:(UIControl *)sender {
    [self.view endEditing:YES];
}

- (void)datePickerChanged:(UIDatePicker *)datePicker {
    self.editBirthdayContainer.birthdayTxtField.text = [[TPThemeManager sharedManager] nsdateToFormattedString:datePicker.date];
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([[textField superview] isKindOfClass:[EditBirthdayView class]]) {
        self.datePicker.hidden = NO;
        
        return NO;
    }
    
    return YES;
}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//    if ([[textField superview] isKindOfClass:[EditBirthdayView class]]) {
//        self.datePicker.hidden = NO;
//        
//        return YES;
//    }
//    
//    return NO;
//}

#pragma mark - Keyword Controller
// ** Hide presented keyboard when user tapped on any subview ** //
- (void) hideKeywordFromView:(NSNotification *) notification {
    
    for (UITextField *txtField in self.txtFieldCollection) {
        [txtField resignFirstResponder];
    }
    
    self.datePicker.hidden = YES;
}

#pragma mark - Others
- (void) didReceiveMemoryWarning {
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
