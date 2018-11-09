//
//  UIImageView+DSL.h
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/19.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DSL)

- (UIImageView* (^)(CGRect))DSL_frame;
- (UIImageView* (^)(UIColor *))DSL_backgroundColor;

- (UIImageView* (^)(UIImage *))DSL_image;
- (UIImageView* (^)(UIImage *))DSL_HighlightedImage;
- (UIImageView* (^)(BOOL))DSL_UserInteractionEnabled;
//- (UIImageView* (^)(BOOL))DSL_highlighted;
//- (UIImageView* (^)(NSArray <UIImage *> *))DSL_AnimationImages;
//- (UIImageView* (^)(NSArray <UIImage *> *))DSL_HighlightedAnimationImages;
//- (UIImageView* (^)(NSTimeInterval))DSL_AnimationDuration;
//- (UIImageView* (^)(NSInteger))SDL_AnimationRepeatCount;
//- (UIImageView* (^)(UIColor *))DSL_TintColor;

@end
