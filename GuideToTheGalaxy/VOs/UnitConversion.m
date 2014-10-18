//
//  UnitConversion.m
//  GuideToTheGalaxy
//
//  Created by April on 14-10-17.
//  Copyright (c) 2014年 April. All rights reserved.
//

#import "UnitConversion.h"


#define REPEATED_TIMES      3


static NSDictionary *ROMAN_ARABIC_MAP = nil;
static NSDictionary *ARABIC_ROMAN_MAP = nil;
static NSArray *NON_REPEAT_NUMBERS = nil;
static NSDictionary *SUBTRACTABLE_MAP = nil;


@implementation UnitConversion

+ (NSDictionary *)romanArabic
{
    if (!ROMAN_ARABIC_MAP){
        ROMAN_ARABIC_MAP = [NSDictionary dictionaryWithObjectsAndKeys:
                        [NSNumber numberWithInt:1], @"I",
                        [NSNumber numberWithInt:5], @"V",
                        [NSNumber numberWithInt:10], @"X",
                        [NSNumber numberWithInt:50], @"L",
                        [NSNumber numberWithInt:100], @"C",
                        [NSNumber numberWithInt:500], @"D",
                        [NSNumber numberWithInt:1000], @"M", nil];
    }
    
    if (!ARABIC_ROMAN_MAP){
        ARABIC_ROMAN_MAP = [NSDictionary dictionaryWithObjectsAndKeys:
                        @"M", [NSNumber numberWithInt:1000],
                        @"CM", [NSNumber numberWithInt:900],
                        @"D", [NSNumber numberWithInt:500],
                        @"CD", [NSNumber numberWithInt:400],
                        @"C", [NSNumber numberWithInt:100],
                        @"XC", [NSNumber numberWithInt:90],
                        @"L", [NSNumber numberWithInt:50],
                        @"XL", [NSNumber numberWithInt:40],
                        @"X", [NSNumber numberWithInt:10],
                        @"IX", [NSNumber numberWithInt:9],
                        @"V", [NSNumber numberWithInt:5],
                        @"IV", [NSNumber numberWithInt:4],
                        @"I", [NSNumber numberWithInt:1], nil];
    }
    
    if (!NON_REPEAT_NUMBERS){
        NON_REPEAT_NUMBERS = [NSArray arrayWithObjects:@"D", @"L", @"V", nil];
    }
    
    if (!SUBTRACTABLE_MAP){
        SUBTRACTABLE_MAP = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSArray arrayWithObjects:@"V", @"X", nil], @"I",
                            [NSArray arrayWithObjects:@"L", @"C", nil], @"X",
                            [NSArray arrayWithObjects:@"D", @"M", nil], @"C", nil];
    }
    
    return ROMAN_ARABIC_MAP;
}


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
        NSNumber *arabicN = [[UnitConversion romanArabic] objectForKey:charN];
        NSNumber *arabicPrev = [[UnitConversion romanArabic] objectForKey:charPrev];

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
