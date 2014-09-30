//
//  BKControlPanelView.m
//  Sudoku
//
//  Created by Josh Kutsko on 9/25/14.
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
        // Each button gets its own title, target, and background image color
        NSMutableArray *buttonArray = [[NSMutableArray alloc] init];
        _newGameButton     = [UIButton alloc];
        [_newGameButton setTitle:@"New Game"  forState: UIControlStateNormal];
        [_newGameButton addTarget:self action:@selector(newGameButtonPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
        [_newGameButton setBackgroundImage:[self imageWithColor:[UIColor redColor]]
                          forState:UIControlStateHighlighted];
        
        _modeSwitchButton  = [UIButton alloc];
        [_modeSwitchButton setTitle:@"Easy Mode"  forState: UIControlStateNormal];
        [_modeSwitchButton addTarget:self action:@selector(switchModesButtonPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
        [_modeSwitchButton setTag: 0]; // Initially not set to hard mode
        [_modeSwitchButton setBackgroundImage:[self imageWithColor:[UIColor orangeColor]]
                                  forState:UIControlStateHighlighted];
        
        _saveButton        = [UIButton alloc];
        [_saveButton setTitle:@"Save Game"  forState: UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(saveButtonPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
        [_saveButton setBackgroundImage:[self imageWithColor:[UIColor yellowColor]]
                                     forState:UIControlStateHighlighted];

        _restoreButton     = [UIButton alloc];
        [_restoreButton setTitle:@"Load Game"  forState: UIControlStateNormal];
        [_restoreButton addTarget:self action:@selector(restoreButtonPressed:)
              forControlEvents:UIControlEventTouchUpInside];
        [_restoreButton setBackgroundImage:[self imageWithColor:[UIColor greenColor]]
                               forState:UIControlStateHighlighted];

        _statisticsButton  = [UIButton alloc];
        [_statisticsButton setTitle:@"See Statistics"  forState: UIControlStateNormal];
        [_statisticsButton addTarget:self action:@selector(statsButtonPressed:)
                    forControlEvents:UIControlEventTouchUpInside];
        [_statisticsButton setBackgroundImage:[self imageWithColor:[UIColor blueColor]]
                                  forState:UIControlStateHighlighted];

        _informationButton = [UIButton alloc];
        [_informationButton setTitle:@"Information"  forState: UIControlStateNormal];
        [_informationButton addTarget:self action:@selector(infoButtonPressed:)
                    forControlEvents:UIControlEventTouchUpInside];
        [_informationButton setBackgroundImage:[self imageWithColor:[UIColor purpleColor]]
                                     forState:UIControlStateHighlighted];
        
        [buttonArray addObject: _newGameButton];
        [buttonArray addObject: _modeSwitchButton];
        [buttonArray addObject: _saveButton];
        [buttonArray addObject: _restoreButton];
        [buttonArray addObject: _statisticsButton];
        [buttonArray addObject: _informationButton];
        
        // Populate the view with above buttons
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
        // ModeSwitch button's tag saves current mode
        if (_modeSwitchButton.tag == 0){
            [_modeSwitchButton setTitle:@"Hard Mode" forState:UIControlStateNormal];
            _modeSwitchButton.tag = 1;
        } else {
            [_modeSwitchButton setTitle:@"Easy Mode" forState:UIControlStateNormal];
            _modeSwitchButton.tag = 0;
        }
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

- (IBAction)infoButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(displayInfo:)]) {
        [self.delegate displayInfo:sender];
    }
}

- (IBAction)statsButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(displayStats:)]) {
        [self.delegate displayStats:sender];
    }
}

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


@end
