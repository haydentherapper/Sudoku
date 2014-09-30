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
    [_gridModel parseGrids];
    [_gridModel initializeGrid];

}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//tests the grid model for proper initialization
- (void)testInitialStateSetup
{
    NSString *initialStateString = [_gridModel getInitialState];
    XCTAssertTrue( initialStateString.length == 81, @"checking that the initial grid was parsed");
    XCTAssertTrue( [initialStateString rangeOfString:@"0"].location == NSNotFound, @"make sure there are not zeros in the initial state");
    
}

- (void)testValueGettingAndSetting
{
    //blank everything out in the game save files
    NSString* encoding = @".................................................................................";
    NSString* path = [[NSBundle mainBundle] pathForResource: @"gameState" ofType:@"txt"];
    [encoding writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSString* initialPath = [[NSBundle mainBundle] pathForResource: @"initialState" ofType:@"txt"];
    [encoding writeToFile:initialPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    //load the blank grid that we just saved
    [_gridModel restoreSelf];
    
    
    XCTAssertTrue([_gridModel getValueAtRow:0 atCol:0] == 0, @"Checking value at r1:c1");
    XCTAssertTrue([_gridModel checkValue:1 atRow:0 atCol:0], @"Checking value placement is legal on blank square");
    [_gridModel setValue:1 atRow:0 atCol:0];
    XCTAssertTrue([_gridModel getValueAtRow:0 atCol:0] == 1, @"Checking value was set at r1:c1");
    
    //Make sure we can't add illegal numbers
    XCTAssertEqual([_gridModel checkValue:1 atRow:6 atCol:0], NO, @"Checking logic within col");
    XCTAssertEqual([_gridModel checkValue:1 atRow:0 atCol:8], NO, @"Checking logic within row");
    XCTAssertEqual([_gridModel checkValue:1 atRow:2 atCol:2], NO, @"Checking logic within 3x3");
    
    //check some edge cases
    XCTAssertTrue([_gridModel checkValue:8 atRow:6 atCol:2], @"Setting 1 at r7:c3, valid move");
    [_gridModel setValue:8 atRow:6 atCol:2]; //add the value
    XCTAssertTrue([_gridModel getValueAtRow:6 atCol:2] == 8, @"Checking value at r7:c3");
    XCTAssertTrue([_gridModel checkValue:4 atRow:6 atCol:2], @"Make sure we can replace values");
    [_gridModel setValue:4 atRow:6 atCol:2];
    XCTAssertTrue([_gridModel getValueAtRow:6 atCol:2] == 4, @"Checking value at r7:c3 with new value");
    
   
}

-(void)testEndGame
{
    //blank everything out in the game save files
    NSString* encoding = @".................................................................................";
    NSString* path = [[NSBundle mainBundle] pathForResource: @"gameState" ofType:@"txt"];
    [encoding writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSString* initialPath = [[NSBundle mainBundle] pathForResource: @"initialState" ofType:@"txt"];
    [encoding writeToFile:initialPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    [_gridModel restoreSelf];

    
    //Make sure blank grid is not full or won
    XCTAssertFalse([_gridModel isFull], @"Check the grid isn't full");
    XCTAssertFalse([_gridModel wonTheGame], @"Check we haven't won");
    
    //"save" a won game
    encoding = @"753186942914237865628594731289453617375861294146729358891342576462975183537618429";
    path = [[NSBundle mainBundle] pathForResource: @"gameState" ofType:@"txt"];
    [encoding writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    initialPath = [[NSBundle mainBundle] pathForResource: @"initialState" ofType:@"txt"];
    [encoding writeToFile:initialPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    [_gridModel restoreSelf];

    
    //Make sure grid is full and won
    XCTAssertTrue([_gridModel isFull], @"Check the grid is full");
    XCTAssertTrue([_gridModel wonTheGame], @"Check we have won");
    
}
@end
