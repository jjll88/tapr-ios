//
//  TPButton.m
//  tapr
//
//  Created by David Regatos on 04/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPButton.h"

@implementation TPButton

@synthesize activeColor = _activeColor, inactiveColor = _inactiveColor;

- (UIColor *)activeColor  {
    if  (!_activeColor) _activeColor = [UIColor blueColor];
    return _activeColor;
}

- (UIColor *)inactiveColor  {
    if  (!_inactiveColor) _inactiveColor = [UIColor lightGrayColor];
    return _inactiveColor;
}

- (void)setInactiveColor:(UIColor *)inactiveColor {
    _inactiveColor = inactiveColor;
    
    // inactive state - device not detected
    [self setTitleColor:self.inactiveColor forState:UIControlStateDisabled];
    [self setBackgroundColor:[UIColor whiteColor] forState:UIControlStateDisabled];
}

- (void)setActiveColor:(UIColor *)activeColor {
    _activeColor = activeColor;
    
    // active state - device ready to save measure
    [self setTitleColor:self.activeColor forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // highlighted state - color inversion
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setBackgroundColor:self.activeColor forState:UIControlStateHighlighted];
}

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
    
    self.enabled = NO;
    self.layer.masksToBounds = YES;
    self.tintColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_Cell_LightTitle];
    
    self.layer.borderWidth = 2.;
    self.layer.cornerRadius = 6.;
}

- (void)setEnabled:(BOOL)enabled {
    super.enabled = enabled;
    
    if (enabled) {
        self.layer.borderColor = self.activeColor.CGColor;
    } else {
        self.layer.borderColor = self.inactiveColor.CGColor;
    }
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
