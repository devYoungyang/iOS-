//

//
//  Created by YY on 16/3/1.
//  Copyright © 2016年 YY. All rights reserved.
//

#import "UIImageView+CornerRadius.h"
#import <objc/runtime.h>

const char kProcessedImage;

@interface UIImageView ()

@property (assign, nonatomic) CGFloat yyRadius;
@property (assign, nonatomic) UIRectCorner roundingCorners;
@property (assign, nonatomic) CGFloat yyBorderWidth;
@property (strong, nonatomic) UIColor *yyBorderColor;
@property (assign, nonatomic) BOOL yyHadAddObserver;
@property (assign, nonatomic) BOOL yyIsRounding;

@end





@implementation UIImageView (CornerRadius)

- (instancetype)initWithRoundingRectImageView {
    self = [super init];
    if (self) {
        [self yy_cornerRadiusRoundingRect];
    }
    return self;
}

- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType {
    self = [super init];
    if (self) {
        [self yy_cornerRadiusAdvance:cornerRadius rectCornerType:rectCornerType];
    }
    return self;
}

- (void)yy_attachBorderWidth:(CGFloat)width color:(UIColor *)color {
    self.yyBorderWidth = width;
    self.yyBorderColor = color;
}

- (void)yy_cornerRadiusWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType {
    CGSize size = self.bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cornerRadii = CGSizeMake(cornerRadius, cornerRadius);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    if (nil == currentContext) {
        return;
    }
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCornerType cornerRadii:cornerRadii];
    [cornerPath addClip];
    [self.layer renderInContext:currentContext];
    [self drawBorder:cornerPath];
    UIImage *processedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (processedImage) {
        objc_setAssociatedObject(processedImage, &kProcessedImage, @(1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.image = processedImage;
}

- (void)yy_cornerRadiusWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType backgroundColor:(UIColor *)backgroundColor {
    CGSize size = self.bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cornerRadii = CGSizeMake(cornerRadius, cornerRadius);
    
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    if (nil == currentContext) {
        return;
    }
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCornerType cornerRadii:cornerRadii];
    UIBezierPath *backgroundRect = [UIBezierPath bezierPathWithRect:self.bounds];
    [backgroundColor setFill];
    [backgroundRect fill];
    [cornerPath addClip];
    [self.layer renderInContext:currentContext];
    [self drawBorder:cornerPath];
    UIImage *processedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (processedImage) {
        objc_setAssociatedObject(processedImage, &kProcessedImage, @(1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.image = processedImage;
}

- (void)yy_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType {
    self.yyRadius = cornerRadius;
    self.roundingCorners = rectCornerType;
    self.yyIsRounding = NO;
    if (!self.yyHadAddObserver) {
        [[self class] swizzleDealloc];
        [self addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        self.yyHadAddObserver = YES;
    }
    //Xcode 8 xib 删除了控件的Frame信息，需要主动创造
    [self layoutIfNeeded];
}

- (void)yy_cornerRadiusRoundingRect {
    self.yyIsRounding = YES;
    if (!self.yyHadAddObserver) {
        [[self class] swizzleDealloc];
        [self addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        self.yyHadAddObserver = YES;
    }
    //Xcode 8 xib 删除了控件的Frame信息，需要主动创造
    [self layoutIfNeeded];
}

#pragma mark - Private
- (void)drawBorder:(UIBezierPath *)path {
    if (0 != self.yyBorderWidth && nil != self.yyBorderColor) {
        [path setLineWidth:2 * self.yyBorderWidth];
        [self.yyBorderColor setStroke];
        [path stroke];
    }
}

- (void)yy_dealloc {
    if (self.yyHadAddObserver) {
        [self removeObserver:self forKeyPath:@"image"];
    }
    [self yy_dealloc];
}

- (void)validateFrame {
    if (self.frame.size.width == 0) {
        [self.class swizzleLayoutSubviews];
    }
}

+ (void)swizzleMethod:(SEL)oneSel anotherMethod:(SEL)anotherSel {
    Method oneMethod = class_getInstanceMethod(self, oneSel);
    Method anotherMethod = class_getInstanceMethod(self, anotherSel);
    method_exchangeImplementations(oneMethod, anotherMethod);
}

+ (void)swizzleDealloc {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:NSSelectorFromString(@"dealloc") anotherMethod:@selector(yy_dealloc)];
    });
}

+ (void)swizzleLayoutSubviews {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(layoutSubviews) anotherMethod:@selector(yy_LayoutSubviews)];
    });
}

- (void)yy_LayoutSubviews {
    [self yy_LayoutSubviews];
    if (self.yyIsRounding) {
        [self yy_cornerRadiusWithImage:self.image cornerRadius:self.frame.size.width/2 rectCornerType:UIRectCornerAllCorners];
    } else if (0 != self.yyRadius && 0 != self.roundingCorners && nil != self.image) {
        [self yy_cornerRadiusWithImage:self.image cornerRadius:self.yyRadius rectCornerType:self.roundingCorners];
    }
}

#pragma mark - KVO for .image
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"image"]) {
        UIImage *newImage = change[NSKeyValueChangeNewKey];
        if ([newImage isMemberOfClass:[NSNull class]]) {
            return;
        } else if ([objc_getAssociatedObject(newImage, &kProcessedImage) intValue] == 1) {
            return;
        }
        [self validateFrame];
        if (self.yyIsRounding) {
            [self yy_cornerRadiusWithImage:newImage cornerRadius:self.frame.size.width/2 rectCornerType:UIRectCornerAllCorners];
        } else if (0 != self.yyRadius && 0 != self.roundingCorners && nil != self.image) {
            [self yy_cornerRadiusWithImage:newImage cornerRadius:self.yyRadius rectCornerType:self.roundingCorners];
        }
    }
}

#pragma mark property
- (CGFloat)yyBorderWidth {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setYyBorderWidth:(CGFloat)yyBorderWidth {
    objc_setAssociatedObject(self, @selector(yyBorderWidth), @(yyBorderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)yyBorderColor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setYyBorderColor:(UIColor *)yyBorderColor {
    objc_setAssociatedObject(self, @selector(yyBorderColor), yyBorderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)yyHadAddObserver {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setYyHadAddObserver:(BOOL)yyHadAddObserver {
    objc_setAssociatedObject(self, @selector(yyHadAddObserver), @(yyHadAddObserver), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)yyIsRounding {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setYyIsRounding:(BOOL)yyIsRounding {
    objc_setAssociatedObject(self, @selector(yyIsRounding), @(yyIsRounding), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIRectCorner)roundingCorners {
    return [objc_getAssociatedObject(self, _cmd) unsignedLongValue];
}

- (void)setRoundingCorners:(UIRectCorner)roundingCorners {
    objc_setAssociatedObject(self, @selector(roundingCorners), @(roundingCorners), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)yyRadius {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setYyRadius:(CGFloat)yyRadius {
    objc_setAssociatedObject(self, @selector(yyRadius), @(yyRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end

