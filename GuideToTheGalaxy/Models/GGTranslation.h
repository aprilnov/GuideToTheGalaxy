//
//  GGTranslation.h
//  GuideToTheGalaxy
//
//  Created by April on 14-10-17.
//  Copyright (c) 2014年 April. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGTranslation : NSObject

/**
 *  singlton
 *
 *  @return instance
 */
+ (id)sharedInstance;

/**
 *  translate input line by line
 *
 *  @param input
 *
 *  @return translated output
 */
- (NSString *)translateInput:(NSString *)input;

@end
