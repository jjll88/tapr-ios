//
//  TPDataManager.m
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "TPDataManager.h"

@interface TPDataManager ()

@property (nonatomic, strong) NSMutableArray *dummyChestData;
@property (nonatomic, strong) NSMutableArray *dummyArmData;
@property (nonatomic, strong) NSMutableArray *dummyWaistData;
@property (nonatomic, strong) NSMutableArray *dummyLegData;
@property (nonatomic, strong) NSMutableArray *dummyHipData;
@property (nonatomic, strong) NSDateFormatter *dummyDateFormatter;

@end

@implementation TPDataManager

+ (instancetype)sharedManager {
    static dispatch_once_t once;
    static TPDataManager *shared;
    dispatch_once(&once, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (NSNumber *)unitConversionFactor  {
    return ([[TPProfileManager sharedManager] user].measurementUnits == measurementUnits_cm ? @1 : @(1/inchToCmConversionFactor));
}

- (NSString *)unitsStr  {
    return [[TPProfileManager sharedManager] user].measurementUnits == measurementUnits_cm ? @"cm" : @"in.";
}

- (NSDateFormatter *)dummyDateFormatter  {
    if  (!_dummyDateFormatter) {
        _dummyDateFormatter = [[NSDateFormatter alloc] init];
        [_dummyDateFormatter setDateFormat:@"MMMM dd, yyyy\nhh:mm a"];
    }
    return _dummyDateFormatter;
}

- (NSArray *)dummyBodyPartCategories  {
    if  (!_dummyBodyPartCategories) _dummyBodyPartCategories = @[@"Chest",@"Arm",@"Waist",@"Legs",@"Hip"];
    return _dummyBodyPartCategories;
}

- (NSMutableArray *)dummyChestData  {
    if  (!_dummyChestData) _dummyChestData = [@[@{@"value":@41.5,@"date":[self.dummyDateFormatter dateFromString:@"June 6, 2014\n8:15 PM"]},
                                                @{@"value":@42,@"date":[self.dummyDateFormatter dateFromString:@"April 12, 2014\n8:25 AM"]},
                                                @{@"value":@43.25,@"date":[self.dummyDateFormatter dateFromString:@"February 26, 2014\n10:15 PM"]},
                                                @{@"value":@44,@"date":[self.dummyDateFormatter dateFromString:@"January 16, 2014\n9:15 AM"]}] mutableCopy];
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
    if  (!_dummyWaistData) _dummyWaistData = [@[@{@"value":@32.45,@"date":[self.dummyDateFormatter dateFromString:@"June 4, 2014\n6:15 AM"]},
                                                @{@"value":@31,@"date":[self.dummyDateFormatter dateFromString:@"January 20, 2014\n12:25 PM"]},
                                                @{@"value":@33.25,@"date":[self.dummyDateFormatter dateFromString:@"December 15, 2013\n8:15 AM"]},
                                                @{@"value":@33,@"date":[self.dummyDateFormatter dateFromString:@"October 11, 2013\n7:15 PM"]}] mutableCopy];
    return _dummyWaistData;
}

- (NSMutableArray *)dummyHipData  {
    if  (!_dummyHipData) _dummyHipData = [@[@{@"value":@90.45,@"date":[self.dummyDateFormatter dateFromString:@"April 4, 2015\n9:17 AM"]},
                                          @{@"value":@91,@"date":[self.dummyDateFormatter dateFromString:@"September 20, 2014\n10:22 PM"]},
                                          @{@"value":@93.5,@"date":[self.dummyDateFormatter dateFromString:@"April 15, 2014\n1:15 AM"]},
                                          @{@"value":@96,@"date":[self.dummyDateFormatter dateFromString:@"September 11, 2013\n7:10 PM"]}] mutableCopy];
    return _dummyHipData;
}

- (NSArray *)dummyBodyPartData  {
    if  (!_dummyBodyPartData) _dummyBodyPartData = @[self.dummyChestData,self.dummyArmData,self.dummyWaistData,self.dummyLegData, self.dummyHipData];
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
