//
//  BGGridView.h
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/11/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BGGridViewDelegate
- (void)buttonWasTappedInChild:(BGViewController *)childViewController;
@end

@interface BGGridView : UIView

@property (weak, nonatomic) id <BGGridViewDelegate> delegate;

@end
