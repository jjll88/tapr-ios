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
    self.icon.backgroundColor = [UIColor clearColor]; // [[TPThemeManager sharedManager] colorOfType:ThemeColorType_TurquoiseTintColor];
    self.icon.contentMode = UIViewContentModeCenter;
    self.icon.clipsToBounds = YES;
//    self.icon.layer.cornerRadius = self.icon.bounds.size.width/2;
    
    //separator line
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, menuCellHeight-1, self.bounds.size.width, 1)];
    separatorLineView.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuCellSeparator];
    [self.contentView addSubview:separatorLineView];
    
    //background color
    self.backgroundColor = [UIColor clearColor];
    
    //titleLbl
    self.titleLbl.textColor = [UIColor whiteColor];
    self.titleLbl.font = [[TPThemeManager sharedManager] fontOfType:ThemeFontType_LeftMenu_Cell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Don't forget to reset content of reusable cells
    self.backgroundView = nil;
    
    if (self.tag == profileCellIndex) {
        self.icon.image = [UIImage imageNamed:@"IC_profile"];
    } else if (self.tag == measureCellIndex) {
        self.icon.image = [UIImage imageNamed:@"IC_measure"];
    } else if (self.tag == progressCellIndex) {
        self.icon.image = [UIImage imageNamed:@"IC_progress"];
    } else if (self.tag == aboutCellIndex) {
        self.icon.image = [UIImage imageNamed:@"IC_about"];
    } else if (self.tag == privacyCellIndex) {
        self.icon.image = [UIImage imageNamed:@"IC_privacy"];
    } else if (self.tag == toolsCellIndex) {
        self.icon.image = [UIImage imageNamed:@"IC_tools"];
    } else if (self.tag == settingsCellIndex) {
        self.icon.image = [UIImage imageNamed:@"IC_settings"];
    }
    
    if (selected) {
        self.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_MenuHighLigthedCell];
//        self.icon.backgroundColor = [UIColor whiteColor];
        
    } else {
        self.backgroundColor = [UIColor clearColor];
//        self.icon.backgroundColor = [[TPThemeManager sharedManager] colorOfType:ThemeColorType_TurquoiseTintColor];
    }
}

@end
