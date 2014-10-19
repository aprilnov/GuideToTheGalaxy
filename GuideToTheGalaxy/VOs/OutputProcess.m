//
//  OutputProcess.m
//  GuideToTheGalaxy
//
//  Created by April on 14-10-19.
//  Copyright (c) 2014年 April. All rights reserved.
//

#import "OutputProcess.h"
#import "GGTranslation.h"


@implementation OutputProcess

+ (NSString *)translateInput:(NSString *)input {
    GGTranslation *translation = [[GGTranslation sharedInstance] translateInput:input];
}

@end
