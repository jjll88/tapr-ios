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

- (NSArray *)dummyBodyPartCategories  {
    if  (!_dummyBodyPartCategories) _dummyBodyPartCategories = @[@"Chest",@"Arm",@"Waist",@"Legs"];
    return _dummyBodyPartCategories;
}

- (NSMutableArray *)dummyChestData  {
    if  (!_dummyChestData) _dummyChestData = [@[@{@"value":@"41.5",@"date":@"June 6, 2014\n8:15 PM"},
                                                @{@"value":@"42",@"date":@"April 12, 2014\n8:25 AM"},
                                                @{@"value":@"43.25",@"date":@"February 26, 2014\n10:15 PM"},
                                                @{@"value":@"44",@"date":@"January 16, 2014\n9:15 AM"}] mutableCopy];
    return _dummyChestData;
}

- (NSMutableArray *)dummyArmData  {
    if  (!_dummyArmData) _dummyArmData = [@[@{@"value":@"12.25",@"date":@"April 4, 2014\n4:15 AM"},
                                                @{@"value":@"11",@"date":@"January 2, 2014\n2:25 PM"},
                                                @{@"value":@"10.25",@"date":@"September 5, 2013\n1:15 AM"},
                                                @{@"value":@"9",@"date":@"April 11, 2013\n3:15 PM"}] mutableCopy];
    return _dummyArmData;
}

- (NSMutableArray *)dummyLegData  {
    if  (!_dummyLegData) _dummyLegData = [@[@{@"value":@"28",@"date":@"April 4, 2014\n8:15 PM"},
                                            @{@"value":@"28",@"date":@"March 2, 2014\n12:25 AM"},
                                            @{@"value":@"27.5",@"date":@"February 5, 2014\n11:15 PM"},
                                            @{@"value":@"27",@"date":@"January 1, 2014\n12:15 AM"}] mutableCopy];
    return _dummyLegData;
}

- (NSMutableArray *)dummyWaistData  {
    if  (!_dummyWaistData) _dummyWaistData = [@[@{@"value":@"32.45",@"date":@"June 4, 2014\n6:15 AM"},
                                              @{@"value":@"31",@"date":@"January 20, 2014\n12:25 PM"},
                                              @{@"value":@"33.25",@"date":@"December 15, 2013\n8:15 AM"},
                                              @{@"value":@"33",@"date":@"October 11, 2013\n7:15 PM"}] mutableCopy];
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
