//
//  NSString+StackOverflow.h
//  StackOverflowAPI
//
//  Created by Vladislav on 10.05.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDateFormatter+StackOverflow.h"

@interface NSString (StackOverflow)

+ (NSString *)soModifiedStringFromDate:(NSDate *)date;
+ (NSString *)soModifiedStringWithDateComponentsFormattersFromDate:(NSDate *)date;

@end
