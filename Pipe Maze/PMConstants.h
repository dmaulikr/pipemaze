//
//  PMConstants.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/15/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMConstants : NSObject

enum {
    MazePieceStraight = 2,
    MazePieceCorner = 1,
    MazePieceBlock = 0,
    MazePieceEmpty = 3
    
} typedef MazePieces;

enum {
    PieceDirectionNorth = 0,
    PieceDirectionEast = 1,
    PieceDirectionSouth = 2,
    PieceDirectionWest = 3,
    PieceDirectionNone = 4
} typedef PieceDirection;

@end
