//
//  BGGridView.m
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/11/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import "BKGridView.h"

@interface BKGridView () {
    NSMutableArray* _buttonArray;
}

@end

@implementation BKGridView

- (id)initWithFrame:(CGRect)frame ofSize:(CGFloat)size
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        // Leaving 0.01 each for four lines separating blocks
        CGFloat buttonSize = (size*0.96)/9.0;
        
        // Array to hold 81 buttons
        _buttonArray = [[NSMutableArray alloc] init];
        
        // create button
        for (int row = 1; row < 10; row++) {
            for (int col = 1; col < 10; col++) {
                //Create the button
                // Offset of 0.01*size for each major line.
                // First is at begining, additional after each 3 (1+(j-1)/3)
                CGFloat x = (col-1)*buttonSize+(1+(col-1)/3)*size*0.01;
                CGFloat y = (row-1)*buttonSize + (1+(row-1)/3)*size*0.01;
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x,y,buttonSize,buttonSize)];
                
                button.backgroundColor = [UIColor whiteColor];
                [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
                
                // Tag of 21 represents second row, first column
                [button setTag:(row*10+col)];
                [button addTarget:self action:@selector(buttonPressed:)forControlEvents:UIControlEventTouchUpInside];
                
                // From Stack Overflow
                [button setBackgroundImage:[self imageWithColor:[UIColor yellowColor]]
                                  forState:UIControlStateHighlighted];
                [button.layer setBorderWidth:2.0f];
                
                //Store the button in our array
                [_buttonArray addObject:button];
                [self addSubview:button];
                
            }
        }
    }
    return self;
}

- (void)setButtonValue:(int)value atRow:(int)row atCol:(int)col
{
    // Only show symbol if non-zero
    if (value != 0) {
        [[_buttonArray objectAtIndex:9*row + col]
                setTitle:[NSString stringWithFormat:@"%i",value]
                forState:UIControlStateNormal];
    }
}

- (IBAction)buttonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(buttonWasTapped:)]) {
        [self.delegate buttonWasTapped:sender];
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