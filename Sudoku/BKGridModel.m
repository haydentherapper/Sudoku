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

- (void) setValue:(int)value atRow:(int)row atCol:(int)col
{
    _gridCells[row][col] = value;
}



@end
