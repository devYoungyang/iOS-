//
//  UIImage+Color.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/18.
//  Copyright © 2018年 Yang. All rights reserved.
//
#import <objc/runtime.h>
#import "UIImage+Color.h"

@implementation UIImage (Color)

+(UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect=CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(void)load{
    Method originMethod=class_getClassMethod([self class], @selector(imageNamed:));
    Method swizzedMethod=class_getClassMethod([self class], @selector(imageWithOriginName:));
    BOOL methodAdded=class_addMethod(self, @selector(imageWithOriginName:), method_getImplementation(swizzedMethod), method_getTypeEncoding(swizzedMethod));
    if (methodAdded) {
        class_replaceMethod([self class], @selector(imageWithOriginName:), method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzedMethod);
    }
}
+(UIImage *)imageWithOriginName:(NSString *)originName{
    return [[self imageNamed:originName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
