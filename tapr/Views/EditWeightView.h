//
//  EditWeightView.h
//  tapr
//
//  Created by David Regatos on 01/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditWeightView : UIView

@property (nonatomic, strong) IBOutlet UILabel *weightLbl;
@property (nonatomic, strong) IBOutlet UITextField *weightTxtField;
@property (nonatomic, strong) IBOutlet UISegmentedControl *weightControl;

@end
