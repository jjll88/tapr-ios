//
//  TPUserProfile.h
//  tapr
//
//  Created by David Regatos on 17/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum MeasurementUnits : NSUInteger {
    measurementUnits_cm = 0,
    measurementUnits_inch
    
} MeasurementUnits;

typedef enum HeightUnits : NSUInteger {
    heightUnits_cm = 0,
    heightUnits_ft
    
} HeightUnits;

typedef enum WeightUnits : NSUInteger {
    weightUnits_kg = 0,
    weightUnits_lb
    
} WeightUnits;

typedef enum Gender : NSUInteger {
    gender_female = 0,
    gender_male
    
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
