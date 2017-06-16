//
//  SOAnswer.h
//  StackOverflowAPI
//
//  Created by Vladislav on 15.04.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+StackOverflow.h"

@interface SOAnswer : NSObject

@property (strong, nonatomic) NSString *bodyTextAnswer;
@property (strong, nonatomic) NSString *lastActivityDateAnswer;
@property (strong, nonatomic) NSString *autorAnswer;
@property (strong, nonatomic) NSNumber *scoreAnswer;
@property (strong, nonatomic) NSString *isAccepted;
@property (strong, nonatomic) NSMutableAttributedString *detailAttributedBodyAnswer;

- (instancetype)initWithAutorAnswer:(NSString *)autor andBodyTextAnswer:(NSString *)bodyText andLastActivityDateAnswer:(NSNumber *)date andScoreAnswer:(NSNumber *)score andIsAccepted:(NSString *)isAccepted;

@end
