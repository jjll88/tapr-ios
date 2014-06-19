//
//  TPMeasurement.h
//  tapr
//
//  Created by David Regatos on 19/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TPMeasurementType;

@interface TPMeasurement : NSManagedObject

@property (nonatomic, retain) NSNumber * value;
@property (nonatomic, retain) NSDate * createdOn;
@property (nonatomic, retain) NSString * descriptionString;
@property (nonatomic, retain) TPMeasurementType *type;

@end
