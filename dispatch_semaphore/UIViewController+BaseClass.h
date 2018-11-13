//
//  UIViewController+BaseClass.h
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/18.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClikedBarButtonItemCallBack)(void);
@interface UIViewController (BaseClass)

/**
 状态栏颜色
 */
@property (nonatomic,copy)UIColor *statusBarColor;

/**
 背景图片
 */
@property (nonatomic,copy)NSString *backGroundImageName;

/**
 导航栏是否存在
 */
@property (readonly,assign)BOOL existNavigationBar;

/**
 是否隐藏导航栏
 */
@property (nonatomic,assign)BOOL hideNavigationBar;

/**
 是否隐藏导航栏下划线
 */
@property (nonatomic,assign)BOOL hideNavigationBarUnderLine;

/**
 在滚动的时候是否隐藏导航栏
 */
@property (nonatomic,assign)BOOL hidesBarsOnScroll;

/**
 键盘弹出的时候是否隐藏导航栏
 */
@property (nonatomic,assign)BOOL hidesBarsWhenKeyboardAppear;

/**
 点击控制器的时候是否隐藏导航栏
 */
@property (nonatomic,assign)BOOL hidesBarsOnTapVC;

/**
 屏幕方向改变时是否隐藏导航栏
 */
@property (nonatomic,assign)BOOL hidesBarsWhenVerticallyCompact;



/**
 设置返回按钮
 */
-(void)setBackButtonWithDefaultImage;//这种方法在返回到那个控制器中设置好使

-(void)setHideBackButton:(BOOL) hideBackButton;
/**
 自定义返回按钮图片

 @param imageName 图片
 */
-(void)setBackButtonWithImageName:(NSString *)imageName;

/**
 设置导航栏

 @param title 导航栏标题
 @param leftTitle 左按钮标题
 @param leftImageName 左按钮图片名称
 @param leftCallBack 点击左按钮的回调
 @param rightTitle 右按钮标题
 @param rightImage 右按钮图片名称
 @param rightCallBack 点击右按钮的回调
 */
-(void)setNavigationBarTitle:(NSString *)title leftNavigationItemTitle:(NSString *) leftTitle leftNavigationItemImage:(NSString *)leftImageName andClickedLeftNavigationItemCallBack:(ClikedBarButtonItemCallBack) leftCallBack rightNavigationItemTitle:(NSString *)rightTitle rightNavigationItemImage:(NSString *)rightImage andClickedNavigationItemCallBack:(ClikedBarButtonItemCallBack)rightCallBack;

/**
 设置导航栏的颜色

 @param color 颜色
 */
-(void)setNavigationBarWithColor:(UIColor *)color;

/**
 设置导航栏标题颜色

 @param titleColor 颜色
 */
-(void)setNavigationItemTitleColor:(UIColor *)titleColor;

/**
 设置导航栏左右按钮的颜色

 @param titleColor 颜色
 */
-(void)setLeftAndRightNavigationItemTitleColor:(UIColor *)titleColor;

@end
