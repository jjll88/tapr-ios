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
    
    // Tap gesture
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfViewTapped)];
    [self addGestureRecognizer:tap];
    
    // Lbl
    self.weightLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_TurquoiseTintColor];
    self.weightLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_Cell_RegularTitle];
    

    // TxtField
    self.weightTxtField.text = [NSString numberToStringWithSeparator:[TPProfileManager sharedManager].user.weight andDecimals:1];

    // Segmented control
    self.weightControl.tintColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_TurquoiseTintColor];
    self.weightControl.selectedSegmentIndex = [TPProfileManager sharedManager].user.weightUnits;
    [self.weightControl addTarget:self
                                  action:@selector(segmentedChanged:)
                        forControlEvents:UIControlEventValueChanged];
}

#pragma mark - IBActions
- (void) segmentedChanged:(UISegmentedControl *) sender {
    if ([TPProfileManager sharedManager].user.weightUnits == weightUnits_lb) {
        if (sender.selectedSegmentIndex == weightUnits_kg) {
            CGFloat value = [[TPProfileManager sharedManager].user.weight floatValue]/kgToLbConversionFactor;
            self.weightTxtField.text = [NSString numberToStringWithSeparator:@(value) andDecimals:1];
        } else {
            self.weightTxtField.text = [NSString numberToStringWithSeparator:[TPProfileManager sharedManager].user.weight andDecimals:1];
        }
    } else {
        if (sender.selectedSegmentIndex == weightUnits_lb) {
            CGFloat value = [[TPProfileManager sharedManager].user.weight floatValue]*kgToLbConversionFactor;
            self.weightTxtField.text = [NSString numberToStringWithSeparator:@(value) andDecimals:1];
        } else {
            self.weightTxtField.text = [NSString numberToStringWithSeparator:[TPProfileManager sharedManager].user.weight andDecimals:1];
        }
    }
}

- (void)selfViewTapped {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_HideKeyword object:nil];
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
