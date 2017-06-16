//
//  SOConnection.h
//  StackOverflowAPI
//
//  Created by Vladislav on 12.04.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOConnection : NSObject

@property (strong, nonatomic) NSMutableArray *questions;
@property (strong, nonatomic) NSMutableArray *answers;
@property (strong, nonatomic) NSURLSessionDataTask *dataTask;

- (void)connectFromMainTableToAPIWithTag:(NSString *)tag andPage:(int)page andBlock:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionBlock;
- (NSMutableArray *)connectFromDetailTableToAPIWithIdQuestion:(NSNumber *)idQuestion;

@end
