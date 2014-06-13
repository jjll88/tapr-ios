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

+ (id)sharedManager {
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
    if  (!_dummyChestData) _dummyChestData = [@[@{@"value":@"41.5",@"date":@"June 6, 2014\n8:15pm"},
                                                @{@"value":@"42",@"date":@"April 12, 2014\n8:25pm"},
                                                @{@"value":@"43.25",@"date":@"February 26, 2014\n10:15pm"},
                                                @{@"value":@"44",@"date":@"January 16, 2014\n9:15pm"}] mutableCopy];
    return _dummyChestData;
}

- (NSMutableArray *)dummyArmData  {
    if  (!_dummyArmData) _dummyArmData = [@[@{@"value":@"22.25",@"date":@"April 4, 2014\n4:15pm"},
                                                @{@"value":@"21",@"date":@"January 2, 2014\n2:25pm"},
                                                @{@"value":@"20.25",@"date":@"September 5, 2013\n1:15pm"},
                                                @{@"value":@"19",@"date":@"April 11, 2013\n3:15pm"}] mutableCopy];
    return _dummyArmData;
}

- (NSMutableArray *)dummyLegData  {
    if  (!_dummyLegData) _dummyLegData = [@[@{@"value":@"28",@"date":@"April 4, 2014\n8:15am"},
                                            @{@"value":@"28",@"date":@"March 2, 2014\n12:25am"},
                                            @{@"value":@"27.5",@"date":@"February 5, 2014\n11:15am"},
                                            @{@"value":@"27",@"date":@"January 1, 2014\n12:15am"}] mutableCopy];
    return _dummyLegData;
}

- (NSMutableArray *)dummyWaistData  {
    if  (!_dummyWaistData) _dummyWaistData = [@[@{@"value":@"32.45",@"date":@"June 4, 2014\n6:15am"},
                                              @{@"value":@"31",@"date":@"January 20, 2014\n12:25pm"},
                                              @{@"value":@"33.25",@"date":@"December 15, 2013\n8:15am"},
                                              @{@"value":@"33",@"date":@"October 11, 2013\n7:15am"}] mutableCopy];
    return _dummyWaistData;
}

- (NSArray *)dummyBodyPartData  {
    if  (!_dummyBodyPartData) _dummyBodyPartData = @[self.dummyChestData,self.dummyArmData,self.dummyArmData,self.dummyArmData];
    return _dummyBodyPartData;
}

- (void) addMeasure:(NSDictionary *)dataInfo intoIndex: (int) categoryIndex {
    NSMutableArray *mArr = [self.dummyBodyPartData mutableCopy];
    
    [mArr[categoryIndex] insertObject:dataInfo atIndex:0];
    
    _dummyBodyPartData = [mArr copy];
}



@end
