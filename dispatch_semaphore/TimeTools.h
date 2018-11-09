//
//  TimeTools.h
//  MXSchedule
//
//  Created by YY on 2018/8/24.
//  Copyright © 2018年 YY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeTools : NSObject

/**
 获取当前时间戳字符串

 @return 当前时间戳字符串
 */
+ (NSString *)getNowDateTimeString;

/**
 获取日期字符串

 @param dateFormatter yyyy-MM-dd
 @return 日期字符串
 */
+(NSString *)getNowDateStringWithDateFormatter:(NSString *)dateFormatter;

/**
 日期转时间字符串

 @param date 日期
 @param dateFormatter 日期格式
 @return 时间
 */
+(NSString *)getNowDateStringWithDate:(NSDate *)date andDateFormatter:(NSString *)dateFormatter;

/**
 获取第几周

 @return 周
 */
+(NSString *)getCurrentWeek;

/**
 本月第几天
 @return 本月第几天
 */
+(NSInteger)numberOfDaysInMonth;

/**
 此月多少天
 */
+(NSInteger)numberOfDaysInTheMonth:(NSString *)theDate;

+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;

+(NSArray *)getAllOfPropertysWithModel:(id)model;

+(NSDictionary *)getAllOfPropertysAndPropertyValueWithModel:(id)model;


/**
 日期转换成时间戳
 @param date 日期
 @return 时间戳
 */
+(NSString *)getTimeStampWithDate:(NSString *)date;


/**
 时间戳转换成日期
 @param timeStamp 时间戳
 @param dateFormatter 日期格式
 @return 日期
 */
+(NSString *)getDateStringWithTimeStamp:(NSString *)timeStamp dateFormatter:(NSString *)dateFormatter;

@end
