//
//  TPUserManager.m
//  tapr
//
//  Created by David Regatos on 17/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPUserManager.h"

@implementation TPUserManager

+ (instancetype)sharedManager {
    static dispatch_once_t once;
    static TPUserManager *shared;
    dispatch_once(&once, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (TPUserProfile *)user  {
    if  (!_user) _user = [[TPUserProfile alloc] init];
    return _user;
}

- (void) initWithDummyUserProfile {
    self.user.name = @"Keti Topuria";
    self.user.birthday = @"July 6, 1989";
    self.user.height = @"5' 8''";
    self.user.weight = @"110 lbs";
    self.user.gender = @"Female";
    
    // Joined date
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMMM dd, YYYY"];
    self.user.joinedDateStr = [dateFormatter stringFromDate:currDate];
    
    //avatar
    self.user.avatar = [UIImage imageNamed:@"ic-profile-placeholder.png"];
}

@end
