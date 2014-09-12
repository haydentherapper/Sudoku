//
//  BGViewController.m
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/11/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import "BGViewController.h"
#import "BGGrid.h"
#import <QuartzCore/QuartzCore.h>

@interface BGViewController () {
    UIView* _gridView;
    NSMutableArray* _buttonArray;
}

@end

@implementation BGViewController

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

// This function is from Stack Overflow
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // create grid frame
    CGRect frame = self.view.frame;
    CGFloat x = CGRectGetWidth(frame)*.1;
    CGFloat y = CGRectGetHeight(frame)*.1;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80;
    
    CGRect gridFrame = CGRectMake(x, y, size, size);
    
    // create grid view
    _gridView = [[BGGrid alloc] initWithFrame:gridFrame];
    _gridView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_gridView];
    
    // Leaving 0.01 each for four lines separating blocks
    CGFloat buttonSize = (size*0.96)/9.0;
    
    // Array to hold 81 buttons
    _buttonArray = [[NSMutableArray alloc] init];
    
    // create button
    for (int i = 1; i < 10; i++) {
        for (int j = 1; j < 10; j++) {
            //Create the button
            // Offset of 0.01*size for each major line.
            // First is at begining, additional after each 3 (1+(j-1)/3)
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(((j-1)*buttonSize+(1+(j-1)/3)*size*0.01),(i-1)*buttonSize + (1+(i-1)/3)*size*0.01, buttonSize, buttonSize)];
            
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
            
            // Only show symbol if non-zero
            if (initialGrid[i-1][j-1] != 0) {
              [button setTitle:[NSString stringWithFormat:@"%i",initialGrid[i-1][j-1]] forState:UIControlStateNormal];
            }
            
            // Tag of 21 represents second row, first column
            [button setTag:(i*10+j)];
            [button addTarget:self action:@selector(buttonPressed:)forControlEvents:UIControlEventTouchUpInside];
            
            // From stack overflow
            [button setBackgroundImage:[self imageWithColor:[UIColor yellowColor]] forState:UIControlStateHighlighted];
            [button.layer setBorderWidth:2.0f];
            
            //Store the button in our array
            [_buttonArray addObject:button];
            [_gridView addSubview:button];
            
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonPressed: (id)sender
{
    UIButton *curButton = (UIButton *) sender;
    NSLog(@"You touched the button with row %i and column %i", (curButton.tag / 10), (curButton.tag % 10));
}

@end
