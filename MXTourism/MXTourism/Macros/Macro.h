//
//  Macro.h
//  MXSchedule
//
//  Created by YY on 2018/8/24.
//  Copyright © 2018年 YY. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define mx_weakify(var)   __weak typeof(var) weakSelf = var
/* 适配 */
#define scaleWithSize(s) ((s) * (screen_width / 375))

#define UI_IS_IPHONE            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define UI_IS_IPHONEX (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0)
//状态栏高度
#define STATUS_HEIGHT (UI_IS_IPHONEX ? 44: 20)
//iphoneX底部
//#define iPhoneXBottomHeight 34
//导航栏+状态栏 高度
#define STATUS_AND_NAVIGATION_HEIGHT (STATUS_HEIGHT + 44)
//tabbar高度
#define TABBAR_HEIGHT (UI_IS_IPHONEX ? 83: 49)
//底部高度
#define TABBAR_FRAME (UI_IS_IPHONEX ? 34: 0)
//导航栏+状态栏+tabbar高度
#define STATUS_TABBAR_NAVIGATION_HEIGHT (STATUS_AND_NAVIGATION_HEIGHT + TABBAR_HEIGHT)


#define MainScreenW [UIScreen mainScreen].bounds.size.width
#define MainScreenH [UIScreen mainScreen].bounds.size.height

#define BaseUrl @"https://120.76.205.241/sight/ctrip"

#ifdef DEBUG
#define YANGLog(format, ...) printf(" %s [第%d行] \n%s\n",__PRETTY_FUNCTION__,__LINE__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define YANGLog(format, ...)
#endif

#endif /* Macro_h */
