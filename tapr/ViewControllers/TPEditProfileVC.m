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

@interface TPEditProfileVC ()

@property (weak, nonatomic) IBOutlet EditNameView *editNameContainer;
@property (weak, nonatomic) IBOutlet EditBirthdayView *editBirthdayContainer;
@property (weak, nonatomic) IBOutlet EditHeightView *editHeightContainer;
@property (weak, nonatomic) IBOutlet EditWeightView *editWeightContainer;
@property (weak, nonatomic) IBOutlet EditGenderView *editGenderContainer;


// Autolayout
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topNameContainerConstrain;

// Local variables
@property (nonatomic, strong) TPUserProfile *user;

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

#pragma mark - Set up UI
- (void) setupUI {
    
    // Nav bar
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                   target:self action:@selector(saveBarButtonPressed)];
    self.navigationController.navigationBar.tintColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_DarkBlueTintColor];
    [self.navigationItem setRightBarButtonItem:customBarItem];
    
    // Autolayout
    self.topNameContainerConstrain.constant = topDistance;
}

- (void) updateUI {
    
}

#pragma mark - IBActions
- (void) saveBarButtonPressed {
    
    TPUserProfile *newUser = [[TPUserProfile alloc] init];
    newUser.name = self.editNameContainer.nameTxtField.text;
    newUser.birthday = self.editBirthdayContainer.birthdayTxtField.text;
    newUser.height = [NSNumber numberWithFloat:[self.editHeightContainer.heightTxtField.text floatValue]];
    newUser.weight = [NSNumber numberWithFloat:[self.editWeightContainer.weightTxtField.text floatValue]];
    newUser.gender = self.editGenderContainer.genderControl.selectedSegmentIndex == 0 ? gender_female : gender_male;
    newUser.avatar = self.user.avatar;
    newUser.joinedDateStr = self.user.joinedDateStr;
    newUser.email = self.user.email;
    
    // Save. KVObserved
    [TPProfileManager sharedManager].user = newUser;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)selfViewTapped:(UIControl *)sender {
    [self.view endEditing:YES];
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
