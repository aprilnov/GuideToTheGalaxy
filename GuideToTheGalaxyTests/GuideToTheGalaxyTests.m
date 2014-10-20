//
//  GuideToTheGalaxyTests.m
//  GuideToTheGalaxyTests
//
//  Created by April on 14-10-17.
//  Copyright (c) 2014年 April. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "GGRomanArabicConversion.h"
#import "GGTranslation.h"

@interface GuideToTheGalaxyTests : XCTestCase {
    GGRomanArabicConversion *romanArabicConversion;
}

@end

@implementation GuideToTheGalaxyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    romanArabicConversion = [[GGRomanArabicConversion alloc] init];
    
    // predefine roman number as some alias
    [[GGTranslation sharedInstance] translateInput:@"glob is I"];
    [[GGTranslation sharedInstance] translateInput:@"prok is V"];
    [[GGTranslation sharedInstance] translateInput:@"pish is X"];
    [[GGTranslation sharedInstance] translateInput:@"tegj is L"];
    
    [[GGTranslation sharedInstance] translateInput:@"glob glob Silver is 34 Credits"];
    [[GGTranslation sharedInstance] translateInput:@"glob prok Gold is 57800 Credits"];
    [[GGTranslation sharedInstance] translateInput:@"pish pish Iron is 3910 Credits"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUnitConversion {
    // roman arabic conversion tests
    XCTAssert([[romanArabicConversion convertRomanToArabic:@"MMM"] isEqualToNumber:[NSNumber numberWithInt:3000]],
              @"check roman MMM to arabic 3000");
    XCTAssert([[romanArabicConversion convertRomanToArabic:@"XXXIX"] isEqualToNumber:[NSNumber numberWithInt:39]],
              @"check roman MMM to arabic 39");
    
    XCTAssert([[romanArabicConversion convertRomanToArabic:@"MCMXLIV"] isEqualToNumber:[NSNumber numberWithInt:1944]],
              @"check roman MCMXLIV to arabic 1944");
    
    XCTAssert([[romanArabicConversion convertArabicToRoman:[NSNumber numberWithInt:1903]] isEqualToString:@"MCMIII"],
              @"check arabic 1903 to roman MCMIII");
    
    XCTAssert([[romanArabicConversion convertArabicToRoman:[NSNumber numberWithInt:1944]] isEqualToString:@"MCMXLIV"],
              @"check arabic 1944 to roman MCMXLIV");
    
    XCTAssert([[romanArabicConversion convertArabicToRoman:[NSNumber numberWithInt:1954]] isEqualToString:@"MCMLIV"],
              @"check arabic 1954 to roman MCMLIV");
}

- (void)testCalculateUnit {
    // how much is pish tegj glob glob ? 
    XCTAssert([[[GGTranslation sharedInstance] translateInput:@"how much is pish tegj glob glob ?"] isEqualToString:@"pish tegj glob glob is 42"], @"check pish tegj glob glob is 42");
}

- (void)testCalculateWithProducts {
    // how many Credits is glob prok Iron ?
    XCTAssert([[[GGTranslation sharedInstance] translateInput:@"how many Credits is glob prok Silver ?"] isEqualToString:@"glob prok Silver is 68 Credits"], @"check glob prok Silver is 68 Credits");
    
    XCTAssert([[[GGTranslation sharedInstance] translateInput:@"how many Credits is glob prok Gold ?"] isEqualToString:@"glob prok Gold is 57800 Credits"], @"check glob prok Gold is 57800 Credits");
    
    XCTAssert([[[GGTranslation sharedInstance] translateInput:@"how many Credits is glob prok Iron ?"] isEqualToString:@"glob prok Iron is 782 Credits"], @"check glob prok Iron is 782 Credits");
}

- (void)testInValidInput {
    
    // Only allowed number to repeat
    XCTAssertThrowsSpecific([romanArabicConversion convertRomanToArabic:@"DD"], NSException, @"this roman number cannot repeat");
    
    // repeat only 3 times
    XCTAssertThrowsSpecific([romanArabicConversion convertRomanToArabic:@"MMMM"], NSException, @"this roman number cannot repeat more than 3 times");
    
    // subtract number restrict
    XCTAssertThrowsSpecific([romanArabicConversion convertRomanToArabic:@"IM"], NSException, @"This subtract is not allowed");
    
    // subtract only once
    XCTAssertThrowsSpecific([romanArabicConversion convertRomanToArabic:@"IVX"], NSException, @"Only one small-value symbol may be subtracted from any large-value symbol");
    
    // how much wood could a woodchuck chuck if a woodchuck could chuck wood ?
    XCTAssert([[[GGTranslation sharedInstance] translateInput:@"how much wood could a woodchuck chuck if a woodchuck could chuck wood ?"] isEqualToString:@"I have no idea what you are talking about"], @"check invalid questions");
}





@end
