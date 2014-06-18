//
//  TPUserManager.h
//  tapr
//
//  Created by David Regatos on 17/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPUserProfile.h"

@interface TPProfileManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) TPUserProfile *user;

//Persistance
- (BOOL) saveProfile;
- (void) loadProfile;

@end
