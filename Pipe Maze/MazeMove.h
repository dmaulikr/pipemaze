//
//  MazeMove.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/17/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMConstants.h"

@interface MazeMove : NSObject

-(instancetype)init;
@property (nonatomic) BOOL didRemove;
@property (nonatomic) NSInteger newIndex;
@property (nonatomic) NSInteger oldIndex;
@property (nonatomic) MazePieces piece;
@property (nonatomic) MazePieces oldPiece;
@property (nonatomic) PieceDirection oldStartDirection;
@property (nonatomic) PieceDirection oldEndDirection;
@property (nonatomic) PieceDirection newStartDirection;
@property (nonatomic) PieceDirection newEndDirection;
@end
