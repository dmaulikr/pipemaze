//
//  Maze.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/15/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMConstants.h"
#import "MazePiece.h"

@interface Maze : NSObject

-(instancetype)init;
-(MazePiece *)getMazePieceAtIndex:(NSInteger)index withFrame:(CGRect)frame;
-(MazePiece *)getStartingMazePiece:(CGRect)frame;
-(MazePiece *)getEndingMazePiece:(CGRect)frame;

@property (nonatomic, strong) NSString *levelName;
@property (nonatomic, strong) NSArray *originalBoard;
@property (nonatomic, strong) NSMutableArray *playingBoard;
@property (nonatomic) MazePieces startPiece;
@property (nonatomic) PieceDirection startDirection;
@property (nonatomic) MazePieces endPiece;
@property (nonatomic) PieceDirection endDirection;

@property (nonatomic) NSInteger straightPieces;
@property (nonatomic) NSInteger curvedPieces;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *finishedText;

@property (nonatomic, strong) NSArray *starTimes;

@end
