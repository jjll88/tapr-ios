//
//  TPSummaryCell.h
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPSummaryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (nonatomic, strong) IBOutlet UILabel *dateLbl;

@end
