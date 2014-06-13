//
//  TPDataManager.m
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPDataManager.h"

@implementation TPDataManager

+ (id)sharedManager {
    static dispatch_once_t once;
    static TPDataManager *shared;
    dispatch_once(&once, ^{
        shared = [[self alloc] init];
    });
    return shared;
}



@end
