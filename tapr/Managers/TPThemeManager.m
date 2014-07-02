//
//  TPThemeManager.m
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPThemeManager.h"

@implementation TPThemeManager

+ (instancetype)sharedManager {
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
        case ThemeColorType_RegularBlueTintColor:
            color = [UIColor colorWithRed:14/255.0 green:128/255.0 blue:204/255.0 alpha:1.0];
            break;
        case ThemeColorType_DarkBlueTintColor:
            color = [UIColor colorWithRed:17/255.0 green:106/255.0 blue:192/255.0 alpha:0.75];
            break;
        case ThemeColorType_LightBlueTintColor:
            color = [UIColor colorWithRed:14/255.0 green:128/255.0 blue:204/255.0 alpha:0.15];
            break;
        case ThemeColorType_TurquoiseTintColor:
            color = [UIColor colorWithRed:34/255.0 green:161/255.0 blue:193/255.0 alpha:1.0];
            break;
        case ThemeColorType_OrangeTintColor:
            color = [UIColor colorWithRed:228/255.0 green:104/255.0 blue:54/255.0 alpha:1.0];
            break;
        case ThemeColorType_Background:
            color = [UIColor colorWithRed:250/255.0 green:254/255.0 blue:255/255.0 alpha:1.0];
            break;
        case ThemeColorType_MenuBackground:
            color = [UIColor colorWithRed:17/255.0 green:106/255.0 blue:192/255.0 alpha:1.0];
            break;
        case ThemeColorType_MenuHighLigthedCell:
            color = [UIColor colorWithRed:77/255.0 green:154/255.0 blue:214/255.0 alpha:0.5];
            break;
        case ThemeColorType_MenuCellSeparator:
            color = [UIColor colorWithRed:110/255.0 green:175/255.0 blue:223/255.0 alpha:1.0];
            break;
        case ThemeColorType_StatusBarTintColor:
            color = [UIColor colorWithRed:2/255.0 green:83/255.0 blue:162/255.0 alpha:0.75];
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
            font = [UIFont fontWithName:@"Lato-Light" size:24];
            break;
        case ThemeFontType_Subheader:
            font = [UIFont fontWithName:@"Lato-Bold" size:18];
            break;
        case ThemeFontType_LeftMenu_Cell:
            font = [UIFont fontWithName:@"Lato-Light" size:22];
            break;
        case ThemeFontType_Cell_RegularTitle:
            font = [UIFont fontWithName:@"Lato-Regular" size:18];
            break;
        case ThemeFontType_Cell_BoldTitle:
            font = [UIFont fontWithName:@"Lato-Bold" size:18];
            break;
        case ThemeFontType_Cell_LightTitle:
            font = [UIFont fontWithName:@"Lato-Light" size:19];
            break;
        case ThemeFontType_Cell_RegularSubtitle:
            font = [UIFont fontWithName:@"Lato-Regular" size:11];
            break;
        case ThemeFontType_MeasureValue:
            font = [UIFont fontWithName:@"Lato-Bold" size:120];
            break;
        case ThemeFontType_MeasureUnit:
            font = [UIFont fontWithName:@"Lato-Light" size:50];
            break;
        case ThemeFontType_Message:
            font = [UIFont fontWithName:@"Lato-Light" size:22];
            break;
        case ThemeFontType_QuoteText:
            font = [UIFont fontWithName:@"Lato-Light" size:16];
            break;
        case ThemeFontType_QuoteAuthor:
            font = [UIFont fontWithName:@"Lato-Light" size:13];
            break;
        default:
            break;
    }
    return font;
}

- (NSString *) nsdateToFormattedString: (NSDate *) date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMMM dd, yyyy"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    return dateStr;
}

- (NSDate *) dateStringToNSDate: (NSString *) dateStr {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMMM dd, yyyy"];
    NSDate *nsdate = [dateFormatter dateFromString:dateStr];
    
    return nsdate;
}



@end
