//
//  UIButton+category.h
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/16.
//  Copyright © 2018年 Yang. All rights reserved.
//
@class UIButton;

typedef void (^ClickedButtonCallBack)(UIButton *button);

#import <UIKit/UIKit.h>

@interface UIButton (category)

-(void)addAction:(ClickedButtonCallBack) callBack;

@end
