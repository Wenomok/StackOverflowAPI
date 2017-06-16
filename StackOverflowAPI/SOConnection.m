//
//  SOConnection.m
//  StackOverflowAPI
//
//  Created by Vladislav on 12.04.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import "SOConnection.h"
#import "SOQuestion.h"
#import "SOAnswer.h"
#import "GTMNSString+HTML.h"
#import "NSString+HTML.h"
#import "CoreData/CoreData.h"

@implementation SOConnection

- (void)connectFromMainTableToAPIWithTag:(NSString *)tag andPage:(int)page andBlock:(void (^)(NSData *, NSURLResponse *, NSError *))completionBlock
{
//    dispatch_sync(dispatch_get_main_queue(), ^{
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSString *urlConnection = [NSString
                          stringWithFormat:@"https://api.stackexchange.com/2.2/questions?page=%i&pagesize=50&order=desc&sort=activity&tagged=%@&site=stackoverflow&filter=!9YdnSJ*Wh", page, tag];
    NSURLSession *session = [NSURLSession sharedSession];
    self.dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlConnection] completionHandler:completionBlock];
    [self.dataTask resume];
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    return [self.questions copy];
//    });
}

- (NSMutableArray *)connectFromDetailTableToAPIWithIdQuestion:(NSNumber *)idQuestion
{
    NSString *urlConnection = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/questions/%@/answers?order=desc&sort=activity&site=stackoverflow&filter=!9YdnSMKKT",
                               idQuestion];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlConnection] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          if([NSJSONSerialization isValidJSONObject:json]) {
                                              
                                              NSArray *items = [json objectForKey:@"items"];
                                              self.answers = [[NSMutableArray alloc] init];
                                              
                                              [items enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
                                               {
                                                   NSDictionary *owner = [obj objectForKey:@"owner"];
                                                   SOAnswer *answer = [[SOAnswer alloc] initWithAutorAnswer:[[owner objectForKey:@"display_name"] stringByDecodingHTMLEntities]
                                                                                          andBodyTextAnswer:[[obj objectForKey:@"body"] stringByDecodingHTMLEntities]
                                                                                  andLastActivityDateAnswer:[obj objectForKey:@"last_activity_date"]
                                                                                             andScoreAnswer:[obj objectForKey:@"score"]
                                                                                              andIsAccepted:[NSString stringWithFormat:@"%@", [obj objectForKey:@"is_accepted"]]];
                                                   [self.answers addObject:answer];
                                               }];
                                          }
                                          dispatch_semaphore_signal(semaphore);
                                      }];
    [dataTask resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return [self.answers copy];
}

@end
