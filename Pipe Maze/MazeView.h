//
//  MazeView.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/12/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MazePiece.h"

@protocol MazeViewDelegate <NSObject>

-(MazePiece *)touchReceivedOnMaze;
-(void)mazePiecePlaced:(MazePiece *)piece atIndex:(NSInteger)index;
-(void)mazePieceRotated:(MazePiece *)piece atIndex:(NSInteger)index;
-(BOOL)canPlaceMazePiece:(MazePiece *)piece;

@end

@interface MazeView : UIView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, MazePieceDelegate>

-(instancetype)init;
-(instancetype)initWithFrame:(CGRect)frame;

-(CGSize)getPieceSize;
-(void)placePiece:(MazePiece *)piece atIndex:(NSInteger)index;
-(void)restartMaze;

@property id<MazeViewDelegate> delegate;


@end
