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

@optional
-(void)mazePieceDidEndTouching:(id)sender;
-(void)mazePieceDidBeginTouching:(id)sender;
-(void)mazePieceDidRotate:(id)sender;

@end

@interface MazePiece : UIView

-(instancetype)init;
-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame pieceType:(MazePieces)piece start:(PieceDirection)start end:(PieceDirection)end;
-(instancetype)initWithFrame:(CGRect)frame pieceType:(MazePieces)piece start:(PieceDirection)start end:(PieceDirection)end index:(NSInteger)index;

-(void)undoRotateCurvedPiece:(CGRect)frame direction:(PieceDirection)direction;
-(void)undoRotateStraightPiece:(CGRect)frame direction:(PieceDirection)direction;

@property (nonatomic) MazePieces piece;
@property (nonatomic) PieceDirection startDirection;
@property (nonatomic) PieceDirection endDirection;
@property (nonatomic, strong) NSNumber * index;
@property id<MazePieceDelegate> delegate;

@end

