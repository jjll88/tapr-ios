//
//  TPSettingsGoalLineCell.m
//  tapr
//
//  Created by David Regatos on 04/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPSettingsGoalLineCell.h"

@implementation TPSettingsGoalLineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [self setup];
}

#pragma mark - Set Up
- (void) setup {
    
    //background color
    self.backgroundColor = [UIColor clearColor];
    
    self.goalLineSwitch.onTintColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_DarkBlueTintColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
