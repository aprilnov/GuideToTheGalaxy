//
//  NSString+Utils.m
//  GuideToTheGalaxy
//
//  Created by April on 14-10-20.
//  Copyright (c) 2014年 April. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (BOOL)isEmptyString {
    
    NSString *s = self;
    
    if ([self isKindOfClass:[s class]]) {
        return YES;
    }
    
    if (s == nil) {
        return YES;
    } else if ([s length] == 0) {
        return YES;
    } else if ([[s stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
        return YES;
    }
    
    return NO;  
}

@end
