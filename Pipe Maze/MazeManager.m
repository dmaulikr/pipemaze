//
//  MazeManager.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/16/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "MazeManager.h"

@interface MazeManager (){
    MazeStruct mazeArray[25];
}
@property (nonatomic, strong) Maze *maze;
@property (nonatomic) CGSize pieceSize;

@end

@implementation MazeManager

-(instancetype)init {
    self = [super init];
    if(self) {
        self.maze = nil;
        self.straight = 0;
        self.corner = 0;
    }
    return self;
}

-(instancetype)initWithMaze:(Maze *)maze size:(CGSize)size{
    self = [super init];
    if(self) {
        self.maze = maze;
        self.pieceSize = size;
        self.straight = maze.straightPieces;
        self.corner = maze.curvedPieces;
        [self setupManager];
    }
    return self;
}

-(void)setupManager {
    for(int i = 0; i < self.maze.originalBoard.count; i++) {
        mazeArray[i] = [self createStruct:self.maze.originalBoard[i] index:i];
    }
}

-(MazeStruct)createStruct:(NSString *)str index:(NSInteger)index{
    MazeStruct s;
    if([str isEqualToString:@"S"]) {
        s.piece = self.maze.startPiece;
        s.start = self.maze.startDirection;
        s.end = [self getEndDirectionForPiece:self.maze.startPiece startDirection:self.maze.startDirection];
        s.index = index;
    }
    
    if([str isEqualToString:@"E"]) {
        s.piece = self.maze.endPiece;
        s.start = self.maze.endDirection;
        s.end = [self getEndDirectionForPiece:self.maze.endPiece startDirection:self.maze.endDirection];
        s.index = index;
    }
    
    if([str isEqualToString:@"0"]) {
        s.piece = MazePieceEmpty;
        s.start = PieceDirectionNone;
        s.end = PieceDirectionNone;
        s.index = index;
    }
    
    if([str isEqualToString:@"X"]) {
        s.piece = MazePieceBlock;
        s.start = PieceDirectionNone;
        s.end = PieceDirectionNone;
        s.index = index;
    }
    return s;
}

-(void)updatePiece:(MazePiece *)piece atIndex:(NSInteger)index {
    MazeStruct s = mazeArray[index];
    s.piece = piece.piece;
    s.start = piece.startDirection;
    s.end = piece.endDirection;
    s.index = index;
    mazeArray[index] = s;
}

-(BOOL)canPlacePiece:(MazePiece *)piece {
    if(piece.piece == MazePieceStraight) {
        if(self.straight > 0) {
            self.straight--;
            [self.delegate updateStraightPieceCount:self.straight corner:self.corner];
            return YES;
        }
        else {
            return NO;
        }
    }
    
    if(piece.piece == MazePieceCurved) {
        if(self.corner> 0) {
            self.corner--;
            [self.delegate updateStraightPieceCount:self.straight corner:self.corner];
            return YES;
        }
        else {
            return NO;
        }
    }
    return NO;
}


-(MazePiece *)getPieceForIndex:(NSInteger)index {
    if(index < 0 || index > 25) {
        return nil;
    }
    MazeStruct s = mazeArray[index];
    return [[MazePiece alloc] initWithFrame:CGRectMake(0, 0, self.pieceSize.width, self.pieceSize.width) pieceType:s.piece start:s.start end:s.end];
}

-(void)restartMaze {
    for(int i = 0; i < 25; i++){
        MazeStruct s = mazeArray[i];
        s.piece = MazePieceEmpty;
        s.start = PieceDirectionNone;
        s.end = PieceDirectionNone;
        s.index = 0;
    }
    [self setupManager];
}

#pragma mark - helper functions

-(PieceDirection)getEndDirectionForPiece:(MazePieces)piece startDirection:(PieceDirection)startDirection {
    if(piece == MazePieceStraight) {
        if(startDirection == PieceDirectionNorth)
            return PieceDirectionSouth;
        if(startDirection == PieceDirectionEast)
            return PieceDirectionWest;
        if(startDirection == PieceDirectionSouth)
            return PieceDirectionNorth;
        if(startDirection == PieceDirectionWest)
            return PieceDirectionEast;
    }
    
    else if(piece == MazePieceCurved) {
        if(startDirection == PieceDirectionNorth)
            return PieceDirectionEast;
        if(startDirection == PieceDirectionEast)
            return PieceDirectionSouth;
        if(startDirection == PieceDirectionSouth)
            return PieceDirectionWest;
        if(startDirection == PieceDirectionWest)
            return PieceDirectionNorth;
    }

    return PieceDirectionNone;
}

-(PieceDirection)getDirection:(NSString *)direction {
    if([direction isEqualToString:@"0"])
        return PieceDirectionNorth;
    if([direction isEqualToString:@"1"])
        return PieceDirectionEast;
    if([direction isEqualToString:@"2"])
        return PieceDirectionSouth;
    if([direction isEqualToString:@"3"])
        return PieceDirectionWest;
    else
        return PieceDirectionNone;
}

-(MazePieces)getPiece:(NSString *)piece {
    if([piece isEqualToString:@"1"])
        return MazePieceCurved;
    if([piece isEqualToString:@"2"])
        return MazePieceStraight;
    if([piece isEqualToString:@"X"])
        return MazePieceBlock;
    else
        return MazePieceEmpty;
}


@end
