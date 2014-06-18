//
//  TPThemeManager.h
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum ThemeFontType : NSUInteger {
    ThemeFontType_NavBarTitle = 1,
    ThemeFontType_Subheader,
    
    ThemeFontType_LeftMenuCell,
    ThemeFontType_RegularCell_Title,
    ThemeFontType_RegularCell_TitleHiglighted,
    ThemeFontType_RegularCell_Subtitle,
    ThemeFontType_LightCell_Title,
    
    ThemeFontType_MeasureValue,
    ThemeFontType_MeasureUnit
    
} ThemeFontType;

typedef enum ThemeColorType : NSUInteger {
    ThemeColorType_BlueTintColor = 1,
    ThemeColorType_OrangeTintColor,
    ThemeColorType_LightOrange,
    
    ThemeColorType_MenuBackground,
    ThemeColorType_MenuHighLigthedCell,
    ThemeColorType_MenuCellSeparator
    
} ThemeColorType;

typedef enum ThemeResizableImageType : NSUInteger {
    ThemeResizableImageType_DottedLine = 1,
    ThemeResizableImageType_CategoryRowSeparator,
    
} ThemeResizableImageType;

@interface TPThemeManager : NSObject

+ (instancetype)sharedManager;

//// colors
- (UIColor *)colorOfType:(ThemeColorType)type;
//
//// fonts
- (UIFont *)fontOfType:(ThemeFontType)type;
//
//// theme functions


@end
