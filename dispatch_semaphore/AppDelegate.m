//
//  AppDelegate.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/9/13.
//  Copyright © 2018年 Yang. All rights reserved.
//
#import "YYAlertViewController.h"
#import "KVOViewController.h"
#import "YYTabBarController.h"
#import "UIImage+Color.h"
#import "BlockViewController(ARC).h"
#import "NextViewController.h"
#import "EndViewController.h"
#import "AppDelegate.h"
#import "GCDViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    NextViewController *endVC=[NextViewController new];
//    UINavigationController *endNav=[[UINavigationController alloc] initWithRootViewController:endVC];
//    endNav.hidesBarsOnSwipe=YES;//滚动隐藏导航栏
//    endNav.hidesBarsWhenKeyboardAppears=YES;//弹出键盘隐藏导航栏
//    endNav.hidesBarsOnTap=YES;//点击控制器隐藏导航栏
//    endNav.hidesBarsWhenVerticallyCompact=YES;//屏幕方向改变隐藏导航栏
//    self.window.rootViewController=endNav;
//    [self.window makeKeyAndVisible];
    
    [JJException configExceptionCategory:JJExceptionGuardAll];
    [JJException startGuardException];
    
    UINavigationController *gcdNav=[[UINavigationController alloc] initWithRootViewController:[YYAlertViewController new]];
    UITabBarItem *gcdItem=[[UITabBarItem alloc] initWithTitle:@"GCD" image:[UIImage imageNamed:@"homepage_un"] selectedImage:[UIImage imageWithOriginName:@"homepage"]];
    gcdNav.tabBarItem=gcdItem;

    UINavigationController *blockNav=[[UINavigationController alloc] initWithRootViewController:[BlockViewController_ARC_ new]];
    UITabBarItem *blockItem=[[UITabBarItem alloc] initWithTitle:@"Block" image:[UIImage imageNamed:@"createtask_un"] selectedImage:[UIImage imageWithOriginName:@"createtask_fill"]];
    blockNav.tabBarItem=blockItem;

    UINavigationController *nextNav=[[UINavigationController alloc] initWithRootViewController:[NextViewController new]];
    UITabBarItem *nextItem=[[UITabBarItem alloc] initWithTitle:@"NEXT" image:[UIImage imageNamed:@"mine_un"] selectedImage:[UIImage imageWithOriginName:@"mine_fill"]];
    nextNav.tabBarItem=nextItem;
    UITabBarController *tabController=[[UITabBarController alloc] init];
    [tabController setViewControllers:@[gcdNav,blockNav,nextNav]];
    self.window.rootViewController=tabController;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
