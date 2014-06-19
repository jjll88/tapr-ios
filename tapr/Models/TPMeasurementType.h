//
//  TPMeasurementType.h
//  tapr
//
//  Created by David Regatos on 19/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TPMeasurement;

@interface TPMeasurementType : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSSet *measurement;
@end

@interface TPMeasurementType (CoreDataGeneratedAccessors)

- (void)addMeasurementObject:(TPMeasurement *)value;
- (void)removeMeasurementObject:(TPMeasurement *)value;
- (void)addMeasurement:(NSSet *)values;
- (void)removeMeasurement:(NSSet *)values;

@end
