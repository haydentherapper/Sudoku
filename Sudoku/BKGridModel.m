//
//  BKGridModel.m
//  Sudoku
//
//  Created on 9/18/14.
//  Copyright (c) 2014 Blauzvern Kutsko. All rights reserved.
//

#import "BKGridModel.h"

@interface BKGridModel() {
    int _gridCells[9][9];
    NSArray* _allPossibleGrids;
}

@end

@implementation BKGridModel

- (void)parseGrids
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"grid1" ofType:@"txt"];
    NSError* error;
    NSString* readString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:(&error)];
    _allPossibleGrids=[readString componentsSeparatedByString:@"\n"];
}

- (void)initializeGrid
{
    int randomNum = arc4random_uniform([_allPossibleGrids count]);
    NSString* ourGrid = [_allPossibleGrids objectAtIndex:randomNum];

    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            unichar character = [ourGrid characterAtIndex:i*9 + j];
            if (character == '.') {
                _gridCells[i][j] = 0;
            } else {
                _gridCells[i][j] = character - '0';
            }
        }
    }
}

- (int)getValueAtRow:(int)row atCol:(int)col
{
    return _gridCells[row][col];
}

- (BOOL)setValue:(int)value atRow:(int)row atCol:(int)col
{
    // Check if the attempted move is valid
    BOOL wasValid = [self checkLogicForValue: value atRow:row andCol: col];
    if (wasValid){
        _gridCells[row][col] = value;
    }
    return wasValid;
}

- (BOOL)checkLogicForValue:(int)value atRow:(int)row andCol:(int)col
{
    for (int i = 0; i < 9; ++i) {
        //check row
        if (_gridCells[row][i] == value) {
            return NO;
        }
        //check column
        if (_gridCells[i][col] == value) {
            return NO;
        }
    }
    //check 3x3 subgrid
    int rowIndex = (row/3)*3; // Works with integer division
    int colIndex = (col/3)*3;
    for (int r = rowIndex; r < rowIndex + 3; ++r){
        for (int c = colIndex; c < colIndex + 3; ++c){
            if (_gridCells[r][c] == value){
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL)isFull
{
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            // 0 means uninitialized cell
            if (_gridCells[r][c] == 0) {
                return NO;
            }
        }
    }
    return YES;
}

@end
