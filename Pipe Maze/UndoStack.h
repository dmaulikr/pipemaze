//
//  UndoStack.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/17/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMConstants.h"
#import "MazeMove.h"

@interface UndoStack : NSObject

-(instancetype)init;

-(void)pushMove:(MazeMove *)move;
-(MazeMove *)popMove;

@end
