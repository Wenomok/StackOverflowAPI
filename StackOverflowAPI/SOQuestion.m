//
//  SOQuestion.m
//  StackOverflowAPI
//
//  Created by Vladislav on 11.04.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import "SOQuestion.h"

@implementation SOQuestion

- (void)printQuestion
{
    NSLog(@"%@\n%@\n%@\n%@", self.titleQuestion, self.answerCountQuestion, self.lastEditDateQuestion, self.autorQuestion);
}

- (instancetype)initWithAutor:(NSString *)autor andDate:(NSNumber *)editDate andCount:(NSNumber *)count
                     andTitle:(NSString *)title andId:(NSNumber *)idQuestion andBodyText:(NSString *)bodyText
                     andScore:(NSNumber *)score
{
    self = [super init];
    if(self) {
        NSDate *dateWithInterval = [NSDate dateWithTimeIntervalSince1970:editDate.doubleValue];
//        self.lastEditDateQuestion = [NSString soModifiedStringFromDate:dateWithInterval];
        self.lastEditDateQuestion = [NSString soModifiedStringWithDateComponentsFormattersFromDate:dateWithInterval];
        
        self.autorQuestion = autor;
        self.answerCountQuestion = count;
        self.idQuestion = idQuestion;
        self.titleQuestion = title;
        self.bodyTextQuestion = bodyText;
        self.scoreQuestion = score;
    }
    return self;
}

@end
