//
//  EditWeightView.m
//  tapr
//
//  Created by David Regatos on 01/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "EditWeightView.h"

@implementation EditWeightView

#pragma mark - init
- (instancetype) initWithFrame:(CGRect)aRect  {
    self = [super initWithFrame:aRect];
    if (self)  [self setup];
    return self;
}

- (void) awakeFromNib {
    [self setup];
}

#pragma mark - Setup view
- (void) setup {
    // Initialization that can't wait until viewDidLoad
    
    self.weightLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_TurquoiseTintColor];
    self.weightLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_Cell_RegularTitle];
    
    self.weightControl.tintColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_TurquoiseTintColor];

    // TxtField
    self.weightTxtField.text = [[TPProfileManager sharedManager].user.weight stringValue];

    // Segmented control
    self.weightControl.selectedSegmentIndex = [TPProfileManager sharedManager].user.weightUnits;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
