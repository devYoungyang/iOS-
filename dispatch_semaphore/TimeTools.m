//
//  TimeTools.m
//  MXSchedule
//
//  Created by YY on 2018/8/24.
//  Copyright © 2018年 YY. All rights reserved.
//
#import <objc/runtime.h>
#import "TimeTools.h"

@implementation TimeTools

+ (NSString *)getNowDateTimeString {
    NSDate * date = [NSDate date];
    NSTimeInterval a = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

+(NSString *)getNowDateStringWithDateFormatter:(NSString *)dateFormatter{
    return [self getNowDateStringWithDate:[NSDate date] andDateFormatter:dateFormatter];
}

+(NSString *)getCurrentWeek{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDateComponents *component=[calendar components:NSCalendarUnitWeekOfYear fromDate:[NSDate date]];
    return [NSString stringWithFormat:@"%li",(long)[component weekOfYear]];
}

+(NSInteger)numberOfDaysInMonth{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSRange range=[calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    return range.length;
}

+(NSInteger)numberOfDaysInTheMonth:(NSString *)theDate{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"]; // 年-月
    NSDate * date = [formatter dateFromString:theDate];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit: NSCalendarUnitMonth
                                  forDate:date];
    return range.length;
}

+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month{
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}

+(NSString *)getNowDateStringWithDate:(NSDate *)date andDateFormatter:(NSString *)dateFormatter{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    if (dateFormatter==nil) {
        dateFormatter=@"yyyy-MM-dd HH:mm";
    }
    [formatter setDateFormat:dateFormatter];
    return [formatter stringFromDate:date];
}

+(NSArray *)getAllOfPropertysWithModel:(id)model{
    NSMutableArray *allArr=[NSMutableArray array];
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([model class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        ivarName = [ivarName substringFromIndex:1];
        [allArr addObject:ivarName];
    }
    free(ivarList);
    return allArr;
}

+(NSDictionary *)getAllOfPropertysAndPropertyValueWithModel:(id)model{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([model class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        ivarName = [ivarName substringFromIndex:1];
        id value=[model valueForKey:ivarName];
        [dict setObject:value forKey:ivarName];
    }
    free(ivarList);
    return dict;
}

+(NSString *)getTimeStampWithDate:(NSString *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *lastTime =date;
    NSDate *time = [formatter dateFromString:lastTime];
    long stamp = [time timeIntervalSince1970];
    return [NSString stringWithFormat:@"%li",stamp];
}

+(NSString *)getDateStringWithTimeStamp:(NSString *)timeStamp dateFormatter:(NSString *)dateFormatter{
    return [self getNowDateStringWithDate:[NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]] andDateFormatter:dateFormatter];
}













@end
