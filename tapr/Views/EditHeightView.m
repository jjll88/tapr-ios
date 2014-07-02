//
//  EditHeightView.m
//  tapr
//
//  Created by David Regatos on 01/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "EditHeightView.h"

@implementation EditHeightView

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
    
    self.heightLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_TurquoiseTintColor];
    self.heightLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_Cell_RegularTitle];
    
    // TxtField
    self.heightTxtField.text = [[TPProfileManager sharedManager].user.height stringValue];

    // Segmented control
    self.heightControl.tintColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_TurquoiseTintColor];
    self.heightControl.selectedSegmentIndex = [TPProfileManager sharedManager].user.heightUnits;
    [self.heightControl addTarget:self
                           action:@selector(segmentedChanged:)
                 forControlEvents:UIControlEventValueChanged];
}

#pragma mark - IBActions
- (void) segmentedChanged:(UISegmentedControl *) sender {
    if ([TPProfileManager sharedManager].user.heightUnits == heightUnits_ft) {
        if (sender.selectedSegmentIndex == heightUnits_cm) {
            CGFloat value = [[TPProfileManager sharedManager].user.height floatValue]*ftToCmConversionFactor;
            self.heightTxtField.text = [NSString numberToStringWithSeparator:@(value) andDecimals:1];
        } else {
            self.heightTxtField.text = [NSString convertFeetToFeet_Inches:[[TPProfileManager sharedManager].user.height floatValue]];  //ft-inch
        }
    } else {
        if (sender.selectedSegmentIndex == heightUnits_ft) {
            CGFloat feet = [[TPProfileManager sharedManager].user.height floatValue]/ftToCmConversionFactor;
            self.heightTxtField.text = [NSString numberToStringWithSeparator:@(feet) andDecimals:1];

//            self.heightTxtField.text = [NSString convertFeetToFeet_Inches:feet];                                //ft-inch
        } else {
            self.heightTxtField.text = [NSString numberToStringWithSeparator:[TPProfileManager sharedManager].user.height andDecimals:1];
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
