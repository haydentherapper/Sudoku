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
#import "BKInfoViewController.h"

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
    
    // Initially users start on easy mode
    _isHardMode = NO;
    
    // Set background to custom image (Function from Stackoverflow)
    self.view.backgroundColor = [UIColor colorWithPatternImage:[self
                                                                resizeImage:[UIImage imageNamed:@"white spot blue.jpg"] newSize:self.view.frame.size]];
    
    // Create grid frame
    CGRect frame = self.view.frame;
    CGFloat x = CGRectGetWidth(frame)*.1;
    CGFloat y = CGRectGetHeight(frame)*.05;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80;
    
    CGRect gridFrame = CGRectMake(x, y, size, size);
    
    // Init gride model and populate model
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

// From Stackoverflow
- (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);
    CGContextDrawImage(context, newRect, imageRef);
    
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}

// Action to do before view appears
- (void)viewWillAppear:(BOOL)animated
{
    // Hide navigation bar
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)buttonWasTapped:(id)sender
{
    UIButton *curButton = (UIButton *) sender;
    NSUInteger currentNum = _numPadView.getCurrentNumber;
    // Tag is 21 = 2nd row, 1st column (Subtract 1 for array[r][c])
    int row = curButton.tag / 10 - 1;
    int col = curButton.tag % 10 - 1;
    
    // If the user is on hard mode, simply set the selected cell...
    if (_isHardMode){
        [_gridModel setValue:currentNum atRow:row atCol:col];
        [_gridView setButtonValue:currentNum atRow:row atCol:col canSelect:YES];
    } else {
        // ...else, perform logic checks
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
    
    // If the board is full, check if we've won...
    if ([_gridModel isFull]) {
        // We've won!
        if ([_gridModel wonTheGame]) {
            NSString* statsPath = [[NSBundle mainBundle] pathForResource:@"stats" ofType:@"txt"];
            NSError* error;
            NSString* stats = [[NSString alloc] initWithContentsOfFile:statsPath
                                                              encoding:NSUTF8StringEncoding error:(&error)];
            int score = [stats intValue] + 1;
            [[NSString stringWithFormat:@"%i", score]
                    writeToFile:statsPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
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
            // Set cell to be selectable if it was not an initial value
            [_gridView setButtonValue:value atRow:row atCol:col canSelect:!wasInitialValue];
        }
    }
}

- (void)startNewGame:(id)sender
{
    // Init the model and reset the view colors
    [_gridModel initializeGrid];
    [_gridView resetGrid];
    
    // Fill all grid cells with nums from gridView
    [self initGridView];
}

- (void)saveGame:(id)sender
{
    [_gridModel saveYourSelf];
}

- (void)restoreGame:(id)sender
{
    // Restore save file
    [_gridModel restoreSelf];
    [_gridView resetGrid];

    // Fill all grid cells with nums from gridView
    [self initGridView];
}

- (void)switchModes:(id)sender
{
    _isHardMode = !(_isHardMode);
    
}

- (void)longPressForErase:(UILongPressGestureRecognizer*)sender
{
    UIButton* button = (UIButton*) sender.view;
    int row = button.tag / 10 - 1;
    int col = button.tag % 10 - 1;
    [_gridModel setValue:0 atRow:row atCol:col]; // Erases selected number
}

- (void)displayInfo:(id)sender
{
    // Performs a segue between the current ViewController and the InfoViewController
    [self performSegueWithIdentifier:@"SegueToInfoPanel" sender:self];
}

- (void)displayStats:(id)sender
{
    NSString* statsPath = [[NSBundle mainBundle] pathForResource:@"stats" ofType:@"txt"];
    NSError* error;
    NSString* stats = [[NSString alloc] initWithContentsOfFile:statsPath encoding:NSUTF8StringEncoding error:(&error)];
    
    NSString* displayString;
    if ([stats isEqualToString:@"1"]) {
        displayString = [NSString stringWithFormat:@"You've won %@ game!", stats];
    } else {
        displayString = [NSString stringWithFormat:@"You've won %@ games!", stats];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game statistics"
                                                    message:displayString
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
