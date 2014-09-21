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
}

@end

@implementation BKNumPadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        CGFloat frameSizeY = CGRectGetHeight(frame);
        CGFloat frameSizeX = CGRectGetWidth(frame);
        CGFloat buttonOffset = .02*frameSizeX;
        CGFloat marginSize = .01*frameSizeX;
        CGFloat buttonSizeY = frameSizeY - buttonOffset*2;
        CGFloat buttonSizeX = (frameSizeX - (buttonOffset*2 + marginSize*8))/9;
        
        for (int butNum = 1; butNum < 10; ++butNum)
        {
            CGFloat buttonX = buttonOffset + (butNum - 1)*buttonSizeX + marginSize*(butNum-1);
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonOffset, buttonSizeX,buttonSizeY)];
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
            [button setTitle:[NSString stringWithFormat:@"%i", butNum]  forState: UIControlStateNormal];
            
            [button setTag:(butNum)];
            
            // From Stack Overflow
            [button setBackgroundImage:[self imageWithColor:[UIColor yellowColor]]
                              forState:UIControlStateHighlighted];
            
            //Store the button in our array
            [_buttonArray addObject:button];
            [self addSubview:button];

        }
        
    }
    return self;
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
