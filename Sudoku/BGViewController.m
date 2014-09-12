//
//  BGViewController.m
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/11/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import "BGViewController.h"
#import "BGGrid.h"

@interface BGViewController () {
    UIView* _gridView;
    UIButton* _button;
    NSMutableArray* _buttonArray;
}

@end

@implementation BGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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
    
    CGFloat buttonSize = size/9.0;
    
    _buttonArray = [[NSMutableArray alloc] init];
    
    // create button
    for (int i = 1; i < 10; i++) {
        for (int j = 1; j < 10; j++) {
            //Create the button
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((j-1)*buttonSize,(i-1)*buttonSize, buttonSize, buttonSize)];
            button.backgroundColor = [UIColor redColor];
            [button setTitle:[NSString stringWithFormat:@"%i%i",i,j] forState:UIControlStateNormal];
            //Store the button in our array
            [_buttonArray addObject:button];
            [_gridView addSubview:button];
        }
    }
    
    // create target for button
    [_button addTarget:self action:@selector(buttonPressed:)forControlEvents:UIControlEventTouchUpInside];
    [_button setTitle:@"Hit me!" forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize: 12];
    [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    // Create Grid view
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonPressed: (id)sender
{
    NSLog(@"You touched the button!");
}

@end
