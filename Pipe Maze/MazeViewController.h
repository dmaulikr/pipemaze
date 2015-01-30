//
//  MazeViewController.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/12/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorldDAO.h"
#import "World.h"
#import "MazePiece.h"
#import "PiecesView.h"
#import "MazeView.h"
#import "Maze.h"
#import "MazeManager.h"
#import "CompletedView.h"
#import "MazeMove.h"
#import "Level.h"
#import "PauseView.h"

@interface MazeViewController : UIViewController <PiecesViewDelegate, MazeViewDelegate, MazeManagerDelegate, CompletedViewDelegate, UIAlertViewDelegate, PauseViewDelegate>
@property (strong, nonatomic) UIBarButtonItem *actionBarButtonItem;
@property (strong, nonatomic) UIBarButtonItem *pauseBarButtonItem;
@property (strong, nonatomic) UIToolbar *toolbar;

@property (nonatomic, strong) World *world;
@property (nonatomic, strong) Maze *maze;
@property (nonatomic, strong) Level *level;

- (IBAction)showActionItems:(id)sender;
- (IBAction)restartMaze:(id)sender;
- (IBAction)checkMaze:(id)sender;
- (IBAction)undoMove:(id)sender;

@end
