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
static NSString* const TPUserWeightKey = @"weight";
static NSString* const TPUserGenderKey = @"gender";
static NSString* const TPUserAvatarKey = @"avatar";
static NSString* const TPUserJoinedDateKey = @"joinedDate";
static NSString* const TPUserEmailKey = @"email";

@implementation TPUserProfile

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.name forKey:TPUserNameKey];
    [encoder encodeObject:self.birthday forKey:TPUserBirthdayKey];
    [encoder encodeObject:self.height forKey:TPUserHeightKey];
    [encoder encodeObject:self.weight forKey:TPUserWeightKey];
    [encoder encodeObject:self.gender forKey:TPUserGenderKey];
    [encoder encodeObject:self.avatar forKey:TPUserAvatarKey];
    [encoder encodeObject:self.joinedDateStr forKey:TPUserJoinedDateKey];
    [encoder encodeObject:self.email forKey:TPUserEmailKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.name = [decoder decodeObjectForKey:TPUserNameKey];
        self.birthday = [decoder decodeObjectForKey:TPUserBirthdayKey];
        self.height = [decoder decodeObjectForKey:TPUserHeightKey];
        self.weight = [decoder decodeObjectForKey:TPUserWeightKey];
        self.gender = [decoder decodeObjectForKey:TPUserGenderKey];
        self.avatar = [decoder decodeObjectForKey:TPUserAvatarKey];
        self.joinedDateStr = [decoder decodeObjectForKey:TPUserJoinedDateKey];
        self.email = [decoder decodeObjectForKey:TPUserEmailKey];
    }
    return self;
}



@end
