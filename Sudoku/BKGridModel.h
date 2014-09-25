//
//  BKGridModel.h
//  Sudoku
//
//  Created on 9/18/14.
//  Copyright (c) 2014 Blauzvern Kutsko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKGridModel : NSObject

- (void)initializeGrid;

- (int)getValueAtRow:(int)row atCol:(int)col;
- (BOOL)setValue:(int)value atRow:(int)row atCol:(int)col;
- (BOOL)isFull;

@end
