//
//  TPSettingsVC.m
//  tapr
//
//  Created by David Regatos on 18/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPSettingsVC.h"

@interface TPSettingsVC ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *unitSegmentedControl;

// Local variables
@property (nonatomic, strong) TPUserProfile *user;

@end

@implementation TPSettingsVC

- (TPUserProfile *)user  {
    return [[TPProfileManager sharedManager] user];
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
    self.addMenuBarBtn = YES;
    self.addMenuPanGesture = YES;
    self.addPlusBarBtn = NO;
}

#pragma mark - view events
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - Set up UI
- (void) setupUI {
    // Nav bar Title
    [self setupNavBarTitle:settingsTitle];
    
    self.unitSegmentedControl.tintColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_DarkBlueTintColor];
    self.unitSegmentedControl.selectedSegmentIndex = self.user.measurementUnits;
    [self.unitSegmentedControl addTarget:self
                              action:@selector(segmentedChanged:)
                    forControlEvents:UIControlEventValueChanged];
}

#pragma mark - IBActions
- (void) segmentedChanged:(UISegmentedControl *) sender {
    TPUserProfile *user = [[TPProfileManager sharedManager] user];
    user.measurementUnits = sender.selectedSegmentIndex == 0 ? measurementUnits_cm : measurementUnits_inch;
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
