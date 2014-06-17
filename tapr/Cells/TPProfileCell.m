//
//  TPProfileCell.m
//  tapr
//
//  Created by David Regatos on 17/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPProfileCell.h"

@implementation TPProfileCell

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
    self.backgroundColor = [UIColor whiteColor];
    
    //Lbls
    self.categoryNameLbl.textColor = [UIColor grayColor];
    self.categoryNameLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_RegularCell_Title];
    
    self.categoryValueLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_BlueTintColor];
    self.categoryValueLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_RegularCell_Title];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
