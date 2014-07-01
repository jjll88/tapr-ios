//
//  EditHeightView.h
//  tapr
//
//  Created by David Regatos on 01/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditHeightView : UIView

@property (nonatomic, strong) IBOutlet UILabel *heightLbl;
@property (nonatomic, strong) IBOutlet UITextField *heightTxtField;
@property (nonatomic, strong) IBOutlet UISegmentedControl *heightControl;

@end
