//
//  TPLabel.m
//  tapr
//
//  Created by David Regatos on 04/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPLabel.h"

#define underlineThickness 1

@interface TPLabel ()

@property (nonatomic, strong) UIView *underline;
@property (nonatomic, strong) UIColor *enabledColor;
@property (nonatomic, strong) UIColor *disabledColor;

@end


@implementation TPLabel

- (UIColor *)enabledColor  {
    if  (!_enabledColor) _enabledColor = [UIColor blueColor];
    return _enabledColor;
}

- (UIColor *)disabledColor  {
    if  (!_disabledColor) _disabledColor = [UIColor lightGrayColor];
    return _disabledColor;
}

- (void)setAddUnderline:(BOOL)addUnderline {
    _addUnderline = addUnderline;
    
    if (addUnderline) {
        self.underline = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-underlineThickness, self.bounds.size.width, underlineThickness)];
        self.underline.backgroundColor = self.status == Status_HighLighted ? self.enabledColor : self.disabledColor;
        [self addSubview:self.underline];
    } else {
        self.underline = nil;
    }
}

- (void)setStatus:(TPButtonStatus)status {
    _status = status;
    
    self.underline.backgroundColor = self.status == Status_HighLighted ? self.enabledColor : self.disabledColor;

    if (status == Status_HighLighted) {
        self.textColor = self.enabledColor;
    } else {
        self.textColor = self.disabledColor;
    }
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
    
    self.adjustsFontSizeToFitWidth = YES;
    
    /** Default Color */
    self.textColor = [UIColor lightGrayColor];
}

- (void) setTextColor:(UIColor *)textColor forState:(TPButtonStatus) status {
    
    if (status == Status_HighLighted) {
        self.enabledColor = textColor;
    } else {
        self.disabledColor = textColor;
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
