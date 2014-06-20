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
    
    ThemeFontType_LeftMenu_Cell,
    ThemeFontType_Cell_RegularTitle,
    ThemeFontType_Cell_BoldTitle,
    ThemeFontType_Cell_RegularSubtitle,
    ThemeFontType_Cell_LightTitle,
    
    ThemeFontType_MeasureValue,
    ThemeFontType_MeasureUnit,
    ThemeFontType_BluetoothStatusMessage
    
} ThemeFontType;

typedef enum ThemeColorType : NSUInteger {
    ThemeColorType_RegularBlueTintColor = 1,
    ThemeColorType_DarkBlueTintColor,
    ThemeColorType_LightBlueTintColor,
    ThemeColorType_TurquoiseTintColor,
    ThemeColorType_OrangeTintColor,
    
    ThemeColorType_Background,
    ThemeColorType_MenuBackground,
    ThemeColorType_MenuHighLigthedCell,
    ThemeColorType_MenuCellSeparator,
    ThemeColorType_StatusBarTintColor
    
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
