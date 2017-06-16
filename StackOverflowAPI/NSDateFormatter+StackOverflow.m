//
//  NSDateFormatter+StackOverflow.m
//  StackOverflowAPI
//
//  Created by Vladislav on 22.04.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import "NSDateFormatter+StackOverflow.h"

@implementation NSDateFormatter (StackOverflow)

+ (instancetype)soDateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
    return dateFormatter;
}

@end
