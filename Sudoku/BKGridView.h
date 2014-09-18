//
//  BGGridView.h
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/11/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BKGridViewDelegate <NSObject>
@required
- (void)buttonWasTapped:(id)sender;
@end

@interface BKGridView : UIView

- (id)initWithFrame:(CGRect)frame ofSize:(CGFloat)size withGrid:(int[9][9])initialGrid;

@property (weak, nonatomic) id <BKGridViewDelegate> delegate;

@end
