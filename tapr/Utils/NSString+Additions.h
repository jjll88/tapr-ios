//
//  NSString+Additions.h
//  EdCoApp
//
//  Created by David Regatos on 31/03/14.
//  Copyright (c) 2014 edCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

+ (BOOL)isEmpty:(NSString *)value;
+ (BOOL)isValidEmail:(NSString *)emailString;
+ (BOOL)isZIPCode:(NSString *) zipString;

+ (NSString *)numberToStringWithSeparatorAndNoDecimals:(NSNumber *) number;   // Example: (NSNumber) 16867.54 --> (NSString) 16,867. Round Down!!
+ (NSString *)numberToStringWithSeparator: (NSNumber *) number andDecimals:(int) numberOfDecimals;   // Example: (NSNumber) 16,867.5434 --> (NSString) 16,867.45 Round Down!!

+ (NSString *) Date: (NSDate *) date toStringWithFormat:(NSString *) formatStr;

@end
