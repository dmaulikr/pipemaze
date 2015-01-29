//
//  Maze.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/15/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "Maze.h"

@implementation Maze

-(instancetype)init {
    self = [super init];
    if(self) {
        
    }
    
    return self;
}

//Not right at all
-(MazePiece *)getMazePieceAtIndex:(NSInteger)index withFrame:(CGRect)frame{
    NSString *piece = self.originalBoard[index];
    MazePieces p = [self getPiece:piece];
    
    //needs to be fixed
    MazePiece *mazePiece = [[MazePiece alloc] initWithFrame:frame pieceType:p start:PieceDirectionNorth end:PieceDirectionEast];
    return mazePiece;
}

-(MazePiece *)getStartingMazePiece:(CGRect)frame {
    MazePiece *mazePiece = [[MazePiece alloc] initWithFrame:frame pieceType:self.startPiece start:self.startDirection end:PieceDirectionEast];
    return mazePiece;
}

-(MazePiece *)getEndingMazePiece:(CGRect)frame {
    MazePiece *mazePiece = [[MazePiece alloc] initWithFrame:frame pieceType:self.endPiece start:self.endDirection end:PieceDirectionEast];
    return mazePiece;
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
        return MazePieceCorner;
    if([piece isEqualToString:@"2"])
        return MazePieceStraight;
    if([piece isEqualToString:@"X"])
        return MazePieceBlock;
    else
        return MazePieceEmpty;
}


@end
