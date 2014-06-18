//
//  TPMenuCell.m
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPMenuCell.h"

@implementation TPMenuCell

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
    //left image - icon
    self.icon.contentMode = UIViewContentModeScaleAspectFill;
    self.icon.clipsToBounds = YES;
    
    //separator line
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1)];
    separatorLineView.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuCellSeparator];
    [self.contentView addSubview:separatorLineView];
    
    //background color
    self.backgroundColor = [UIColor clearColor];
    
    //titleLbl
    self.titleLbl.textColor = [UIColor whiteColor];
    self.titleLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_LeftMenuCell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Don't forget to reset content of reusable cells
    self.backgroundView = nil;
    
    if (selected) {
        self.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuHighLigthedCell];
        
    } else {
        
        self.backgroundColor = [UIColor clearColor];
        
    }
}

@end
