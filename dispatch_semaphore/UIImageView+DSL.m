//
//  UIImageView+DSL.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/19.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "UIImageView+DSL.h"

@implementation UIImageView (DSL)

- (UIImageView* (^)(UIImage *))DSL_image {
    weak_Self;
    return ^UIImageView *(UIImage *image) {
        strong_Self;
        strongSelf.image = image;
        return strongSelf;
    };
}
- (UIImageView* (^)(UIImage *))DSL_HighlightedImage {
    weak_Self;
    return ^UIImageView *(UIImage *highlightedImage) {
        strong_Self;
        strongSelf.highlightedImage = highlightedImage;
        return self;
    };
}
- (UIImageView* (^)(BOOL))DSL_UserInteractionEnabled {
    weak_Self;
    return ^UIImageView *(BOOL userInteractionEnabled) {
        strong_Self;
        strongSelf.userInteractionEnabled = userInteractionEnabled;
        return strongSelf;
    };
}
@end
