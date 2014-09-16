//
//  BGGridView.m
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/11/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import "BGGridView.h"

@interface BGGridView () {
    NSMutableArray* _buttonArray;
}

@end

@implementation BGGridView // Can this just be an implementation or does it need to be both?

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)makeNewGridViewOfSize:(CGFloat)size withGrid:(int[9][9])initialGrid
{
    self.backgroundColor = [UIColor blackColor];
    
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
            [self addSubview:button];
            
        }
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
