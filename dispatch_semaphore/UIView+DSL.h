//
//  UIView+DSL.h
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/19.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DSL)

- (UIView* (^)(CGRect))DSL_frame;

- (UIView* (^)(UIColor *))DSL_backgroundColor;

@end
