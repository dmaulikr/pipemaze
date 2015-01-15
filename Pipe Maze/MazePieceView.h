//
//  MazePieceView.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/15/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMConstants.h"
#import "MazePiece.h"

@protocol MazePieceViewDelegate <NSObject>

-(void)mazePieceDidSelectPiece:(MazePiece *)piece;

@end

@interface MazePieceView : UIView <MazePieceDelegate>

-(instancetype)init;
-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame piece:(MazePieces)mazePiece size:(CGSize)size numOfPieces:(NSInteger)num;

@property id<MazePieceViewDelegate> delegate;
@end
