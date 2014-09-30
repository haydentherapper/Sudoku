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
    NSString* _initialState;
}

@end

@implementation BKGridModel

// Called once to read all grids from a text file and save them
- (void)parseGrids
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"grid1" ofType:@"txt"];
    NSError* error;
    NSString* readString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:(&error)];
    _allPossibleGrids=[readString componentsSeparatedByString:@"\n"];
}

- (void)initializeGrid
{
    // Pick a random grid for this round
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
    //This will write down the initial state of the grid
    _initialState = ourGrid;
}

- (int)getValueAtRow:(int)row atCol:(int)col
{
    return _gridCells[row][col];
}

- (void)setValue:(int)value atRow:(int)row atCol:(int)col
{
    _gridCells[row][col] = value;
}

- (BOOL)checkValue:(int)value atRow:(int)row atCol:(int)col
{
    for (int i = 0; i < 9; ++i) {
        //check row
        if (_gridCells[row][i] == value && i != col) { // != for not including current cell
            return NO;
        }
        //check column
        if (_gridCells[i][col] == value && i != row) {
            return NO;
        }
    }
    //check 3x3 subgrid
    int rowIndex = (row/3)*3; // Works with integer division
    int colIndex = (col/3)*3;
    for (int r = rowIndex; r < rowIndex + 3; ++r){
        for (int c = colIndex; c < colIndex + 3; ++c){
            if (_gridCells[r][c] == value && r != row && c != col){
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

- (BOOL)wonTheGame
{
    // Check every cell logic
    for (int r = 0; r<9; r++){
        for (int c = 0; c<9; c++){
            int value = _gridCells[r][c];
            if (![self checkValue:value atRow:r atCol:c]){
                return NO;
            }
        }
    }
    return YES;
}


- (void)saveYourSelf
{
    NSString* path = [[NSBundle mainBundle] pathForResource: @"gameState" ofType:@"txt"];
    NSString* encoding = @"";
    
    // Add each cell to a string to be saved as the game state
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            int val = _gridCells[r][c];
            if (val != 0) {
                encoding = [encoding stringByAppendingString:[NSString stringWithFormat:@"%i", _gridCells[r][c]]];
            } else {
                encoding = [encoding stringByAppendingString:@"."];
            }
        }
    }
    // Write the game state
    [encoding writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSString* initialPath = [[NSBundle mainBundle] pathForResource: @"initialState" ofType:@"txt"];
    // Write the initial state to know which buttons need to be original buttons
    [_initialState writeToFile:initialPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)restoreSelf
{
    NSString* initialPath = [[NSBundle mainBundle] pathForResource:@"initialState" ofType:@"txt"];
    NSError* error;
    NSString* initialState = [[NSString alloc] initWithContentsOfFile:initialPath
                                                             encoding:NSUTF8StringEncoding error:(&error)];
    // Checks if a game has ever been saved
    if ([initialState isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No saved state"
                                                        message:@"You've never saved a game! Hit the save button to do so!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        // Restores initial state
        _initialState = initialState;
    
        NSString* path = [[NSBundle mainBundle] pathForResource:@"gameState" ofType:@"txt"];
        NSString* previousState = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:(&error)];
    
        // Restore all characters
        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                unichar character = [previousState characterAtIndex:i*9 + j];
                if (character == '.') {
                    _gridCells[i][j] = 0;
                } else {
                    _gridCells[i][j] = character - '0';
                }
            }
        }
    }
}

-(NSString*)getInitialState
{
    return _initialState;
}

@end
