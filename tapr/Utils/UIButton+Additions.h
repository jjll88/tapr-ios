//
//  UIButton+Additions.h
//  EdCoApp
//
//  Created by David Regatos on 13/05/14.
//  Copyright (c) 2014 edCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Additions)

// Create a backgroundImage with desired solid color for the indicated state
// Use it  to create a selected/default button with customizable color
// Key: use a btn image with a solid background and a transparent motif
- (void) setBackgroundColor:(UIColor *)tintColor forState:(UIControlState) state;

@end
