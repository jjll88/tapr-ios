//
//  EditNameView.m
//  tapr
//
//  Created by David Regatos on 01/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "EditNameView.h"

@implementation EditNameView

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
    self.nameLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_TurquoiseTintColor];
    self.nameLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_Cell_RegularTitle];
    
    // TxtField
    self.nameTxtField.text = [TPProfileManager sharedManager].user.name;
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
