//
//  NSDictionary+Category.m
//  MXTourism
//
//  Created by Yang on 2018/9/25.
//  Copyright © 2018年 YY. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)

- (NSArray *)yy_ascendingComparedAllKeys
{
    NSArray *allKeys = [self keysSortedByValueUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 integerValue] > [obj2 integerValue])
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        if ([obj1 integerValue] < [obj2 integerValue])
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    return allKeys;
}

- (NSArray *)yy_descendingComparedAllKeys
{
    NSArray *allKeys = [self keysSortedByValueUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 integerValue] < [obj2 integerValue])
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        if ([obj1 integerValue] > [obj2 integerValue])
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    return allKeys;
}

@end
