//
//  RotatedUILabel.m
//  tapr
//
//  Created by David Regatos on 01/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "RotatedUILabel.h"

@implementation RotatedUILabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    CGContextRotateCTM(context, -(M_PI/2));
    
    CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    CGFloat middleX = (self.bounds.size.width - textSize.height) / 2;
    CGFloat middleY = -(self.bounds.size.height+textSize.width) / 2;
    
    [self.text drawAtPoint:CGPointMake(middleY, middleX) withAttributes:@{NSFontAttributeName:self.font, NSForegroundColorAttributeName:self.textColor}];
    
    CGContextRestoreGState(context);
}

@end
