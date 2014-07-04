//
//  UIApplication+Additions.h
//  tapr
//
//  Created by David Regatos on 04/07/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Additions)

+ (NSString *) appVersion;
+ (NSString *) build;
+ (NSString *) versionBuild;
+ (NSString *) buildDate;

@end
