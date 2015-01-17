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
    BOOL checked[25];
}
@property (nonatomic, strong) Maze *maze;
@property (nonatomic) CGSize pieceSize;
@property (nonatomic) NSInteger startIndex;
@property (nonatomic) NSInteger endIndex;

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
        self.startIndex = index;
        s.index = index;
    }
    
    if([str isEqualToString:@"E"]) {
        s.piece = self.maze.endPiece;
        s.start = self.maze.endDirection;
        s.end = [self getEndDirectionForPiece:self.maze.endPiece startDirection:self.maze.endDirection];
        self.endIndex = index;
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
    self.straight = self.maze.straightPieces;
    self.corner = self.maze.curvedPieces;
    
    [self.delegate updateStraightPieceCount:self.straight corner:self.corner];
}

-(NSInteger)saveTime:(NSInteger)time {
    if(time < [self.maze.starTimes[4] integerValue])
        return 5;
    else if(time < [self.maze.starTimes[3] integerValue])
        return 4;
    else if(time < [self.maze.starTimes[2] integerValue])
        return 3;
    else if(time < [self.maze.starTimes[1] integerValue])
        return 2;
    else
        return 1;
    return 0;
}

-(NSString *)checkMaze {
    if(self.straight > 0 || self.corner > 0) {
        return @"You need to use all the pieces to complete the level.";
    }
    
    for(int i = 0; i < 25; i++)
        checked[i] = NO;
    
    BOOL success = [self checkMaze:mazeArray[self.startIndex]];
    for(int i = 0; i<25; i++) {
        MazeStruct s = mazeArray[i];
        if(s.piece != MazePieceBlock && s.piece != MazePieceEmpty && !checked[i])
            success = NO;
    }
    if(success) {
        return nil;
    }
    return @"Maze not correct, please try again.";
}

-(BOOL)checkMaze:(MazeStruct)s {
    
    if(s.index == self.endIndex) {
        checked[s.index] = YES;
        return YES;
    }
    checked[s.index] = YES;
    PieceDirection validStartLocations[2];
    validStartLocations[0] = s.start;
    validStartLocations[1] = s.end;
    NSInteger index = [self getAdjacentIndex:s.start index:s.index];
    if(index > -1) {
        MazeStruct temp = mazeArray[index];
        if((temp.piece == MazePieceStraight || temp.piece == MazePieceCurved) && checked[index] == NO) {
            if([self pieceIsContinued:s.start start:temp.start end:temp.end])
                return [self checkMaze:temp];
        }
    }
    //First option has no continuation check other end
    index = [self getAdjacentIndex:s.end index:s.index];
    MazeStruct temp = mazeArray[index];
    if(temp.piece == MazePieceBlock || temp.piece == MazePieceEmpty) {
        return NO; //both lead to a dead end
    }
    else { //second option isnt dead end. check for continuation
        if(checked[index] == NO) {
            if([self pieceIsContinued:s.end start:temp.start end:temp.end])
                return [self checkMaze:temp];
        }
    }
    
    return NO;
}

#pragma mark - helper functions

-(BOOL)pieceIsContinued:(PieceDirection)direction start:(PieceDirection)start end:(PieceDirection)end {
    if(direction == PieceDirectionNorth) {
        if(start == PieceDirectionSouth || end == PieceDirectionSouth)
            return YES;
    }
    if(direction == PieceDirectionEast) {
        if(start == PieceDirectionWest || end == PieceDirectionWest)
            return YES;
    }
    if(direction == PieceDirectionSouth) {
        if(start == PieceDirectionNorth || end == PieceDirectionNorth)
            return YES;
    }
    if(direction == PieceDirectionWest) {
        if(start == PieceDirectionEast || end == PieceDirectionEast)
            return YES;
    }
    
    
    return NO;
}

-(NSInteger)getAdjacentIndex:(PieceDirection)direction index:(NSInteger)index{
    switch(direction) {
        case PieceDirectionNorth:
            if(index < 5)
                return -1;
            return index - 5;
            break;
        case PieceDirectionEast:
            if(index%5 == 4)
                return -1;
            return ++index;
            break;
        case PieceDirectionSouth:
            if(index > 20)
                return -1;
            return index+5;
            break;
        case PieceDirectionWest:
            if(index%5 == 0)
                return -1;
            return --index;
            break;
        default:
            return -1;
            break;
    }
}

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
