//
//  NSObject+swizzled.h
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/22.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (swizzled)


/**
 黑魔法交换对象方法

 @param originalSel 原始方法
 @param swizzledSel 要交换的方法
 */
+ (void)swizzleInstanceSelector:(SEL)originalSel
           WithSwizzledSelector:(SEL)swizzledSel;

/**
 黑魔法交换类方法

 @param originalSel 原始方法
 @param swizzledSel 要交换的方法
 */
+(void)swizzleClassSelector:(SEL)originalSel WithSwizzledSelector:(SEL)swizzledSel;

/**
 获取模型所有的属性（分类属性获取不到）

 @return 模型的属性数组
 */
+(NSArray *)getAllOfPropertys;


/**
 获取模型的属性和键值（分类属性获取不到）

 @return 模型的属性字典
 */
-(NSDictionary *)getAllOfPropertysAndPropertyValues;

@end
