//
//  UIViewController+BaseClass.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/18.
//  Copyright © 2018年 Yang. All rights reserved.
//
#import "NSString+category.h"
#import <objc/runtime.h>
static void *underLineKey = "underLineKey";
static void *bgImageName=@"bgImageName";
static void *statusBarColorKey=@"statusBarColorKey";
static void *existNavigationBarKey=@"existNavigationBar";
static void *leftNavigationItemKey=@"leftNavigationItemKey";
static void *rightNavigationItemKey=@"rightNavigationItemKey";
static void *hideNavigationBarKey =@"hideNavigationBarKey";
static void *hidesBarsOnScrollKey=@"hidesBarsOnScrollKey";
static void *hidesBarsWhenKeyboardAppearKey =@"hidesBarsWhenKeyboardAppearKey";
static void *hidesBarsOnTapVCKey=@"hidesBarsOnTapVCKey";
static void *hidesBarsWhenVerticallyCompactKey =@"hidesBarsWhenVerticallyCompactKey";
#import "UIViewController+BaseClass.h"

@implementation UIViewController (BaseClass)

-(void)setStatusBarColor:(UIColor *)statusBarColor{
    [self setStatusBarBackgroundColor:statusBarColor];
    objc_setAssociatedObject(self, statusBarColorKey, statusBarColor, OBJC_ASSOCIATION_COPY);
}
-(UIColor *)statusBarColor{
    return objc_getAssociatedObject(self, statusBarColorKey);
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

-(NSString *)backGroundImageName{
    return objc_getAssociatedObject(self, bgImageName);
}

-(BOOL)existNavigationBar{
    if (self.navigationController&&[self.navigationController isKindOfClass:[UINavigationController class]]) {
        return YES;
    }else{
        return NO;
    }
    return [objc_getAssociatedObject(self, existNavigationBarKey) boolValue];
}
-(void)setExistNavigationBar:(BOOL)existNavigationBar{
    objc_setAssociatedObject(self, existNavigationBarKey, @(existNavigationBar), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)hidesBarsOnScroll{
    return objc_getAssociatedObject(self, hidesBarsOnScrollKey);
}
-(void)setHidesBarsOnScroll:(BOOL)hidesBarsOnScroll{
    if (self.navigationController&&[self.navigationController isKindOfClass:[UINavigationController class]]) {
        self.navigationController.hidesBarsOnSwipe=hidesBarsOnScroll;
    }
    objc_setAssociatedObject(self, hidesBarsOnScrollKey, @(hidesBarsOnScroll), OBJC_ASSOCIATION_COPY);
}

-(BOOL)hidesBarsWhenKeyboardAppear{
    return objc_getAssociatedObject(self, hidesBarsWhenKeyboardAppearKey);
}
-(void)setHidesBarsWhenKeyboardAppear:(BOOL)hidesBarsWhenKeyboardAppear{
    if (self.navigationController&&[self.navigationController isKindOfClass:[UINavigationController class]]) {
        self.navigationController.hidesBarsWhenKeyboardAppear=hidesBarsWhenKeyboardAppear;
    }
    objc_setAssociatedObject(self, hidesBarsWhenKeyboardAppearKey, @(hidesBarsWhenKeyboardAppear), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)hidesBarsOnTapVC{
    return objc_getAssociatedObject(self, hidesBarsOnTapVCKey);
}
-(void)setHidesBarsOnTapVC:(BOOL)hidesBarsOnTapVC{
    if (self.navigationController&&[self.navigationController isKindOfClass:[UINavigationController class]]) {
        self.navigationController.hidesBarsOnTapVC=hidesBarsOnTapVC;
    }
    objc_setAssociatedObject(self, hidesBarsOnTapVCKey, @(hidesBarsOnTapVC), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)hidesBarsWhenVerticallyCompact{
    return objc_getAssociatedObject(self, hidesBarsWhenVerticallyCompactKey);
}
-(void)setHidesBarsWhenVerticallyCompact:(BOOL)hidesBarsWhenVerticallyCompact{
    if (self.navigationController&&[self.navigationController isKindOfClass:[UINavigationController class]]) {
        self.navigationController.hidesBarsWhenVerticallyCompact=hidesBarsWhenVerticallyCompact;
    }
    objc_setAssociatedObject(self, hidesBarsWhenVerticallyCompactKey, @(hidesBarsWhenVerticallyCompact), OBJC_ASSOCIATION_ASSIGN);
}

-(void)setBackGroundImageName:(NSString *)backGroundImageName{
    UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    if ([backGroundImageName hasPrefix:@"https"]||[backGroundImageName hasPrefix:@"http"]) {
//        [bgImageView sd_setImageWithURL:[NSURL URLWithString:backGroundImageName]];
    }else{
        bgImageView.image=[UIImage imageNamed:backGroundImageName];
    }
    bgImageView.contentMode=UIViewContentModeScaleAspectFill;
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    objc_setAssociatedObject(self, bgImageName, backGroundImageName, OBJC_ASSOCIATION_COPY);
}

-(void)setBackButtonWithDefaultImage{
    [self setBackButtonTitle:@" " andImage:@""];
}
-(void)setBackButtonWithImageName:(NSString *)imageName
{
    [self setBackButtonTitle:@"" andImage:imageName];
}
-(void)setBackButtonTitle:(NSString *)title andImage:(NSString *)imageName{
    if (self.existNavigationBar&&!self.hideNavigationBar) {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        backItem.title = title;
        self.navigationItem.backBarButtonItem=backItem;
        if (![imageName isEmpty]) {
            self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:imageName];
            self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:imageName];
        }
    }
    /**
     UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
     [backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
     [backButton setTitle:title forState:UIControlStateNormal];
     [backButton addTarget:self action:@selector(backItemClicked) forControlEvents:UIControlEventTouchUpInside];
     UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
     self.navigationItem.leftBarButtonItem = backItem;
     //这个方法失去手势返回功能,当前页面设置
     **/
}

-(void)setNavigationBarTitle:(NSString *)title leftNavigationItemTitle:(NSString *) leftTitle leftNavigationItemImage:(NSString *)leftImageName andClickedLeftNavigationItemCallBack:(ClikedBarButtonItemCallBack) leftCallBack rightNavigationItemTitle:(NSString *)rightTitle rightNavigationItemImage:(NSString *)rightImage andClickedNavigationItemCallBack:(ClikedBarButtonItemCallBack)rightCallBack{
    if (self.existNavigationBar&&!self.hideNavigationBar) {
        self.navigationItem.title=title;
        UIBarButtonItem *leftNavigationItem=nil;
        UIBarButtonItem *rightNavigationItem=nil;
        if (![leftTitle isEmpty]&&[leftImageName isEmpty]) {
            leftNavigationItem=[[UIBarButtonItem alloc] initWithTitle:leftTitle style:UIBarButtonItemStyleDone target:self action:@selector(clickedLeftNavigationItem)];
        }else if (![leftImageName isEmpty]&&[leftTitle isEmpty]){
            leftNavigationItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:leftImageName] style:UIBarButtonItemStyleDone target:self action:@selector(clickedLeftNavigationItem)];
        }
        objc_setAssociatedObject(self, leftNavigationItemKey, leftCallBack, OBJC_ASSOCIATION_COPY);
        if (![rightTitle isEmpty]&&[rightImage isEmpty]) {
            rightNavigationItem=[[UIBarButtonItem alloc] initWithTitle:rightTitle style:UIBarButtonItemStyleDone target:self action:@selector(clickedRightNavigationItem)];
        }else if (![rightImage isEmpty]&&[rightTitle isEmpty]){
            rightNavigationItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:rightImage] style:UIBarButtonItemStyleDone target:self action:@selector(clickedRightNavigationItem)];
        }
        objc_setAssociatedObject(self, rightNavigationItemKey, rightCallBack, OBJC_ASSOCIATION_COPY);
        self.navigationItem.leftBarButtonItem=leftNavigationItem;
        self.navigationItem.rightBarButtonItem=rightNavigationItem;
    }
}
-(void)clickedLeftNavigationItem{
    ClikedBarButtonItemCallBack block=objc_getAssociatedObject(self, leftNavigationItemKey);
    block();
};
-(void)clickedRightNavigationItem{
    ClikedBarButtonItemCallBack block=objc_getAssociatedObject(self, rightNavigationItemKey);
    block();
}
-(void)setNavigationBarWithColor:(UIColor *)color{
    if (self.existNavigationBar&&!self.hideNavigationBar) {
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    }
}
-(void)setLeftAndRightNavigationItemTitleColor:(UIColor *)titleColor{
    if (self.existNavigationBar&&!self.hideNavigationBar) {
        [self.navigationController.navigationBar setTintColor:titleColor];
    }
}
-(void)setNavigationItemTitleColor:(UIColor *)titleColor{
    if (self.existNavigationBar&&!self.hideNavigationBar) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    }
}
-(BOOL)hideNavigationBarUnderLine{
    return [objc_getAssociatedObject(self, underLineKey) boolValue];
}

-(void)setHideNavigationBarUnderLine:(BOOL)hideNavigationBarUnderLine{
    if (self.existNavigationBar&&!self.hideNavigationBar) {
        if (hideNavigationBarUnderLine) {
            [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
        }
    }
    objc_setAssociatedObject(self, underLineKey, @(hideNavigationBarUnderLine), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)hideNavigationBar{
    return objc_getAssociatedObject(self, hideNavigationBarKey);
}
-(void)setHideNavigationBar:(BOOL)hideNavigationBar{
    if (self.existNavigationBar&&!self.hideNavigationBar) {
//        self.navigationController.navigationBar.hidden=hideNavigationBar;
        [self.navigationController setNavigationBarHidden:hideNavigationBar animated:YES];
    }
    objc_setAssociatedObject(self, hideNavigationBarKey, @(hideNavigationBar), OBJC_ASSOCIATION_ASSIGN);
}
-(UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect=CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(void)setHideBackButton:(BOOL)hideBackButton{
    if (hideBackButton==YES) {
        [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    }else{
        
    }
    
}
@end
