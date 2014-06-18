//
//  UIImage+Additions.h
//  EdCoApp
//
//  Created by David Regatos on 07/05/14.
//  Copyright (c) 2014 edCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)

+ (UIImage *)imageWithColor:(UIColor *)color AndSize:(CGRect) rect;

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

@end
