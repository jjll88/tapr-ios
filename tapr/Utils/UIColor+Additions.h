//
//  UIColor+Additions.h
//  EdCoApp
//
//  Created by David Regatos on 05/05/14.
//  Copyright (c) 2014 edCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

+(UIColor *)colorWithHexString:(NSString *)hexString;
+(NSString *)hexValuesFromUIColor:(UIColor *)color;

// Using 1.1 it will increase the brightness by 10%; 0.9 will decrease the brightness by 10%.
// Note that the 10% is relative to pure white (i.e., 10% is always a .1 increase in brightness.)
// This is the expected behavior if you want a percentage increase to lighten or darken the colors consistently regardless of their initial brightness.
+(UIColor *)changeBrightness:(UIColor *)color amount:(CGFloat)amount;

@end
