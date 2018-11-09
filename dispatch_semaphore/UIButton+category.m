//
//  UIButton+category.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/16.
//  Copyright © 2018年 Yang. All rights reserved.
//
#import <objc/runtime.h>
#import "UIButton+category.h"
static void * buttonKey="buttonKey";
@implementation UIButton (category)

//重写此方法 扩大按钮响应范围
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    [super pointInside:point withEvent:event];
    CGRect bounds = self.bounds;
    bounds = CGRectInset(bounds, -10, -10);
    return CGRectContainsPoint(bounds, point);
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint currentP=[touch locationInView:self];
    CGPoint previousP=[touch previousLocationInView:self];
    self.transform=CGAffineTransformTranslate(self.transform, currentP.x-previousP.x, currentP.y-previousP.y);
}

-(void)addAction:(ClickedButtonCallBack)callBack{
    objc_setAssociatedObject(self, buttonKey, callBack, OBJC_ASSOCIATION_COPY);
    [self addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clickedButton:(UIButton *)btn{
    ClickedButtonCallBack block=objc_getAssociatedObject(self, buttonKey);
    block(btn);
}
@end
