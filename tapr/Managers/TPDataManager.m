//
//  TPDataManager.m
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPDataManager.h"

@interface TPDataManager ()

@property (nonatomic, strong) NSMutableArray *allMeasurements;

// testing
@property (nonatomic, strong) NSMutableArray *dummyChestData;
@property (nonatomic, strong) NSMutableArray *dummyArmData;
@property (nonatomic, strong) NSMutableArray *dummyWaistData;
@property (nonatomic, strong) NSMutableArray *dummyLegData;

@end

@implementation TPDataManager

@synthesize managedObjectContext = _managedObjectContext,
            managedObjectModel = _managedObjectModel,
            persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Manager function
+ (instancetype)sharedManager {
    static dispatch_once_t once;
    static TPDataManager *shared;
    dispatch_once(&once, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

#pragma mark - Core Data stack
// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:TPModelFileNameKey withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", TPModelFileNameKey]];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - CoreData properties
- (NSMutableArray *)allMeasurements  {
    if  (!_allMeasurements) _allMeasurements = [[NSMutableArray alloc] init];
    return _allMeasurements;
}

- (NSMutableArray *)measurementTypesArr  {
    
    if  (!_measurementTypesArr) {
        _measurementTypesArr = [[NSMutableArray alloc] init];
        
        // add initial values
        NSManagedObject *typeManObj;
        for (NSString *type in self.dummyBodyPartCategories) {
            typeManObj = [NSEntityDescription insertNewObjectForEntityForName:@"TPMeasurementType"
                                                       inManagedObjectContext:self.managedObjectContext];
            [typeManObj setValue:type forKey:@"name"];
            [_measurementTypesArr addObject:typeManObj];
        }
    }
    
    return _measurementTypesArr;
}

#pragma mark - CoreData methods
- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (TPMeasurement *)addMeasurementInContext {
    TPMeasurement *measurement = [NSEntityDescription insertNewObjectForEntityForName:TPMeasurementObjNameKey
                                                               inManagedObjectContext:self.managedObjectContext];
    return measurement;
}

- (void) removeMeasurementFromContext:(TPMeasurement *) measurement {
    [self.managedObjectContext deleteObject:measurement];
}

- (NSMutableArray *) loadAllMeasurements {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *e = [[self.managedObjectModel entitiesByName] objectForKey:@"TPMeasurement"];
    [request setEntity:e];
    
    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"createdOn" ascending:NO];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sd]];
    
    NSError *error;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!result) {
        [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    return [[NSMutableArray alloc] initWithArray:result];
}

#pragma mark - Application's Documents directory
// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Helpers
- (NSArray *)dummyBodyPartCategories  {
    if  (!_dummyBodyPartCategories) _dummyBodyPartCategories = @[@"Chest",@"Arm",@"Waist",@"Legs"];
    return _dummyBodyPartCategories;
}

- (NSMutableArray *)dummyChestData  {
    if  (!_dummyChestData) _dummyChestData = [@[@{@"value":@"91.5",@"date":@"June 6, 2014\n8:15 PM"},
                                                @{@"value":@"92",@"date":@"April 12, 2014\n8:25 AM"},
                                                @{@"value":@"93.25",@"date":@"February 26, 2014\n10:15 PM"},
                                                @{@"value":@"94",@"date":@"January 16, 2014\n9:15 AM"}] mutableCopy];
    return _dummyChestData;
}

- (NSMutableArray *)dummyArmData  {
    if  (!_dummyArmData) _dummyArmData = [@[@{@"value":@12.25,@"date":[self.dummyDateFormatter dateFromString:@"April 4, 2014\n4:15 AM"]},
                                            @{@"value":@11,@"date":[self.dummyDateFormatter dateFromString:@"January 2, 2014\n2:25 PM"]},
                                            @{@"value":@10.25,@"date":[self.dummyDateFormatter dateFromString:@"September 5, 2013\n1:15 AM"]},
                                            @{@"value":@9,@"date":[self.dummyDateFormatter dateFromString:@"April 11, 2013\n3:15 PM"]}] mutableCopy];
    return _dummyArmData;
}

- (NSMutableArray *)dummyLegData  {
    if  (!_dummyLegData) _dummyLegData = [@[@{@"value":@28,@"date":[self.dummyDateFormatter dateFromString:@"April 4, 2014\n8:15 PM"]},
                                            @{@"value":@28,@"date":[self.dummyDateFormatter dateFromString:@"March 2, 2014\n12:25 AM"]},
                                            @{@"value":@27.5,@"date":[self.dummyDateFormatter dateFromString:@"February 5, 2014\n11:15 PM"]},
                                            @{@"value":@27,@"date":[self.dummyDateFormatter dateFromString:@"January 1, 2014\n12:15 AM"]}] mutableCopy];
    return _dummyLegData;
}

- (NSMutableArray *)dummyWaistData  {
    if  (!_dummyWaistData) _dummyWaistData = [@[@{@"value":@"82.45",@"date":@"June 4, 2014\n6:15 AM"},
                                                @{@"value":@"85",@"date":@"January 20, 2014\n12:25 PM"},
                                                @{@"value":@"84.25",@"date":@"December 15, 2013\n8:15 AM"},
                                                @{@"value":@"83",@"date":@"October 11, 2013\n7:15 PM"}] mutableCopy];
    return _dummyWaistData;
}

- (NSArray *)dummyBodyPartData  {
    if  (!_dummyBodyPartData) _dummyBodyPartData = @[self.dummyChestData,self.dummyArmData,self.dummyWaistData,self.dummyLegData];
    return _dummyBodyPartData;
}

- (void) addMeasure:(NSDictionary *)dataInfo toCategory: (int) categoryIndex {
    NSMutableArray *mArr = [self.dummyBodyPartData mutableCopy];
    
    [mArr[categoryIndex] insertObject:dataInfo atIndex:0];
    
    _dummyBodyPartData = [mArr copy];
}

- (void) removeMeasure:(NSDictionary *)dataInfo atIndex:(int) rowIndex ofCategory: (int) categoryIndex {
    NSMutableArray *mArr = [self.dummyBodyPartData mutableCopy];
    
    [mArr[categoryIndex] removeObjectAtIndex:rowIndex];
    
    _dummyBodyPartData = [mArr copy];
}


@end
