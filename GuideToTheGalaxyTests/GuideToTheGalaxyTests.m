//
//  GuideToTheGalaxyTests.m
//  GuideToTheGalaxyTests
//
//  Created by pengyalan on 10/17/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface GuideToTheGalaxyTests : XCTestCase

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

- (void)testSimpleTranslate {
    // 3 5 7
    XCTAssert([[_checker_357 countOffOfInterger:1] isEqualToString:@"1"], @"357 check 1");
    XCTAssert([[_checker_357 countOffOfInterger:2] isEqualToString:@"2"], @"357 check 2");
    XCTAssert([[_checker_357 countOffOfInterger:3] isEqualToString:@"Fizz"], @"357 check 3");
    XCTAssert([[_checker_357 countOffOfInterger:5] isEqualToString:@"Buzz"], @"357 check 5");
    XCTAssert([[_checker_357 countOffOfInterger:7] isEqualToString:@"Whizz"], @"357 check 7");
    XCTAssert([[_checker_357 countOffOfInterger:13] isEqualToString:@"Fizz"], @"357 check 13");
    XCTAssert([[_checker_357 countOffOfInterger:15] isEqualToString:@"FizzBuzz"], @"357 check 15");
    XCTAssert([[_checker_357 countOffOfInterger:17] isEqualToString:@"17"], @"357 check 17");
    XCTAssert([[_checker_357 countOffOfInterger:31] isEqualToString:@"Fizz"], @"357 check 31");
    XCTAssert([[_checker_357 countOffOfInterger:51] isEqualToString:@"Fizz"], @"357 check 51");
    XCTAssert([[_checker_357 countOffOfInterger:71] isEqualToString:@"71"], @"357 check 71");
    

}

- (void)testValueConversion {
    
}

- (void)testInvalidInput {
    
}

- (void)testInvalidInput {
    
}

@end
