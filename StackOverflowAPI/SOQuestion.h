//
//  SOQuestion.h
//  StackOverflowAPI
//
//  Created by Vladislav on 11.04.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+StackOverflow.h"

@interface SOQuestion : NSObject

@property (strong, nonatomic) NSString *autorQuestion;
@property (strong, nonatomic) NSString *lastEditDateQuestion;
@property (strong, nonatomic) NSNumber *answerCountQuestion;
@property (strong, nonatomic) NSString *titleQuestion;
@property (strong, nonatomic) NSNumber *idQuestion;
@property (strong, nonatomic) NSString *bodyTextQuestion;
@property (strong, nonatomic) NSNumber *scoreQuestion;

@property (strong, nonatomic) NSMutableAttributedString *detailAttributedBody;

- (void)printQuestion;
- (instancetype)initWithAutor:(NSString *)autor andDate:(NSNumber *)editDate andCount:(NSNumber *)answerCount andTitle:(NSString *)title andId:(NSNumber *)idQuestion andBodyText:(NSString *)bodyText andScore:(NSNumber *)score;

@end
