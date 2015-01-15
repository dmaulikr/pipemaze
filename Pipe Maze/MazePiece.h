//
//  MazePiece.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/15/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMConstants.h"

@protocol MazePieceDelegate <NSObject>

-(BOOL)mazePieceCanMove:(id)sender;
-(BOOL)mazePieceCanRotate:(id)sender;
-(void)mazePieceDidEndTouching:(id)sender;
-(void)mazePieceDidBeginTouching:(id)sender;

@end

@interface MazePiece : UIView

-(instancetype)init;
-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame pieceType:(MazePieces)piece start:(PieceDirection)start end:(PieceDirection)end;

@property (nonatomic) MazePieces piece;
@property (nonatomic) PieceDirection startDirection;
@property (nonatomic) PieceDirection endDirection;
@property id<MazePieceDelegate> delegate;

@end

