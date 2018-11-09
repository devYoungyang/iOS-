//
//  UIView+CornerRadius.m
//  CZDemo
//
//  Created by YY on 2018/4/23.
//  Copyright © 2018年 YY. All rights reserved.
//

#import "UIView+CornerRadius.h"
#import <objc/runtime.h>
@implementation UIView (CornerRadius)

-(void)yy_setCornerRadius:(CGFloat) radius{
    [self yy_setCornerRadius:radius borderColor:nil AndBorderWidth:0];
    
}
-(void)yy_setCornerRadiusByRoundingCorners:(UIRectCorner) corner andRadius:(CGFloat) radius{
    UIBezierPath *maskPath=[UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer=[[CAShapeLayer alloc] init];
    maskLayer.frame=self.bounds;
    maskLayer.path=maskPath.CGPath;
    self.layer.mask=maskLayer;
}

-(NSNumber *)yy_cornerRadius{
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setYy_cornerRadius:(NSNumber *)yy_cornerRadius{
    objc_setAssociatedObject(self, @selector(yy_cornerRadius), yy_cornerRadius, OBJC_ASSOCIATION_COPY);
    [self yy_setCornerRadius:[yy_cornerRadius floatValue]];
}


-(void)yy_setCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor AndBorderWidth:(CGFloat)borderWidth{
    CGSize viewSize = self.frame.size;
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = borderColor.CGColor;
    shapeLayer.lineWidth = borderWidth;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, viewSize.width, viewSize.height) cornerRadius:radius];
    shapeLayer.path = path.CGPath;
    maskLayer.path = path.CGPath;
    [self.layer insertSublayer:shapeLayer atIndex:0];
    [self.layer setMask:maskLayer];
}

-(void)yy_setCornerRadiusByRoundingCorners:(UIRectCorner) corner andRadius:(CGFloat) radius borderColor:(UIColor *)borderColor AndBorderWidth:(CGFloat)borderWidth{
    CGSize viewSize = self.frame.size;
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = borderColor.CGColor;
    shapeLayer.lineWidth = borderWidth;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, viewSize.width, viewSize.height) byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    shapeLayer.path = path.CGPath;
    maskLayer.path = path.CGPath;
    [self.layer insertSublayer:shapeLayer atIndex:0];
    [self.layer setMask:maskLayer];
}
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (UIViewController *)currentViewController
{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
        
    } while (next != nil);
    return nil;
}
@end
