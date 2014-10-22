//
//  NSNumber+Roman.h
//  GuideToTheGalaxy
//
//  Created by pengyalan on 10/22/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Roman)

+ (NSNumber *)numberWithRoman:(NSString *)romanNumber;

- (NSString *)convertToRoman;

@end
