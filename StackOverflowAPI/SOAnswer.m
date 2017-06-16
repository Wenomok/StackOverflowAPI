//
//  SOAnswer.m
//  StackOverflowAPI
//
//  Created by Vladislav on 15.04.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import "SOAnswer.h"

@implementation SOAnswer

- (instancetype)initWithAutorAnswer:(NSString *)autor andBodyTextAnswer:(NSString *)bodyText andLastActivityDateAnswer:(NSNumber *)date
                     andScoreAnswer:(NSNumber *)score andIsAccepted:(NSString *)isAccepted
{
    self = [super init];
    if(self) {
        NSDate *dateWithInterval = [NSDate dateWithTimeIntervalSince1970:date.doubleValue];
        
        // Использовал другой способ задания умной даты, оба рабочие
//        self.lastActivityDateAnswer = [NSString soModifiedStringFromDate:dateWithInterval];
        self.lastActivityDateAnswer = [NSString soModifiedStringWithDateComponentsFormattersFromDate:dateWithInterval];
        self.autorAnswer = autor;
        self.bodyTextAnswer = bodyText;
        self.scoreAnswer = score;
        self.isAccepted = isAccepted;
    }
    return self;
}

@end
