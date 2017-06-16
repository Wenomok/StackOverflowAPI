//
//  NSMutableAttributedString+StackOverflow.m
//  StackOverflowAPI
//
//  Created by Vladislav on 02.05.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import "NSMutableAttributedString+StackOverflow.h"

@implementation NSMutableAttributedString (StackOverflow)

+ (NSMutableAttributedString *)configuredSOStringWithString:(NSString *)sourceString
{
    NSString *temp = [NSString stringWithString:sourceString];
    
    NSRange range;
    while ((range = [temp rangeOfString:@"<(\"[^\"]*\"|'[^']*'|[^'\">])*>" options:NSRegularExpressionSearch]).location != NSNotFound) {
        if([[temp substringWithRange:range] isEqual:@"<code>"]) {
            temp = [temp stringByReplacingCharactersInRange:range withString:@"Start123code\n"];
        } else if([[temp substringWithRange:range] isEqual:@"</code>"]) {
            temp = [temp stringByReplacingCharactersInRange:range withString:@"\nEnd123code"];
        } else {
            temp = [temp stringByReplacingCharactersInRange:range withString:@""];
        }
    }
    NSMutableAttributedString *configuredString = [[NSMutableAttributedString alloc] initWithString:temp];
    
    NSRange rangeOfInputCode = [configuredString.mutableString rangeOfString:@"Start123code"];
    NSRange rangeOfOutputCode = [configuredString.mutableString rangeOfString:@"End123code"];
    
    while(rangeOfInputCode.length != 0 && rangeOfOutputCode.length != 0) {
        
        NSUInteger i = rangeOfOutputCode.location - rangeOfInputCode.location;
        
        [configuredString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"ArialMT" size:11] range:NSMakeRange(rangeOfInputCode.location + 12, i - 12)];
        [configuredString addAttribute:NSBackgroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(rangeOfInputCode.location + 12, i - 12)];
        
        [configuredString.mutableString deleteCharactersInRange:rangeOfOutputCode];
        [configuredString.mutableString deleteCharactersInRange:rangeOfInputCode];
        
        rangeOfInputCode = [configuredString.mutableString rangeOfString:@"Start123code"];
        rangeOfOutputCode = [configuredString.mutableString rangeOfString:@"End123code"];
    }
    
    return configuredString;
}

@end
