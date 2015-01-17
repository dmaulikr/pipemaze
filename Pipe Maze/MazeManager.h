//
//  MazeManager.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/16/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Maze.h"
#import "MazePiece.h"

@protocol MazeManagerDelegate <NSObject>

-(void)updateStraightPieceCount:(NSInteger)straight corner:(NSInteger)corner;

@end

@interface MazeManager : NSObject

-(instancetype)init;
-(instancetype)initWithMaze:(Maze *)maze size:(CGSize)size;
-(MazePiece *)getPieceForIndex:(NSInteger)index;
-(void)updatePiece:(MazePiece *)piece atIndex:(NSInteger)index;
-(BOOL)canPlacePiece:(MazePiece *)piece;
-(void)restartMaze;
-(NSString *)checkMaze;

-(NSInteger)saveTime:(NSInteger)time;


@property id<MazeManagerDelegate> delegate;


@property (nonatomic) NSInteger straight;
@property (nonatomic) NSInteger corner;


struct {
    MazePieces piece;
    PieceDirection start;
    PieceDirection end;
    NSInteger index;
} typedef MazeStruct;

@end
