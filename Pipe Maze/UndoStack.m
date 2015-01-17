//
//  UndoStack.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/17/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "UndoStack.h"

@interface UndoStack ()
@property (nonatomic, strong) NSMutableArray *stack;
@end

@implementation UndoStack

-(instancetype)init {
    self = [super init];
    if(self) {
        self.stack = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)pushMove:(MazeMove *)move {
    [self.stack insertObject:move atIndex:0];
}

-(MazeMove *)popMove {
    if(self.stack.count == 0)
        return nil;
    MazeMove *move = [self.stack objectAtIndex:0];
    [self.stack removeObjectAtIndex:0];
    return move;
}

@end
