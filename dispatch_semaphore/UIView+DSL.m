//
//  UIView+DSL.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/19.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "UIView+DSL.h"

@implementation UIView (DSL)

- (UIView *(^)(CGRect))DSL_frame {
    weak_Self;
    return ^UIView* (CGRect frame) {
        strong_Self;
        strongSelf.frame = frame;
        return strongSelf;
    };
}

- (UIView *(^)(UIColor *))DSL_backgroundColor {
    weak_Self;
    return ^UIView* (UIColor *backgroundColor) {
        strong_Self;
        strongSelf.backgroundColor = backgroundColor;
        return strongSelf;
    };
}

@end
