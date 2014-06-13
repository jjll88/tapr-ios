//
//  TPSummaryCell.m
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPSummaryCell.h"

@implementation TPSummaryCell

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
    
    //titleLbl
    self.titleLbl.textColor = [UIColor blackColor];
    self.titleLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_LightCell_Title];
    
    self.dateLbl.textColor = [UIColor darkTextColor];
    self.dateLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_RegularCell_Subtitle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Don't forget to reset content of reusable cells
    
    if (selected) {

        self.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuHighLigthedCell];
        
    } else {
        
        self.backgroundColor = [UIColor clearColor];
        
    }
}

@end
