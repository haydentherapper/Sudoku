//
//  BKNumPadView.m
//  Sudoku
//
//  Created by Hayden Blauzvern on 9/19/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
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
        _buttonArray = [[NSMutableArray alloc] init];
        
        self.backgroundColor = [UIColor blackColor];
        CGFloat frameSizeY = CGRectGetHeight(frame);
        CGFloat frameSizeX = CGRectGetWidth(frame);
        CGFloat buttonOffset = .02*frameSizeX;
        CGFloat marginSize = .01*frameSizeX;
        CGFloat buttonSizeY = frameSizeY - buttonOffset*2;
        CGFloat buttonSizeX = (frameSizeX - (buttonOffset*2 + marginSize*8))/9;
        
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
        
        UIButton* firstButton = [_buttonArray objectAtIndex:0];
        [firstButton setBackgroundColor:[UIColor yellowColor]];
        _currentTag = [firstButton tag];
    }
    return self;
}

- (void)buttonPressed:(id)selector
{
    [[_buttonArray objectAtIndex:_currentTag - 1]
     setBackgroundColor:[UIColor whiteColor]];
    UIButton* currentButton = (UIButton *) selector;
    [currentButton setBackgroundColor:[UIColor yellowColor]];
    _currentTag = currentButton.tag;
}

- (int) getCurrentNumber
{
    return _currentTag;
}

@end
