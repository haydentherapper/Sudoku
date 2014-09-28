//
//  BKControlPanelView.h
//  Sudoku
//
//  Created by HMC Guest on 9/25/14.
//  Copyright (c) 2014 BlauzvernKutsko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BKControlPanelViewDelegate <NSObject>
@required
- (void)startNewGame:(id)sender;
- (void)saveGame:(id)sender;
- (void)restoreGame:(id)sender;
- (void)switchModes:(id)sender;
@end

@interface BKControlPanelView : UIView

@property (weak, nonatomic) id <BKControlPanelViewDelegate> delegate;

@end
