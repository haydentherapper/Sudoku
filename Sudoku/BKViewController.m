//
//  BGViewController.m
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/11/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
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
    
    CGRect numPadFrame = CGRectMake(x, y + round((CGRectGetHeight(frame) - size) / 5) + size, size, size * .15);
    _numPadView = [[BKNumPadView alloc] initWithFrame:numPadFrame];
    
    [self.view addSubview:_numPadView];
    
    
}

- (void)buttonWasTapped:(id)sender
{
    UIButton *curButton = (UIButton *) sender;
    NSUInteger currentNum = _numPadView.getCurrentNumber;
    int row = curButton.tag / 10;
    int col = curButton.tag % 10;
    BOOL wasValidMove = [_gridModel setValue:currentNum atRow:row atCol:col];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
