//
//  SudokuTests.m
//  SudokuTests
//
//  Created by Sarah Gilkinson on 9/11/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BKGridModel.h"

@interface SudokuTests : XCTestCase {
    BKGridModel* _gridModel;
}

@end

@implementation SudokuTests

- (void)setUp
{
    [super setUp];
    _gridModel = [BKGridModel alloc];
    [_gridModel initializeGrid];

}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTAssertTrue([_gridModel getValueAtRow:0 atCol:0] == 7, @"Checking value at r1:c1");
    XCTAssertTrue([_gridModel getValueAtRow:0 atCol:1] == 0, @"Checking value at r1:c2");
    
    XCTAssertTrue([_gridModel setValue:1 atRow:7 atCol:3], @"Setting 1 at r7:c3, valid move");
    XCTAssertEqual([_gridModel setValue:1 atRow:7 atCol:3], NO, @"Checking if we can't replace a value");
    XCTAssertTrue([_gridModel getValueAtRow:6 atCol:2] == 1, @"Checking value at r7:c3");
    
    XCTAssertEqual([_gridModel setValue:4 atRow:7 atCol:1], NO, @"Checking logic within 3x3");
    XCTAssertEqual([_gridModel setValue:1 atRow:7 atCol:1], NO, @"Checking logic within row");
    XCTAssertEqual([_gridModel setValue:7 atRow:7 atCol:1], NO, @"Checking logic within col");
}

@end
