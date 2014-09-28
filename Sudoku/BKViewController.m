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
#import "BKControlPanelView.h"

@interface BKViewController() <BKGridViewDelegate, BKControlPanelViewDelegate> {
    BKGridView* _gridView;
    BKGridModel* _gridModel;
    BKNumPadView* _numPadView;
    BKControlPanelView* _controlPanelView;
    BOOL _isHardMode;
}

@end

@implementation BKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _isHardMode = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create grid frame
    CGRect frame = self.view.frame;
    CGFloat x = CGRectGetWidth(frame)*.1;
    CGFloat y = CGRectGetHeight(frame)*.05;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80;
    
    CGRect gridFrame = CGRectMake(x, y, size, size);
    
    _gridModel = [BKGridModel alloc];
    [_gridModel parseGrids];
    [_gridModel initializeGrid];
    
    // Create grid view and populates
    _gridView = [[BKGridView alloc] initWithFrame:gridFrame ofSize:size];
    
    // Fill all grid cells with nums from gridView
    [self initGridView];
    
    // Assign gridView's delegate to be the controller
    _gridView.delegate = self;

    [self.view addSubview:_gridView];
    
    // Constants allow us to shape the numpad
    CGRect numPadFrame = CGRectMake(x, y + round((CGRectGetHeight(frame) - size) / 100) + size, size, size * .15);
    _numPadView = [[BKNumPadView alloc] initWithFrame:numPadFrame];
    
    [self.view addSubview:_numPadView];
    
    //create the control panel frame
    CGRect controlPanelFrame  = CGRectMake(x, y + round((CGRectGetHeight(frame) - size) / 4) + size, size, size*.3);
    _controlPanelView = [[BKControlPanelView alloc] initWithFrame:controlPanelFrame];
    
    // Assign controlPanelView's delegate to be this controller
    _controlPanelView.delegate = self;
    
    [self.view addSubview:_controlPanelView];
    
}

- (void)buttonWasTapped:(id)sender
{
    UIButton *curButton = (UIButton *) sender;
    NSUInteger currentNum = _numPadView.getCurrentNumber;
    // Tag is 21 = 2nd row, 1st column (Subtract 1 for array[r][c])
    int row = curButton.tag / 10 - 1;
    int col = curButton.tag % 10 - 1;
    if (_isHardMode){
        [_gridModel setValue:currentNum atRow:row atCol:col];
        [_gridView setButtonValue:currentNum atRow:row atCol:col canSelect:YES];
    } else {
        BOOL wasValidMove = [_gridModel checkValue:currentNum atRow:row atCol:col];
        if (wasValidMove) {
            [_gridModel setValue:currentNum atRow:row atCol:col];
            [_gridView setButtonValue:currentNum atRow:row atCol:col canSelect:YES];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid move"
                                                            message:@"Move was illogical"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    
    
    // We have won the game!
    if ([_gridModel isFull]) {
        if ([_gridModel wonTheGame]){
        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"#Winning"
                                                            message:@"You won!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
            [alert show];
            // Lock all cells
            [_gridView makeAllCellsUnselectable];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mistakes were made"
                                                            message:@"Keep trying!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            
            [alert show];

        }
        
    }
}

- (void)initGridView
{
    //check the initial state of the board
    NSString* initialState = [_gridModel getInitialState];

    for (int row = 0; row < 9; row++) {
        for (int col = 0; col < 9; col++) {
            int value = [_gridModel getValueAtRow:row atCol:col];
            BOOL wasInitialValue = ([initialState characterAtIndex:row*9+col] != '.');
            [_gridView setButtonValue:value atRow:row atCol:col canSelect:!wasInitialValue];
        }
    }
}

- (void)startNewGame:(id)sender
{
    [_gridModel initializeGrid];
    
    // Fill all grid cells with nums from gridView
    [self initGridView];
}

- (void)saveGame:(id)sender
{
    [_gridModel saveYourSelf];
}

- (void)restoreGame:(id)sender
{
    [_gridModel restoreSelf];
    [self initGridView];
}

- (void)switchModes:(id)sender
{
    _isHardMode = !(_isHardMode);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
