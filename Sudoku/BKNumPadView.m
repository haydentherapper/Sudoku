//
//  BKNumPadView.m
//  Sudoku
//
//  Created on 9/19/14.
//  Copyright (c) 2014 Blauzvern Kutsko. All rights reserved.
//

#import "BKNumPadView.h"

@interface BKNumPadView () {
    NSMutableArray* _buttonArray;
    NSUInteger _currentTag;
}

@end

@implementation BKNumPadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Init array of numbers
        _buttonArray = [[NSMutableArray alloc] init];
        
        self.backgroundColor = [UIColor blackColor];
        CGFloat frameSizeY = CGRectGetHeight(frame);
        CGFloat frameSizeX = CGRectGetWidth(frame);
        
        // Create the offset for the outer margins
        CGFloat buttonOffset = .02*frameSizeX;
        // Create the inner margin size
        CGFloat marginSize = .01*frameSizeX;
        
        // From those, calculate the button size (note non-square buttons)
        CGFloat buttonSizeY = frameSizeY - buttonOffset*2;
        CGFloat buttonSizeX = (frameSizeX - (buttonOffset*2 + marginSize*8))/9;
        
        // Go from 1-9 to set tag to what's visible in the view
        for (int butNum = 1; butNum < 10; ++butNum) {
            CGFloat buttonX = buttonOffset + (butNum - 1)*buttonSizeX + marginSize*(butNum-1);
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonOffset, buttonSizeX,buttonSizeY)];
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
            [button setTitle:[NSString stringWithFormat:@"%i", butNum]  forState: UIControlStateNormal];
            
            [button setTag:butNum];
            [button addTarget:self action:@selector(buttonPressed:)forControlEvents:UIControlEventTouchUpInside];
            
            //Store the button in our array
            [_buttonArray addObject:button];
            [self addSubview:button];
        }
        
        // Default - Set '1' to being currently selected
        UIButton* firstButton = [_buttonArray objectAtIndex:0];
        [firstButton setBackgroundColor:[UIColor yellowColor]];
        _currentTag = [firstButton tag];
    }
    return self;
}

- (void)buttonPressed:(id)selector
{
    // Deselect old button
    [[_buttonArray objectAtIndex:_currentTag - 1] setBackgroundColor:[UIColor whiteColor]];
    // Highlight new button and set current number
    UIButton* currentButton = (UIButton *) selector;
    [currentButton setBackgroundColor:[UIColor yellowColor]];
    _currentTag = currentButton.tag;
}

- (int)getCurrentNumber
{
    return _currentTag;
}

@end
