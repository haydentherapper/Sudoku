//
//  BKGridModel.m
//  Sudoku
//
//  Created by Hayden Blauzvern on 9/18/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import "BKGridModel.h"

@interface BKGridModel() {
    int _gridCells[9][9];
}

@end

@implementation BKGridModel

// Initial grid
// Will eventually be replaced by grid generation
int initialGrid[9][9] = {
    {7,0,0,4,2,0,0,0,9},
    {0,0,9,5,0,0,0,0,4},
    {0,2,0,6,9,0,5,0,0},
    {6,5,0,0,0,0,4,3,0},
    {0,8,0,0,0,6,0,0,7},
    {0,1,0,0,4,5,6,0,0},
    {0,0,0,8,6,0,0,0,2},
    {3,4,0,9,0,0,1,0,0},
    {8,0,0,3,0,2,7,4,0}};

- (void) initializeGrid
{
    for (int row = 0; row < 9; row++) {
        for (int col = 0; col < 9; col++) {
            _gridCells[row][col] = initialGrid[row][col];
        }
    }
}

- (int) getValueAtRow:(int)row atCol:(int)col
{
    return _gridCells[row][col];
}

- (BOOL) setValue:(int)value atRow:(int)row atCol:(int)col
{
    BOOL wasValid = [self checkLogicForValue: value atRow:row andCol: col];
    if (wasValid){
        _gridCells[row-1][col-1] = value;
    }
    return wasValid;
}

- (BOOL) checkLogicForValue:(int) value atRow:(int) row andCol:(int) col
{
    for (int i = 0; i < 9; ++i) {
        //check row
        if (_gridCells[row-1][i] == value) {
            return NO;
        }
        //check column
        if (_gridCells[i][col-1] == value) {
            return NO;
        }
    }
    //check 3x3 subgrid
    int rowIndex = ((row-1)/3)*3;
    int colIndex = ((col-1)/3)*3;
    for (int r = rowIndex; r < rowIndex + 3; ++r){
        for (int c = colIndex; c < colIndex + 3; ++c){
            if (_gridCells[r][c] == value){
                return NO;
            }
        }
    }
    return YES;
    
}


@end
