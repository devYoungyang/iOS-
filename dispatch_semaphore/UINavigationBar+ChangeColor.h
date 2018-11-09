//
//  UINavigationBar+ChangeColor.h
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/18.
//  Copyright © 2018年 Yang. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (ChangeColor)

/**
 *  设置导航栏
 */
- (void)start;

/**
 *  还原导航栏
 */
- (void)reset;

/**
 *  @param color 最终显示颜色
 *  @param offsetY 滑动视图水平偏移量
 */
- (void)changeColor:(UIColor *)color withOffsetY:(CGFloat)offsetY;


/**
    param bgColor 导航栏背景颜色
 */
@property (nonatomic,strong)UIColor *bgColor;

/**
    是否隐藏导航栏底部的下划线，默认为NO不隐藏
 */
@property (nonatomic,assign)BOOL hideNavigationBarUnderLine;

@end


@interface UIImage (color)

// 传[UIColor clearColor]可使导航栏透明
+(UIImage *)imageWithColor:(UIColor *)color;

@end
