//
//  NSObject+swizzled.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/22.
//  Copyright © 2018年 Yang. All rights reserved.
//
#import <objc/runtime.h>
#import "NSObject+swizzled.h"

@implementation NSObject (swizzled)

+ (void)swizzleInstanceSelector:(SEL)originalSel
           WithSwizzledSelector:(SEL)swizzledSel {
    
    Method originMethod = class_getInstanceMethod(self, originalSel);
    Method swizzedMehtod = class_getInstanceMethod(self, swizzledSel);
    BOOL methodAdded = class_addMethod(self, originalSel, method_getImplementation(swizzedMehtod), method_getTypeEncoding(swizzedMehtod));
    if (methodAdded) {
        class_replaceMethod(self, swizzledSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzedMehtod);
    }
}
+(void)swizzleClassSelector:(SEL)originalSel WithSwizzledSelector:(SEL)swizzledSel{
    Method originMethod = class_getClassMethod([self class], originalSel);
    Method swizzedMehtod = class_getInstanceMethod([self class], swizzledSel);
    BOOL methodAdded = class_addMethod(self, originalSel, method_getImplementation(swizzedMehtod), method_getTypeEncoding(swizzedMehtod));
    
    if (methodAdded) {
        class_replaceMethod(self, swizzledSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzedMehtod);
    }
}
// 内联函数
static inline void swizzledClassSelector(Class theClass,SEL originSel,SEL swizzledSel){
    Method originMethod = class_getClassMethod(theClass, originSel);
    Method swizzedMehtod = class_getInstanceMethod(theClass, swizzledSel);
    BOOL methodAdded = class_addMethod(theClass, originSel, method_getImplementation(swizzedMehtod), method_getTypeEncoding(swizzedMehtod));
    
    if (methodAdded) {
        class_replaceMethod(theClass, swizzledSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzedMehtod);
    }
}

static inline void swizzledInstanceSelector(id instace,SEL originSel,SEL swizzledSel){
    Method originMethod = class_getInstanceMethod(instace, originSel);
    Method swizzedMehtod = class_getInstanceMethod(instace, swizzledSel);
    BOOL methodAdded = class_addMethod(instace, originSel, method_getImplementation(swizzedMehtod), method_getTypeEncoding(swizzedMehtod));
    if (methodAdded) {
        class_replaceMethod(instace, swizzledSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzedMehtod);
    }
}


+(NSArray *)getAllOfPropertys{
    NSMutableArray *allArr=[NSMutableArray array];
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        ivarName = [ivarName substringFromIndex:1];
        [allArr addObject:ivarName];
    }
    free(ivarList);
    return allArr;
}

-(NSDictionary *)getAllOfPropertysAndPropertyValues{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        ivarName = [ivarName substringFromIndex:1];
        id value=[self valueForKey:ivarName];
        [dict setObject:value forKey:ivarName];
    }
    free(ivarList);
    return dict;
}
@end
