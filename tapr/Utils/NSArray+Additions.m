//
//  NSArray+Additions.m
//  tapr
//
//  Created by David Regatos on 18/06/14.
//  Copyright (c) 2014 ByteFly Inc. All rights reserved.
//

#import "NSArray+Additions.h"

@implementation NSArray (Additions)

- (NSArray *)reversedArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
}


@end
