//
//  BGViewController.m
//  Sudoku
//
//  Created on 9/11/14.
//  Copyright (c) 2014 Blauzvern Kutsko. All rights reserved.
//

#import "BKViewController.h"
#import "BKGridView.h"
#import "BKGridModel.h"
#import "BKNumPadView.h"

@interface BKViewController() <BKGridViewDelegate> {
    BKGridView* _gridView;
    BKGridModel* _gridModel;
    BKNumPadView* _numPadView;
}

@end

@implementation BKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create grid frame
    CGRect frame = self.view.frame;
    CGFloat x = CGRectGetWidth(frame)*.1;
    CGFloat y = CGRectGetHeight(frame)*.1;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80;
    
    CGRect gridFrame = CGRectMake(x, y, size, size);
    
    _gridModel = [BKGridModel alloc];
    [_gridModel parseGrids];
    [_gridModel initializeGrid];
    
    // Create grid view and populates
    _gridView = [[BKGridView alloc] initWithFrame:gridFrame ofSize:size];
    
    for (int row = 0; row < 9; row++) {
        for (int col = 0; col < 9; col++) {
            int value = [_gridModel getValueAtRow:row atCol:col];
            if (value != 0) {
                [_gridView setButtonValue:value atRow:row atCol:col canSelect:NO];
            }
        }
    }
    
    // Assign gridView's delegate to be the controller
    _gridView.delegate = self;

    [self.view addSubview:_gridView];
    
    // Constants allow us to shape the numpad
    CGRect numPadFrame = CGRectMake(x, y + round((CGRectGetHeight(frame) - size) / 5) + size, size, size * .15);
    _numPadView = [[BKNumPadView alloc] initWithFrame:numPadFrame];
    
    [self.view addSubview:_numPadView];
    
    
}

- (void)buttonWasTapped:(id)sender
{
    UIButton *curButton = (UIButton *) sender;
    NSUInteger currentNum = _numPadView.getCurrentNumber;
    // Tag is 21 = 2nd row, 1st column (Subtract 1 for array[r][c])
    int row = curButton.tag / 10 - 1;
    int col = curButton.tag % 10 - 1;
    BOOL wasValidMove = [_gridModel setValue:currentNum atRow:row atCol:col];
    if (wasValidMove) {
        [_gridView setButtonValue:currentNum atRow:row atCol:col canSelect:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid move"
                                                        message:@"Move was illogical"
                                                        delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
        [alert show];
    }
    // We have won the game!
    if ([_gridModel isFull]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"#Winning"
                                                        message:@"You won!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        // Lock all cells
        [_gridView makeAllCellsUnselectable];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
