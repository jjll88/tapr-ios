//
//  TPLabel.h
//  tapr
//
//  Created by David Regatos on 04/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum TPButtonStatus : NSUInteger  {
    Status_Normal = 0,
    Status_HighLighted = 1,

} TPButtonStatus;

@interface TPLabel : UILabel

@property (nonatomic, getter = shouldAddUnderline) BOOL addUnderline;
@property (nonatomic) TPButtonStatus status;

- (void) setTextColor:(UIColor *)textColor forState:(TPButtonStatus) status;

@end
