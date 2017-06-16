//
//  NSMutableAttributedString+StackOverflow.h
//  StackOverflowAPI
//
//  Created by Vladislav on 02.05.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (StackOverflow)

+ (NSMutableAttributedString *)configuredSOStringWithString:(NSString *)sourceString;

@end
