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
        // Create size of frame
        CGFloat x = CGRectGetWidth(frame)*.05;
        CGFloat y = CGRectGetHeight(frame)*.25;
        CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.90;
        
        // Init text view frame
        CGRect textViewFrame = CGRectMake(x, y, size, size);
        UITextView* uiTextView = [[UITextView alloc]
                                  initWithFrame:textViewFrame];
        [uiTextView setFont:[UIFont systemFontOfSize:18.0f]];
        
        // Make textview non editable and scrollable
        uiTextView.scrollEnabled = NO;
        uiTextView.editable = NO;
        
        uiTextView.text = @"Welcome to Sudoku!\n\nIn order to win you must complete the 9x9 grid by filling in every empty square with the numbers 1-9. Every row, column and 3x3 subgrid must contain each number 1-9 exactly once. To add a number, simply tap the number you want to add in the number pad, and then tap the square you wish to fill. \n\nBy default, the game will check your moves for legality. Tap the \"Easy/Hard Mode\" button to change this. That will make the game not check your moves for you. \n\nTo erase a number you've added in the grid, press and hold that square for a short time. \n\nYou can save your current game to come back to later! Simply press the save game button. To restore your game to the last save, just press the restore button. \n\nTo see how good you are at Sudoku, check your statistics to see how many different puzzles you've solved. \n\nGood luck, and happy puzzle-solving!";
        
        // Set clear color show background is displayed behind text
        [uiTextView setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:uiTextView];
    }
    return self;
}

@end
