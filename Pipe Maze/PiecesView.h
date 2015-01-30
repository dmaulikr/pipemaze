//
//  PiecesView.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/15/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMConstants.h"
#import "MazePieceView.h"
#import "MazePiece.h"

@protocol PiecesViewDelegate <NSObject>

-(void)piecesViewDidSelectMazePiece:(MazePiece *)piece;

@end

@interface PiecesView : UIView <MazePieceViewDelegate>

-(instancetype)init;
-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame straight:(NSInteger)straightPieces corner:(NSInteger)cornerPieces pieceSize:(CGSize)size;

-(void)updateRemainingStraightPieces:(NSInteger)straight corner:(NSInteger)corner;
-(void)deselectPieces;

@property id<PiecesViewDelegate>delegate;

@end
