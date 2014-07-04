//
//  TPButton.h
//  tapr
//
//  Created by David Regatos on 04/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/** NOTE:
 *  By default, this button is disabled.
 *  You must setEnabled to Yes in your VC setupUI 
 */

@interface TPButton : UIButton

@property (nonatomic, strong) UIColor *inactiveColor;
@property (nonatomic, strong) UIColor *activeColor;

@end
