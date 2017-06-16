//
//  NSString+StackOverflow.m
//  StackOverflowAPI
//
//  Created by Vladislav on 10.05.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import "NSString+StackOverflow.h"

@implementation NSString (StackOverflow)

+ (NSString *)soModifiedStringFromDate:(NSDate *)date
{
    NSDateComponents *componentsOfLocaleTime = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    NSInteger currentHours = [componentsOfLocaleTime hour];
    NSInteger currentMinutes = [componentsOfLocaleTime minute];
    NSInteger currentSeconds = [componentsOfLocaleTime second];
    
    NSDateComponents *componentsOfQuestionTime = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    NSInteger questionHours = [componentsOfQuestionTime hour];
    NSInteger questionMinutes = [componentsOfQuestionTime minute];
    NSInteger questionSeconds = [componentsOfQuestionTime second];
    
    NSInteger hoursModified = currentHours - questionHours;
    NSInteger minutesModified = currentMinutes - questionMinutes;
    NSInteger secondsModified = currentSeconds - questionSeconds;
    
    NSString *lastEditDateQuestion;
    if(hoursModified < 0) {
        NSDateFormatter *dateFormatter = [NSDateFormatter soDateFormatter];
        lastEditDateQuestion = [dateFormatter stringFromDate:date];
    } else if(hoursModified > 0) {
        lastEditDateQuestion = [NSString stringWithFormat:@"Modified %ld hours", (long)hoursModified];
    } else if(minutesModified > 0) {
        lastEditDateQuestion = [NSString stringWithFormat:@"Modified %ld minutes", (long)minutesModified];
    } else if(secondsModified > 0) {
        lastEditDateQuestion = [NSString stringWithFormat:@"Modified %ld seconds", (long)secondsModified];
    }
    
    return lastEditDateQuestion;
}

+ (NSString *)soModifiedStringWithDateComponentsFormattersFromDate:(NSDate *)date
{
    NSString *lastEditDateQuestion;
    
    NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleShort;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    formatter.calendar = calendar;
    NSString *lastModifiedDate = [formatter stringFromDate:date toDate:[NSDate date]];
    lastEditDateQuestion = [NSString stringWithFormat:@"%@ ago",lastModifiedDate];
    
    return lastEditDateQuestion;
}

@end
