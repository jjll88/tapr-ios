//
//  NSString+Additions.m
//  EdCoApp
//
//  Created by David Regatos on 31/03/14.
//  Copyright (c) 2014 edCo. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

#pragma mark basic impl

+ (BOOL)isEmpty:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return value == nil ||
    value == (id)[NSNull null] ||
    [value isEqualToString:@""] ||
    ([value respondsToSelector:@selector(length)] && [value length] == 0);
}

+ (BOOL)isValidEmail:(NSString *)emailString {
    // Source: http://www.iossnippet.com/snippets/mail/how-to-validate-an-e-mail-address-in-objective-c-ios/
    if([emailString length]==0){
        return NO;
    }
    
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    
//    DMLog(@"%lu", (unsigned long)regExMatches);
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}

+ (BOOL)isZIPCode:(NSString *) zipString {
    
    if (![zipString length] == 5 || ![zipString integerValue]) {
        return NO;
    }
    
    NSString *regExPattern = @"[0-9]";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:zipString options:0 range:NSMakeRange(0, [zipString length])];
    
//    DMLog(@"%lu", (unsigned long)regExMatches);
    if (regExMatches != 5) {
        return NO;
    } else {
        return YES;  // could be, but not warranty
    }
    
    return NO;
}

+ (NSString *)numberToStringWithSeparatorAndNoDecimals: (NSNumber *) number {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setRoundingMode:NSNumberFormatterRoundDown];
    
    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    [formatter setGroupingSeparator:groupingSeparator];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setGroupingSize:3];
    
    [formatter setAlwaysShowsDecimalSeparator:NO];
    [formatter setMaximumFractionDigits:0];
    
    NSString *numberStr = [formatter stringFromNumber:number];
    return numberStr;
}

+ (NSString *)numberToStringWithSeparator: (NSNumber *) number andDecimals:(int) numberOfDecimals {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setRoundingMode:NSNumberFormatterRoundDown];
    
    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    [formatter setGroupingSeparator:groupingSeparator];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setGroupingSize:3];
    
    [formatter setAlwaysShowsDecimalSeparator:NO];
    [formatter setMaximumFractionDigits:numberOfDecimals];
    
    NSString *numberStr = [formatter stringFromNumber:number];
    return numberStr;
}

+ (NSString *)convertFeetToFeet_Inches:(float) feet {
    
    int feetInt = (int) feet;
    CGFloat mod = feet - feetInt;
    int inchInt = (int) ceil(mod*12);
    
    return [NSString stringWithFormat:@"%i' %i''",feetInt,inchInt];

}

+ (NSString *) Date: (NSDate *) date toStringWithFormat:(NSString *) formatStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formatStr];
    //    DMLog(@"%@",[dateFormatter stringFromDate:currDate]);
    
    return [dateFormatter stringFromDate:date];
}

@end
