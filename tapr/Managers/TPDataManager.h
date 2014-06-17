//
//  TPDataManager.h
//  tapr
//
//  Created by David Regatos on 13/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TPDataManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) NSArray *dummyBodyPartCategories;
@property (nonatomic, strong) NSArray *dummyBodyPartData;

- (void) addMeasure:(NSDictionary *)dataInfo toCategory: (int) categoryIndex;
- (void) removeMeasure:(NSDictionary *)dataInfo atIndex:(int) rowIndex ofCategory: (int) categoryIndex;

@end
