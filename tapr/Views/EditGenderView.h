//
//  EditGenderView.h
//  tapr
//
//  Created by David Regatos on 01/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditGenderView : UIView

@property (nonatomic, strong) IBOutlet UILabel *genderLbl;
@property (nonatomic, strong) IBOutlet UISegmentedControl *genderControl;

@end
