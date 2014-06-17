//
//  TPUserManager.h
//  tapr
//
//  Created by David Regatos on 17/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPUserProfile.h"

@interface TPUserManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) TPUserProfile *user;

- (void) initWithDummyUserProfile;

@end
