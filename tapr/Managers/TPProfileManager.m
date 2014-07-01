//
//  TPUserManager.m
//  tapr
//
//  Created by David Regatos on 17/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPProfileManager.h"

@implementation TPProfileManager

- (TPUserProfile *)user  {
    if  (!_user) _user = [self createDummyUserProfile]; // [[TPUserProfile alloc] init];
    return _user;
}

+ (instancetype)sharedManager {
    static dispatch_once_t once;
    static TPProfileManager *shared;
    dispatch_once(&once, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

+ (NSString *)filePath {
    static NSString* filePath = nil;
    if (!filePath) {
        filePath =
        [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
         stringByAppendingPathComponent:TPUserProfilePathKey];
    }
    return filePath;
}

#pragma mark - Persistence
- (void)loadProfile {
    NSData *decodedData = [NSData dataWithContentsOfFile:[TPProfileManager filePath]];
    if (decodedData) {
        self.user = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
    }
}
- (BOOL) saveProfile {
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:self.user];
    return [encodedData writeToFile:[TPProfileManager filePath] atomically:YES];
}

#pragma mark - Helpers
- (TPUserProfile *) createDummyUserProfile {
    TPUserProfile *user = [[TPUserProfile alloc] init];
    
    user.name = @"Keti Topuria";
    user.birthday = @"July 6, 1989";
    user.height = @180;
    user.heightUnits = heightUnits_cm;
    user.weight = @70;
    user.weightUnits = weightUnits_kg;
    user.gender = gender_male;
    user.email = @"user@email.com";
    user.measurementUnits = measurementUnits_cm;
    
    // Joined date
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMMM dd, YYYY"];
    user.joinedDateStr = [dateFormatter stringFromDate:currDate];
    
    //avatar
    user.avatar = [UIImage imageNamed:@"ic-profile-placeholder.png"];
    
    return user;
}


@end
