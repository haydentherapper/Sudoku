//
//  BKControlPanelView.m
//  Sudoku
//
//  Created by HMC Guest on 9/25/14.
//  Copyright (c) 2014 BlauzvernKutsko. All rights reserved.
//

#import "BKControlPanelView.h"

@interface BKControlPanelView () {
    UIButton* _newGameButton;
    UIButton* _modeSwitchButton;
    UIButton* _saveButton;
    UIButton* _restoreButton;
    UIButton* _statisticsButton;
    UIButton* _informationButton;
}

@end

@implementation BKControlPanelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        CGFloat frameSizeY = CGRectGetHeight(frame);
        CGFloat frameSizeX = CGRectGetWidth(frame);
        
        // Leaving 0.01 each for four lines separating blocks
        CGFloat buttonSizeX = (frameSizeX*0.96)/3;
        CGFloat buttonSizeY = (frameSizeY*0.96)/2;
        
    }
    return self;
}



@end
