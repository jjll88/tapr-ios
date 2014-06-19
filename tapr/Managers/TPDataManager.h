//
//  TPDataManager.h
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TPMeasurement;

@interface TPDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) NSMutableArray *measurementTypesArr;

+ (instancetype)sharedManager;

- (void)saveContext;
- (TPMeasurement *)addMeasurementInContext;
- (void) removeMeasurementFromContext:(TPMeasurement *) measurement;

// for testing - dummy data
@property (nonatomic, strong) NSArray *dummyBodyPartCategories;
@property (nonatomic, strong) NSArray *dummyBodyPartData;
- (void) addMeasure:(NSDictionary *)dataInfo toCategory: (int) categoryIndex;
- (void) removeMeasure:(NSDictionary *)dataInfo atIndex:(int) rowIndex ofCategory: (int) categoryIndex;

@end
