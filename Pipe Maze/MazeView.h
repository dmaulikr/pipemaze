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

@end

@interface MazeView : UIView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, MazePieceDelegate>

-(instancetype)init;
-(instancetype)initWithFrame:(CGRect)frame;

-(CGSize)getPieceSize;

@property id<MazeViewDelegate> delegate;


@end
