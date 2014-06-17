//
//  TPUserProfile.h
//  tapr
//
//  Created by David Regatos on 17/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPUserProfile : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *gender;

@property (nonatomic, strong) UIImage *avatar;
@property (nonatomic, strong) NSString *joinedDateStr;


@end
