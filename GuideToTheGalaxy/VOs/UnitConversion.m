//
//  UnitConversion.m
//  GuideToTheGalaxy
//
//  Created by April on 14-10-17.
//  Copyright (c) 2014年 April. All rights reserved.
//

#import "UnitConversion.h"

#define SIGN_I              @"I"
#define SIGN_V              @"V"
#define SIGN_X              @"X"
#define SIGN_L              @"L"
#define SIGN_C              @"C"
#define SIGN_D              @"D"
#define SIGN_M              @"M"
#define REPEATED_TIMES      3


@implementation UnitConversion


+ (NSNumber *)convertRomanToArabic:(NSString *)roman {
    NSNumber *arabic = [NSNumber numberWithInt:0];
    
    [roman enumerateLinesUsingBlock:^(NSString *line, BOOL *stop){
        NSLog(@"line -> %@\n", line);
    }];
    
    return arabic;
}


+ (NSString *)convertArabicToRoman:(NSNumber *)arabic {
    NSString *roman = @"";
    
    return roman;
}

@end
