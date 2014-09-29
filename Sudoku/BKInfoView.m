//
//  BKInfoView.m
//  Sudoku
//
//  Created by Hayden Blauzvern on 9/28/14.
//  Copyright (c) 2014 BlauzvernKutsko. All rights reserved.
//

#import "BKInfoView.h"

@implementation BKInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat x = CGRectGetWidth(frame)*.1;
        CGFloat y = CGRectGetHeight(frame)*.2;
        CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80;
        
        // Init text view frame
        CGRect textViewFrame = CGRectMake(x, y, size, size);
        UITextView* uiTextView = [[UITextView alloc]
                                  initWithFrame:textViewFrame];
        [uiTextView setFont:[UIFont systemFontOfSize:18.0f]];
        uiTextView.text = @"Welcome to Sudoku!\n\nIn order to win you must complete the 9x9 grid by filling in every empty square with the numbers 1-9. Every row, column and 3x3 subgrid must contain each number 1-9 exactly once. To add a number, simply tap the number you want to add in the number pad, and then tap the square you wish to fill. \n\nBy default, the game will check your moves for legality. Tap the \"Easy/Hard Mode\" button to change this. That will make the game not check your moves for you. \n\nTo erase a number you've added in the grid, press and hold that square for a short time. \n\nYou can save your current game to come back to later! simply press the save game button. To restore your game to the last save, just press the restore button. \n\nTo see how good you are at sudoku, check your statistics to see how many different puzzles you've solved. \n\nGood luck, and happy puzzle-solving!";
        [uiTextView setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:uiTextView];
    }
    return self;
}

@end
