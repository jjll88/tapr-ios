//
//  TPMeasureInputVC.h
//  tapr
//
//  Created by David Regatos on 16/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPMeasureInputVC;

@protocol TPMeasureInputDelegate <NSObject>

- (void)TPMeasureInputVC:(TPMeasureInputVC *)controller didFinishEnteringMeasure:(NSString *)measureValue atDate:(NSString *)measureDate;

@end

@interface TPMeasureInputVC : TPBaseVC

@property (nonatomic, weak) id <TPMeasureInputDelegate> delegate;

@end
