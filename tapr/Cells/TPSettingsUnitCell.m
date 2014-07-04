//
//  TPSettingsUnitCell.m
//  tapr
//
//  Created by David Regatos on 03/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPSettingsUnitCell.h"

@implementation TPSettingsUnitCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [self setup];
}

#pragma mark - Set Up
- (void) setup {
    
    //background color
    self.backgroundColor = [UIColor clearColor];
    
    // Segmented Controller
    self.unitSegmentedControl.tintColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_DarkBlueTintColor];
    self.unitSegmentedControl.selectedSegmentIndex = [[TPProfileManager sharedManager] user].measurementUnits == measurementUnits_cm ? 0 : 1;
    [self.unitSegmentedControl addTarget:self
                                  action:@selector(segmentedChanged:)
                        forControlEvents:UIControlEventValueChanged];
}

#pragma mark - IBActions
- (void) segmentedChanged:(UISegmentedControl *) sender {
    TPUserProfile *user = [[TPProfileManager sharedManager] user];
    user.measurementUnits = sender.selectedSegmentIndex == 0 ? measurementUnits_cm : measurementUnits_inch;
}




@end
