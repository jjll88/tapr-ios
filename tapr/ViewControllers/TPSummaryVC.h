//
//  TPSummaryVC.h
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPSummaryVC : TPBaseVC

@property (nonatomic) int index;
@property (nonatomic, getter = shouldShowNewMeasure) BOOL showNewMeasure;

@end
