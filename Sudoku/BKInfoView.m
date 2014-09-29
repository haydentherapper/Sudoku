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
        CGFloat y = CGRectGetHeight(frame)*.1;
        CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80;
        CGRect textViewFrame = CGRectMake(x, y, size, size);
        UITextView* uiTextView = [[UITextView alloc]
                                  initWithFrame:textViewFrame];
        [uiTextView setFont:[UIFont systemFontOfSize:18.0f]];
        uiTextView.text = @"Welcome to Sudoku!\n\nIn order to win...";
        
        [self addSubview:uiTextView];
    }
    return self;
}

@end
