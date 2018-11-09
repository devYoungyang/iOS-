//
//  UIView+CornerRadius.h
//  CZDemo
//
//  Created by YY on 2018/4/23.
//  Copyright © 2018年 YY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CornerRadius)
//全圆角
-(void)yy_setCornerRadius:(CGFloat) radius;

//某几个角为圆角
-(void)yy_setCornerRadiusByRoundingCorners:(UIRectCorner) corner andRadius:(CGFloat) radius;

//圆角加边框
-(void)yy_setCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor AndBorderWidth:(CGFloat)borderWidth;

//某几个角加边框
-(void)yy_setCornerRadiusByRoundingCorners:(UIRectCorner) corner andRadius:(CGFloat) radius borderColor:(UIColor *)borderColor AndBorderWidth:(CGFloat)borderWidth;

//圆角半径
@property (nonatomic,strong)NSNumber *yy_cornerRadius;


@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat top;

@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat width;

@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;

@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;

@property (nonatomic) CGSize  size;


- (UIViewController *)currentViewController;

@end
