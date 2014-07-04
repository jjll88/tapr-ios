//
//  TPUserProfile.h
//  tapr
//
//  Created by David Regatos on 17/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define userProfileTagOffset 100

typedef enum MeasurementUnits : NSUInteger {
    measurementUnits_cm = userProfileTagOffset,
    measurementUnits_inch = userProfileTagOffset+1
    
} MeasurementUnits;

typedef enum HeightUnits : NSUInteger {
    heightUnits_cm = userProfileTagOffset,
    heightUnits_ft = userProfileTagOffset+1
    
} HeightUnits;

typedef enum WeightUnits : NSUInteger {
    weightUnits_kg = userProfileTagOffset,
    weightUnits_lb = userProfileTagOffset+1
    
} WeightUnits;

typedef enum Gender : NSUInteger {
    gender_female = userProfileTagOffset,
    gender_male = userProfileTagOffset+1
    
} Gender;

@interface TPUserProfile : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *birthday;
//height
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic) HeightUnits heightUnits;
//weight
@property (nonatomic, strong) NSNumber *weight;
@property (nonatomic) WeightUnits weightUnits;

@property (nonatomic) Gender gender;

@property (nonatomic, strong) UIImage *avatar;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSDate *joinedDate;

@property (nonatomic) MeasurementUnits measurementUnits;

@end
