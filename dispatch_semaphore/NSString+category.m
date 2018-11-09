//
//  NSString+category.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/19.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "NSString+category.h"

@implementation NSString (category)
-(BOOL)isEmpty{
    if (!self) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!self.length) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [self stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}
@end
