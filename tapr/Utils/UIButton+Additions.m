//
//  UIButton+Additions.m
//  EdCoApp
//
//  Created by David Regatos on 13/05/14.
//  Copyright (c) 2014 edCo. All rights reserved.
//

#import "UIButton+Additions.h"

@implementation UIButton (Additions)

- (void) setBackgroundColor:(UIColor *)tintColor forState:(UIControlState) state {
    [self setBackgroundImage:[UIImage imageWithColor:tintColor AndSize:self.bounds] forState:state];
}

@end
