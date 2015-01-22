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

@interface MazeViewController : UIViewController <PiecesViewDelegate, MazeViewDelegate, MazeManagerDelegate, CompletedViewDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionBarButtonItem;
@property (strong, nonatomic) UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *restartBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *playBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *undoBarButtonItem;

@property (nonatomic, strong) World *world;
@property (nonatomic, strong) Maze *maze;
@property (nonatomic, strong) Level *level;

- (IBAction)showActionItems:(id)sender;
- (IBAction)restartMaze:(id)sender;
- (IBAction)checkMaze:(id)sender;
- (IBAction)undoMove:(id)sender;

@end
