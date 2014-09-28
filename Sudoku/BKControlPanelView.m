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
        CGFloat buttonSizeY = (frameSizeY*0.91)/2;
        CGFloat marginSizeX = frameSizeX*.01;
        CGFloat marginSizeY = frameSizeY*.03;
        
        //Create the six buttons and place them six in an array
        NSMutableArray *buttonArray = [[NSMutableArray alloc] init];
        _newGameButton     = [UIButton alloc];
        [_newGameButton setTitle:@"New Game"  forState: UIControlStateNormal];
        [_newGameButton addTarget:self action:@selector(newGameButtonPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
        
        _modeSwitchButton  = [UIButton alloc];
        [_modeSwitchButton setTitle:@"Easy Mode"  forState: UIControlStateNormal];
        [_newGameButton addTarget:self action:@selector(switchModesButtonPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
        
        _saveButton        = [UIButton alloc];
        [_saveButton setTitle:@"Save Game"  forState: UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(saveButtonPressed:)
                 forControlEvents:UIControlEventTouchUpInside];

        _restoreButton     = [UIButton alloc];
        [_restoreButton setTitle:@"Load Game"  forState: UIControlStateNormal];
        [_restoreButton addTarget:self action:@selector(restoreButtonPressed:)
              forControlEvents:UIControlEventTouchUpInside];

        _statisticsButton  = [UIButton alloc];
        [_statisticsButton setTitle:@"See Statistics"  forState: UIControlStateNormal];

        _informationButton = [UIButton alloc];
        [_informationButton setTitle:@"Information"  forState: UIControlStateNormal];
        
        [buttonArray addObject: _newGameButton];
        [buttonArray addObject: _modeSwitchButton];
        [buttonArray addObject: _saveButton];
        [buttonArray addObject: _restoreButton];
        [buttonArray addObject: _statisticsButton];
        [buttonArray addObject: _informationButton];
        
        for (int r = 0; r < 3; r++) {
            for (int c = 0; c < 2; c++) {
                UIButton* button = [buttonArray objectAtIndex:r + c*3];
                
                button = [button initWithFrame:CGRectMake(marginSizeX + (marginSizeX + buttonSizeX)*r, (marginSizeY + buttonSizeY)*c + marginSizeY, buttonSizeX, buttonSizeY)];
                
                button.backgroundColor = [UIColor whiteColor];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
                [self addSubview:button];
            }
        }
    }
    return self;
}

- (IBAction)newGameButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(startNewGame:)]) {
        [self.delegate startNewGame:sender];
    }
}

- (IBAction)switchModesButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(switchModes:)]) {
        [self.delegate switchModes:sender];
    }
}

- (IBAction)saveButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(saveGame:)]) {
        [self.delegate saveGame:sender];
    }
}

- (IBAction)restoreButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(restoreGame:)]) {
        [self.delegate restoreGame:sender];
    }
}


@end
