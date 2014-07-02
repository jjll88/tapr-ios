//
//  TPUserProfile.m
//  tapr
//
//  Created by David Regatos on 17/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPUserProfile.h"

static NSString* const TPUserNameKey = @"name";
static NSString* const TPUserBirthdayKey = @"birthday";
static NSString* const TPUserHeightKey = @"height";
static NSString* const TPUserHeightUnitsKey = @"heightUnits";
static NSString* const TPUserWeightKey = @"weight";
static NSString* const TPUserWeightUnitsKey = @"weightUnits";
static NSString* const TPUserGenderKey = @"gender";
static NSString* const TPUserAvatarKey = @"avatar";
static NSString* const TPUserJoinedDateKey = @"joinedDate";
static NSString* const TPUserEmailKey = @"email";
static NSString* const TPUserUnitsKey = @"measurementUnits";

@implementation TPUserProfile

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.name forKey:TPUserNameKey];
    [encoder encodeObject:self.birthday forKey:TPUserBirthdayKey];
    [encoder encodeObject:self.height forKey:TPUserHeightKey];
    [encoder encodeInteger:self.heightUnits forKey:TPUserHeightUnitsKey];
    [encoder encodeObject:self.weight forKey:TPUserWeightKey];
    [encoder encodeInteger:self.weightUnits forKey:TPUserWeightUnitsKey];
    [encoder encodeInteger:self.gender forKey:TPUserGenderKey];
    [encoder encodeObject:self.avatar forKey:TPUserAvatarKey];
    [encoder encodeObject:self.joinedDate forKey:TPUserJoinedDateKey];
    [encoder encodeObject:self.email forKey:TPUserEmailKey];
    [encoder encodeInteger:self.measurementUnits forKey:TPUserUnitsKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.name = [decoder decodeObjectForKey:TPUserNameKey];
        self.birthday = [decoder decodeObjectForKey:TPUserBirthdayKey];
        self.height = [decoder decodeObjectForKey:TPUserHeightKey];
        self.heightUnits = [decoder decodeIntegerForKey:TPUserHeightUnitsKey];
        self.weight = [decoder decodeObjectForKey:TPUserWeightKey];
        self.weightUnits = [decoder decodeIntegerForKey:TPUserWeightUnitsKey];

        self.gender = [decoder decodeIntegerForKey:TPUserGenderKey];
        self.avatar = [decoder decodeObjectForKey:TPUserAvatarKey];
        self.joinedDate = [decoder decodeObjectForKey:TPUserJoinedDateKey];
        self.email = [decoder decodeObjectForKey:TPUserEmailKey];
        self.measurementUnits = [decoder decodeIntegerForKey:TPUserUnitsKey];
    }
    return self;
}



@end
