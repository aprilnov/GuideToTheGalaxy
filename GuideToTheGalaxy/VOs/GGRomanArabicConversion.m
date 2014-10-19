//
//  UnitConversion.m
//  GuideToTheGalaxy
//
//  Created by April on 14-10-17.
//  Copyright (c) 2014年 April. All rights reserved.
//

#import "GGRomanArabicConversion.h"


#define REPEATED_TIMES      3

#define ROMAN_ARABIC_MAP  @{@"I":[NSNumber numberWithInt:1],\
                            @"V":[NSNumber numberWithInt:5],\
                            @"X":[NSNumber numberWithInt:10],\
                            @"L":[NSNumber numberWithInt:50],\
                            @"C":[NSNumber numberWithInt:100],\
                            @"D":[NSNumber numberWithInt:500],\
                            @"M":[NSNumber numberWithInt:1000]}

#define ARABIC_ROMAN_MAP  @{[NSNumber numberWithInt:1]:@"I",\
                            [NSNumber numberWithInt:4]:@"IV",\
                            [NSNumber numberWithInt:5]:@"V",\
                            [NSNumber numberWithInt:9]:@"IX",\
                            [NSNumber numberWithInt:10]:@"X",\
                            [NSNumber numberWithInt:40]:@"XL",\
                            [NSNumber numberWithInt:50]:@"L",\
                            [NSNumber numberWithInt:90]:@"XC",\
                            [NSNumber numberWithInt:100]:@"C",\
                            [NSNumber numberWithInt:400]:@"CD",\
                            [NSNumber numberWithInt:500]:@"D",\
                            [NSNumber numberWithInt:900]:@"CM",\
                            [NSNumber numberWithInt:1000]:@"M"}

#define NON_REPEAT_NUMBERS @[@"D", @"L", @"V"]

#define SUBTRACTABLE_MAP @{@"I":@[@"V", @"X"],\
                           @"X":@[@"L", @"C"],\
                           @"C":@[@"D", @"M"]}


@implementation GGRomanArabicConversion


+ (NSNumber *)convertRomanToArabic:(NSString *)romanNumber {
    
    // empty input
    if ([romanNumber isEqualToString:@""] || romanNumber == nil) {
        [NSException raise:@"invalid input" format:@"%@", romanNumber];
    }
    
    NSMutableArray *resultArr = [NSMutableArray array];
    NSMutableDictionary *repeatTable = [[NSMutableDictionary alloc] init];
    
    for (NSInteger charIndex = 0; charIndex < romanNumber.length; charIndex++){
        
        NSString *charN = [NSString stringWithFormat:@"%c", [romanNumber characterAtIndex:charIndex]];
        NSString *charPrev = (charIndex == 0?charN:[NSString stringWithFormat:@"%c", [romanNumber characterAtIndex:charIndex-1]]);
        NSNumber *arabicN = [ROMAN_ARABIC_MAP objectForKey:charN];
        NSNumber *arabicPrev = [ROMAN_ARABIC_MAP objectForKey:charPrev];

        if (arabicN){
            
            if (charIndex == 0){
                [resultArr addObject:arabicN];
            } else {
                if ([charPrev isEqualToString:charN]) {     // repeat
                    if ([NON_REPEAT_NUMBERS containsObject:charN]) {    // cannot repeatable numbers
                        [NSException raise:@"this roman number cannot repeat" format:@"%@", romanNumber];
                    } else {    // repeat more than 3 times
                        if ([repeatTable valueForKey:charN] != nil && [[repeatTable valueForKey:charN] intValue] == REPEATED_TIMES) {
                            [NSException raise:@"this roman number cannot repeat more than 3 times" format:@"%@", romanNumber];
                        } else {
                            if ([repeatTable valueForKey:charN] == nil) {
                                [repeatTable setValue:[NSNumber numberWithInt:2] forKey:charN];
                            } else {
                                NSNumber *repeatTimes = [NSNumber numberWithInt:[[repeatTable valueForKey:charN] intValue]+1];
                                [repeatTable setValue:repeatTimes forKey:charN];
                            }
                            
                            [resultArr addObject:arabicN];
                        }
                    }
                    
                } else {
                    
                    NSNumber *lastCalculatedN = [resultArr lastObject];
                    if (lastCalculatedN < arabicN){
                        if ([lastCalculatedN intValue] != [arabicPrev intValue]) {  // already been subtracted
                            [NSException raise:@"Only one small-value symbol may be subtracted from any large-value symbol" format:@"%@", romanNumber];
                        } else if ( ![[SUBTRACTABLE_MAP allKeys] containsObject:charPrev] || ![(NSArray *)[SUBTRACTABLE_MAP valueForKey:charPrev] containsObject:charN]){  // cannot be substracted
                            [NSException raise:@"This subtract is not allowed" format:@"%@", romanNumber];
                        }
                        
                        NSNumber *realArabicN = [NSNumber numberWithInt:([arabicN intValue] - [lastCalculatedN intValue])];

                        [resultArr removeLastObject];
                        [resultArr addObject:realArabicN];

                    } else {
                        [resultArr addObject:arabicN];
                    }
                }
            }
            
        } else {
            [NSException raise:@"invalid input" format:@"%@", romanNumber];
        }
    }
    
    if (resultArr.count){
        int sum = 0;
        for (NSNumber *i in resultArr) {
            sum += [i intValue];
        }
        return [NSNumber numberWithInt:sum];
    }
    return [NSNumber numberWithInt:0];
}


+ (NSString *)convertArabicToRoman:(NSNumber *)arabicNumber {
    
    NSMutableArray *res = [NSMutableArray array];
    
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
    
    for (id key in [[ARABIC_ROMAN_MAP allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject: sortOrder]])
    {
        int count = [arabicNumber intValue] / [key intValue];
        for (NSInteger i = 0; i < count; i++){
            [res addObject: [ARABIC_ROMAN_MAP objectForKey:key]];
        }
        arabicNumber = [NSNumber numberWithInt:( [arabicNumber intValue] - [key intValue] * count )];
    }
    return [res componentsJoinedByString:@""];
}

@end
