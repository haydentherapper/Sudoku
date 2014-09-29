//
//  BKInfoViewController.m
//  Sudoku
//
//  Created by Hayden Blauzvern on 9/28/14.
//  Copyright (c) 2014 BlauzvernKutsko. All rights reserved.
//

#import "BKInfoViewController.h"
#import "BKInfoView.h"

@interface BKInfoViewController () {
    BKInfoView* _infoView;
}

@end

@implementation BKInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = self.view.frame;
    CGFloat x = CGRectGetWidth(frame)*.1;
    CGFloat y = CGRectGetHeight(frame)*.1;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80;
    
    CGRect gridFrame = CGRectMake(x, y, size, size);
    
    // Create grid view and populates
    _infoView = [[BKInfoView alloc] initWithFrame:gridFrame];
    
    [self.view addSubview:_infoView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
