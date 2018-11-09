//
//  TimeTools.h
//  MXSchedule
//
//  Created by YY on 2018/8/24.
//  Copyright © 2018年 YY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeTools : NSObject

+ (NSString *)getNowDateTimeString;

+(NSString *)getNowDateStringWithDateFormatter:(NSString *)dateFormatter;

+(NSString *)getNowDateStringWithDate:(NSDate *)date andDateFormatter:(NSString *)dateFormatter;

+(NSString *)getCurrentWeek;

+(NSInteger)numberOfDaysInMonth;

+(NSInteger)numberOfDaysInTheMonth:(NSString *)theDate;

+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;

+(NSArray *)getAllOfPropertysWithModel:(id)model;

+(NSDictionary *)getAllOfPropertysAndPropertyValueWithModel:(id)model;


@end
