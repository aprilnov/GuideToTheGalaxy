//
//  GuideToTheGalaxyTests.m
//  GuideToTheGalaxyTests
//
//  Created by April on 14-10-17.
//  Copyright (c) 2014年 April. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "UnitConversion.h"

@interface GuideToTheGalaxyTests : XCTestCase {
    UnitConversion *unitConversion;
}

@end

@implementation GuideToTheGalaxyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testUnitConversion {
    // roman arabic conversion tests
    XCTAssert([[UnitConversion convertRomanToArabic:@"MMM"] isEqualToNumber:[NSNumber numberWithInt:3000]],
              @"check roman MMM to arabic 3000");
    XCTAssert([[UnitConversion convertRomanToArabic:@"XXXIX"] isEqualToNumber:[NSNumber numberWithInt:39]],
              @"check roman MMM to arabic 39");
    
//    XCTAssert([[UnitConversion convertRomanToArabic:@"MCMXLIV"] isEqualToNumber:[NSNumber numberWithInt:1944]],
//              @"check roman MCMXLIV to arabic 1944");
//    XCTAssert([[UnitConversion convertArabicToRoman:[NSNumber numberWithInt:1903]] isEqualToString:@"MCMIII"],
//              @"check arabic 1903 to roman MCMIII");
}

- (void)testUnitDefine {
    // define symbols (glob is I)
    XCTAssert(YES, @"Pass");
}

- (void)testTranslation {
    // glob glob Silver is 34 Credits
    XCTAssert(YES, @"Pass");
}

- (void)testCalculateUnit {
    // how much is pish tegj glob glob ? 
    XCTAssert(YES, @"Pass");
}

- (void)testCalculateWithProducts {
    // how many Credits is glob prok Iron ?
    XCTAssert(YES, @"Pass");
}

- (void)testInValidInput {
    // how much wood could a woodchuck chuck if a woodchuck could chuck wood ?
    XCTAssert(YES, @"Pass");
}





@end
