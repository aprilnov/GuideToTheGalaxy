//
//  GGTranslation.m
//  GuideToTheGalaxy
//
//  Created by April on 14-10-17.
//  Copyright (c) 2014年 April. All rights reserved.
//

#import "GGTranslation.h"
#import "GGRomanArabicConversion.h"


#define ERROR_MSG           @"I have no idea what you are talking about"

#define REGEX_ASSIGN        @"^([a-z]+) is ([I|V|X|L|C|D|M])$"
#define REGEX_CREDITS       @"((?:[a-z]+ )+)([A-Z]\\w+) is (\\d+) ([A-Z]\\w+)$"
#define REGEX_HOWMUCH       @"^how much is ((?:\\w+[^0-9] )+)\\?$"
#define REGEX_HOWMANY       @"^how many ([a-zA-Z]\\w+) is ((?:\\w+ )+)([A-Z]\\w+) \\?$"

@interface GGTranslation () {
    NSMutableDictionary *romanMap;      // put roman alias
    NSMutableDictionary *currencyValueMap;      // currency calculated value
}

// check input type
- (BOOL)checkInputType:(NSString *)line withRegex:(NSString *)regex;

- (void)dealAssignment:(NSString *)line;

// calculate currency value
- (void)dealCredits:(NSString *)line;

// convert roman to arabic with alias
- (NSString *)answerRomanQuestion:(NSString *)line;

// calculate currency value with roman param
- (NSString *)answerCurrencyQuestion:(NSString *)line;

@end

@implementation GGTranslation


-(id)init {
    if ( self = [super init] ) {
        romanMap = [[NSMutableDictionary alloc] init];
        currencyValueMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

// singlton
+ (id)sharedInstance {
    static GGTranslation *sharedGGTranslation = nil;
    @synchronized(self) {
        if (sharedGGTranslation == nil)
            sharedGGTranslation = [[self alloc] init];
    }
    return sharedGGTranslation;
}

- (NSString *)translateInput:(NSString *)input {
    
    if ([self checkInputType:input withRegex:REGEX_ASSIGN]) {
        [self dealAssignment:input];
        return @"";
        
    } else if ([self checkInputType:input withRegex:REGEX_CREDITS]) {
        [self dealCredits:input];
        return @"";
        
    } else if ([self checkInputType:input withRegex:REGEX_HOWMUCH]) {
        return [self answerRomanQuestion:input];
        
    } else if ([self checkInputType:input withRegex:REGEX_HOWMANY]) {
        return [self answerCurrencyQuestion:input];
        
    }
    
    return ERROR_MSG;
}


#pragma mark - Private Methods

- (BOOL)checkInputType:(NSString *)line withRegex:(NSString *)regexStr {
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSUInteger matcheNumber = [regex numberOfMatchesInString:line options:0 range:NSMakeRange(0, line.length)];
    
    return matcheNumber > 0;
}

- (void)dealAssignment:(NSString *)line {
    
    // find alias
    if ([self checkInputType:line withRegex:REGEX_ASSIGN] > 0) {
        
        NSArray *group = [line componentsSeparatedByString:@" is "];
        [romanMap setObject:group[1] forKey:group[0]];  // save alias
    }
}

- (void)dealCredits:(NSString *)line {
    
    // glob prok Gold is 57800 Credits
    if ([self checkInputType:line withRegex:REGEX_CREDITS] > 0) {
        
        // without "is"
        NSArray *group = [[[line componentsSeparatedByString:@" is"] componentsJoinedByString:@""] componentsSeparatedByString:@" "];
        
        NSMutableString *romanStr = [NSMutableString string];
        NSNumber *arabicNum = nil;
        NSMutableArray *currencyArr = [NSMutableArray array];
        
        for (int i = 0; i < group.count; i++) {
            
            if ([romanMap.allKeys containsObject:group[i]]) {   // colllect roman numbers
                [romanStr appendString:[romanMap objectForKey:group[i]]];
            } else if ([group[i] intValue] != 0) {      // arabic number
                arabicNum = [NSNumber numberWithInt:[group[i] intValue]];
            } else {    // get currency
                if (![group[i] isEqualToString:@"Credits"]) {
                    [currencyArr addObject:group[i]];
                }
            }
        }
        
        // convert roman to arabic
        NSNumber *romanNumber = [[[GGRomanArabicConversion alloc] init] convertRomanToArabic:romanStr];
        
        // calculate currency value
        [currencyValueMap setObject:[NSNumber numberWithDouble:[arabicNum floatValue]/[romanNumber floatValue]] forKey:currencyArr[0]];
        
    }
}

- (NSString *)answerRomanQuestion:(NSString *)line {
    
    // how much is pish tegj glob glob ?
    if ([self checkInputType:line withRegex:REGEX_HOWMUCH] > 0) {
        
        // get question -> pish tegj glob glob
        NSString *question = [[[[line componentsSeparatedByString:@"how much is "] componentsJoinedByString:@""] componentsSeparatedByString:@" ?"] componentsJoinedByString:@""];
        
        NSArray *group = [question componentsSeparatedByString:@" "];
        
        NSMutableString *romanStr = [NSMutableString string];
        
        for (int i = 0; i < group.count; i++) {
            
            // collect roman numbers
            if ([romanMap.allKeys containsObject:group[i]]) {
                [romanStr appendString:[romanMap objectForKey:group[i]]];
            }
        }
        
        // convert roman to arabic
        NSNumber *romanNumber = [[[GGRomanArabicConversion alloc] init] convertRomanToArabic:romanStr];
        
        return [question stringByAppendingFormat:@" is %d", [romanNumber intValue]];
    }
    
    return @"";
}

- (NSString *)answerCurrencyQuestion:(NSString *)line {
    
    // how many Credits is glob prok Silver ?
    if ([self checkInputType:line withRegex:REGEX_HOWMANY] > 0) {
        
        // get question -> glob prok Silver
        NSString *question = [[[[line componentsSeparatedByString:@"how many Credits is "] componentsJoinedByString:@""] componentsSeparatedByString:@" ?"] componentsJoinedByString:@""];
        
        NSArray *group = [question componentsSeparatedByString:@" "];
        
        NSMutableString *romanStr = [NSMutableString string];
        NSNumber *currencyValue = nil;
        
        for (int i = 0; i < group.count; i++) {
            
            if ([romanMap.allKeys containsObject:group[i]]) {       // collect roman alias
                [romanStr appendString:[romanMap objectForKey:group[i]]];
            } else {    // get currency value
                currencyValue = [currencyValueMap valueForKey:group[i]];
            }
        }
        
        // convert roman to arabic
        NSNumber *romanNumber = [[[GGRomanArabicConversion alloc] init] convertRomanToArabic:romanStr];
        
        NSString *returnStr = [question stringByAppendingFormat:@" is %.f Credits", [[NSNumber numberWithDouble:[romanNumber intValue]*[currencyValue floatValue]] floatValue]];
        
        return returnStr;
        
    }
    
    return @"";
}

@end
