//
//  BKGridModel.h
//  Sudoku
//
//  Created by Hayden Blauzvern on 9/18/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKGridModel : NSObject

- (void) initializeGrid;

- (int) getValueAtRow:(int)row atCol:(int)col;
- (void) setValue:(int)value atRow:(int)row atCol:(int)col;

@end