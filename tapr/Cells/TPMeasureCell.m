//
//  TPMeasureCell.m
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPMeasureCell.h"

@interface TPMeasureCell ()

@end

@implementation TPMeasureCell


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
    
    //separator line
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, self.bounds.size.height-1, self.bounds.size.width, 1)];
    separatorLineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:separatorLineView];
    
    //background color
    self.backgroundColor = [UIColor clearColor];
    
    //titleLbl
    self.titleLbl.textColor = [UIColor blackColor];
    self.titleLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_RegularCell_Title];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Don't forget to reset content of reusable cells
    self.backgroundView = nil;
    
    if (selected) {
        self.titleLbl.textColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuHighLigthedCell];
        self.titleLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_RegularCell_TitleHiglighted];
//        self.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuHighLigthedCell];
        
    } else {
        
        self.titleLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_RegularCell_Title];
        self.titleLbl.textColor = [UIColor blackColor];
        
    }
}
@end
