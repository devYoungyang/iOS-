//
//  UINavigationBar+ChangeColor.h
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/18.
//  Copyright © 2018年 Yang. All rights reserved.
//
//

#import <objc/runtime.h>
#import "UINavigationBar+ChangeColor.h"
static void *colorKey =  "colorKey";
static void *underLineKey = "underLineKey";
@implementation UINavigationBar (ChangeColor)

- (void)start {
    
    self.translucent = YES;
    UIImageView *shadowImg = [self seekLineImageViewOn:self];
    shadowImg.hidden = YES;
}

- (void)reset {
    
    self.translucent = NO;
    UIImageView *shadowImg = [self seekLineImageViewOn:self];
    shadowImg.hidden = NO;
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

- (void)changeColor:(UIColor *)color withOffsetY:(CGFloat)offsetY {
    
    if (offsetY < 0) {
        
        //下拉时导航栏隐藏
//        self.hidden = YES;
    }else {
        
        self.hidden = NO;
        //计算透明度，180为随意设置的偏移量临界值
        CGFloat alpha = offsetY / 180 > 1.0f ? 1 : (offsetY / 180);
        
        //设置一个颜色并转化为图片
        UIImage *image = [UIImage imageWithColor:[color colorWithAlphaComponent:alpha]];
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
        self.translucent = alpha >= 1.0f ? NO : YES;
    }
}

//寻找导航栏下的横线
- (UIImageView *)seekLineImageViewOn:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) return (UIImageView *)view;

    for (UIView *subview in view.subviews) {

        UIImageView *imageView = [self seekLineImageViewOn:subview];
        if (imageView) return imageView;
    }
    return nil;
}

-(void)setBgColor:(UIColor *)bgColor{
    objc_setAssociatedObject(self, colorKey, bgColor, OBJC_ASSOCIATION_COPY);
    [self setBackgroundImage:[UIImage imageWithColor:bgColor] forBarMetrics:UIBarMetricsDefault];
}
-(UIColor *)bgColor{
   return objc_getAssociatedObject(self, colorKey);
}

-(BOOL)hideNavigationBarUnderLine{
    return [objc_getAssociatedObject(self, underLineKey) boolValue];
}

-(void)setHideNavigationBarUnderLine:(BOOL)hideNavigationBarUnderLine{
    if (hideNavigationBarUnderLine) {
        [self setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
    }
    objc_setAssociatedObject(self, underLineKey, @(hideNavigationBarUnderLine), OBJC_ASSOCIATION_ASSIGN);
}
@end


@implementation UIImage (color)

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
@end
