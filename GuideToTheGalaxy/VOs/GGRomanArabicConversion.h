//
//  UnitConversion.h
//  GuideToTheGalaxy
//
//  Created by April on 14-10-17.
//  Copyright (c) 2014年 April. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGRomanArabicConversion : NSObject

/**
 *  Convert roman to arabic unit
 *
 *  @param roman
 *
 *  @return arabic
 */
+ (NSNumber *)convertRomanToArabic:(NSString *)roman;


/**
 *  Convert arabic to roman unit
 *
 *  @param arabic
 *
 *  @return roman
 */
+ (NSString *)convertArabicToRoman:(NSNumber *)arabic;


@end
