//
//  TPThemeManager.m
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPThemeManager.h"

@implementation TPThemeManager

+ (id)sharedManager {
    static dispatch_once_t once;
    static TPThemeManager *shared;
    dispatch_once(&once, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

#pragma mark - Colors
- (UIColor *)colorOfType:(ThemeColorType)type {
    UIColor *color = nil;
    switch (type) {
        case ThemeColorType_BlueTintColor:
            color = [UIColor colorWithRed:100/255.0 green:177/255.0 blue:197/255.0 alpha:1.0];
            break;
        case ThemeColorType_OrangeTintColor:
            color = [UIColor colorWithRed:228/255.0 green:104/255.0 blue:54/255.0 alpha:1.0];
            break;
        case ThemeColorType_LightOrange:
            color =[UIColor changeBrightness:[UIColor colorWithRed:228/255.0 green:104/255.0 blue:54/255.0 alpha:1.0]
                                      amount:1.3];
            break;
        case ThemeColorType_MenuBackground:
            color = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1.0];
            break;
        case ThemeColorType_MenuHighLigthedCell:
            color = [UIColor colorWithRed:222/255.0 green:82/255.0 blue:34/255.0 alpha:0.5];
            break;
        case ThemeColorType_MenuCellSeparator:
            color = [UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1.0];
            break;
        default:
            color = [UIColor grayColor];
            break;
    }
    return color;
}

#pragma mark - Fonts
/**
 * CUSTOM FONT NAMES:
 
 Family: Lato  (For regular text)
 Font: Lato-Regular
 Font: Lato-Bold
 Font: Lato-Light
 
 Family: Strait (For logo and titles)
 Font: Strait-Regular

 */

- (UIFont *)fontOfType:(ThemeFontType)type {
    UIFont *font = nil;
    switch (type) {
        case ThemeFontType_NavBarTitle:
            font = [UIFont fontWithName:@"Strait-Regular" size:24];
            break;
        case ThemeFontType_Subheader:
            font = [UIFont fontWithName:@"Lato-Bold" size:18];
            break;
        case ThemeFontType_LeftMenuCell:
            font = [UIFont fontWithName:@"Lato-Bold" size:20];
            break;
        case ThemeFontType_RegularCell_Title:
            font = [UIFont fontWithName:@"Lato-Regular" size:18];
            break;
        case ThemeFontType_RegularCell_TitleHiglighted:
            font = [UIFont fontWithName:@"Lato-Bold" size:18];
            break;
        case ThemeFontType_RegularCell_Subtitle:
            font = [UIFont fontWithName:@"Lato-Bold" size:10];
            break;
        case ThemeFontType_LightCell_Title:
            font = [UIFont fontWithName:@"Lato-Light" size:18];
            break;
        case ThemeFontType_MeasureValue:
            font = [UIFont fontWithName:@"Lato-Bold" size:30];
            break;
        case ThemeFontType_MeasureUnit:
            font = [UIFont fontWithName:@"Lato-Light" size:18];
            break;
        default:
            break;
    }
    return font;
}

@end
