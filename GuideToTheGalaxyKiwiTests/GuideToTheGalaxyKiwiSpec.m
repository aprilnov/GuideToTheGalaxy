//
//  GuideToTheGalaxyKiwiSpec.m
//  GuideToTheGalaxy
//
//  Created by pengyalan on 10/22/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(MathSpec)

describe(@"Math", ^{
    it(@"is pretty cool", ^{
        NSUInteger a = 16;
        NSUInteger b = 26;
        [[theValue(a + b) should] equal:theValue(42)];
    });
});

SPEC_END
