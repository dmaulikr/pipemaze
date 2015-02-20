//
//  MazeViewController.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/12/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "MazeViewController.h"
#import "PMConstants.h"
#import "AppDelegate.h"

@interface MazeViewController (){
    UILabel *timeLabel;
    NSDate *time;
    NSInteger elapsed;
    BOOL updateTime;
    BOOL toolbarVisible;
    CGSize pieceFrame;
    MazePiece *temp;
    MazeView *mazeView;
    MazeManager *manager;
    PiecesView *pieceView;
    CompletedView *completed;
    UIView *backgroundCompletedView;
    PauseView *pauseView;
    UIView *backgroundPauseView;
}

@end

@implementation MazeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.view.bounds.size.height == 480) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    else {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    
    self.actionBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStylePlain target:self action:@selector(showActionItems:)];
    self.pauseBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"pause"] style:UIBarButtonItemStylePlain target:self action:@selector(pauseGame)];
    
    
    self.navigationItem.leftBarButtonItem = self.pauseBarButtonItem;
    
    
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - self.toolbar.bounds.size.height,self.view.bounds.size.width, 44)];
    UIBarButtonItem *leftFixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftFixed.width = self.view.bounds.size.width * 0.1333333;
    UIBarButtonItem *rightFixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightFixed.width = self.view.bounds.size.width * 0.1333333;
    
    self.toolbar.items = @[leftFixed, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(restartMaze:)], [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(checkMaze:)], [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"undo"] style:UIBarButtonItemStylePlain target:self action:@selector(undoMove:)], rightFixed]; //add buttons to toolbar (super ugly, pls change)
    self.toolbar.tintColor = self.navigationController.navigationBar.barTintColor;
    
    CGFloat height = self.navigationController.navigationBar.frame.size.height;
    CGFloat width = self.view.bounds.size.width;
    
        self.toolbar.frame = CGRectMake(0, self.view.bounds.size.height, width, self.toolbar.bounds.size.height);
        toolbarVisible = NO;
    
    if(self.view.bounds.size.height == 1024) //ipad
    {
        width = 700; //change width for ipad
    }
    mazeView = [[MazeView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - width/2, height + [UIApplication sharedApplication].statusBarFrame.size.height, width, width)];
    mazeView.delegate = self;
    
    //title view for navigation bar
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    titleView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
    titleLabel.text = self.level.levelName;
    titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:21.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [titleView addSubview:titleLabel];
    
    //label to update the time on the navigation bar
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 200, 20)];
    timeLabel.text = @"00:00";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:15.0];
    timeLabel.textColor = [UIColor whiteColor];
    [titleView addSubview:timeLabel];
    elapsed = -2;
    updateTime = YES;
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes]; //start running elapsed time
    self.navigationItem.titleView = titleView;
    
    
    CGFloat pieceViewHeight = self.view.frame.size.height - mazeView.frame.origin.y - mazeView.frame.size.height - self.toolbar.frame.size.height;
    if(self.view.frame.size.height == 480) {
        pieceViewHeight = self.view.frame.size.height - mazeView.frame.origin.y - mazeView.frame.size.height -44;
    }
    
    pieceFrame = [mazeView getPieceSize];
    pieceView = [[PiecesView alloc] initWithFrame:CGRectMake(0 ,mazeView.frame.origin.y + mazeView.frame.size.height, self.view.frame.size.width, pieceViewHeight) straight:0 corner:0 pieceSize:pieceFrame];
    pieceView.delegate = self;
    
    [self.view addSubview:pieceView];
    [self.view addSubview:self.toolbar];
    [self.view addSubview:mazeView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showActionItems:self];
    
//    if(self.view.bounds.size.height != 480) {
        toolbarVisible = NO;
//    }
    manager = [[MazeManager alloc] initWithMaze:self.maze size:pieceFrame]; //create maze manager and load maze
    manager.delegate = self;
    [self setupBoard];
    [pieceView updateRemainingStraightPieces:manager.straight corner:manager.corner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateTime {
    if(updateTime)
        elapsed++;
    NSInteger seconds = floor(elapsed/2);
    NSInteger minutes = seconds/60;
    seconds%=60;
    
    timeLabel.text = [NSString stringWithFormat:@"%02li:%02li", (long)minutes, (long)seconds];
}



-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationPortrait;
}

-(BOOL)shouldAutorotate {
    if([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait)
        return NO;
    
    return YES;
}

#pragma mark - IBActions
- (IBAction)showActionItems:(id)sender { //toggle if toolbar is visible
    if(toolbarVisible) {
        [UIView animateKeyframesWithDuration:0.25 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
            self.toolbar.frame = CGRectMake(0, self.view.bounds.size.height, self.toolbar.bounds.size.width, self.toolbar.bounds.size.height);
        }completion:^(BOOL finished){
        }];
    }
    else {
        [UIView animateKeyframesWithDuration:0.25 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
            self.toolbar.frame = CGRectMake(0, self.view.bounds.size.height - self.toolbar.bounds.size.height, self.toolbar.bounds.size.width, self.toolbar.bounds.size.height);
        }completion:^(BOOL finished){
        }];
    }
    
    toolbarVisible = !toolbarVisible;
}

//Restarts the maze, resets time and board, and game logic
- (IBAction)restartMaze:(id)sender {
    [manager restartMaze];  //resets game logic
    [mazeView restartMaze]; //resets board
    [self setupBoard];      //reloads board
    elapsed = -1;           //resets time
}

- (IBAction)checkMaze:(id)sender {
    updateTime = NO;        //stop updating the time
    NSString *results = [manager checkMaze];  //checks logic for the maze
    if(!results) { //maze was successfully solved
        NSInteger stars = [manager computeStars:floor(elapsed/2)]; //compute the times
        CGFloat width = 280;
        CGFloat height = 150;
        if(!completed){ //add completed view and drop shadow
            backgroundCompletedView = [[UIView alloc] initWithFrame:self.view.frame];
            backgroundCompletedView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
            completed = [[CompletedView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - width)/2, self.view.bounds.size.height/2 - height/2 - 30, width, height)];
            completed.delegate = self;
        }
        completed.saying = @"you did it!";
        completed.stars = stars;
        [self.view addSubview:backgroundCompletedView];
        self.navigationItem.leftBarButtonItem.enabled = NO;
        [completed showView:self.view completionHandler:^{
            
        }];
    }
    else  {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:results message:nil delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles: nil];
        alert.delegate = self;
        [alert show];
    }
}

-(void)pauseGame {
    updateTime = NO;
    self.navigationItem.leftBarButtonItem.enabled = NO;
    if(!pauseView) {
        CGFloat width = 280;
        CGFloat height = 200;
        backgroundPauseView = [[UIView alloc] initWithFrame:self.view.frame];
        backgroundPauseView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
        pauseView = [[PauseView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - width)/2, self.view.bounds.size.height/2 - height/2 - 30, width, height)];
        pauseView.delegate = self;
        [backgroundPauseView addSubview:pauseView];
    }
    pauseView.currentTime = elapsed/2;
    pauseView.manager = manager;
    [self.view addSubview:backgroundPauseView];
}

- (IBAction)undoMove:(id)sender {
    MazeMove *move = [manager undo]; //logic to undo move
    if(move.didRemove){
        [pieceView updateRemainingStraightPieces:manager.straight corner:manager.corner];
    }
    [mazeView undoMove:move];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    updateTime = YES;
}


#pragma mark - moving pieces methods
-(void)piecesViewDidSelectMazePiece:(MazePiece *)piece {
    temp = piece;
}

-(MazePiece *)touchReceivedOnMaze {
    return temp;
}

-(void)mazePiecePlaced:(MazePiece *)piece atIndex:(NSInteger)index{
    [manager updatePiece:piece atIndex:index];
}

-(void)mazePieceRotated:(MazePiece *)piece atIndex:(NSInteger)index {
    [manager updatePiece:piece atIndex:index];
}

-(BOOL)canPlaceMazePiece:(MazePiece *)piece {
    return [manager canPlacePiece:piece];
}

-(void)mazePieceWasDeleted:(MazePiece *)piece atIndex:(NSInteger)index {
    MazePiece *newPiece = [[MazePiece alloc] initWithFrame:piece.frame pieceType:MazePieceEmpty start:PieceDirectionNone end:PieceDirectionNone index:-1];
    [manager updatePiece:newPiece atIndex:index];
    [pieceView updateRemainingStraightPieces:manager.straight corner:manager.corner];
}

-(void)deselectMazePieces {
    [pieceView deselectPieces];
    temp = nil;
}

#pragma mark - Custom View Delegate methods

-(void)pauseviewDidDismiss {
    [UIView animateKeyframesWithDuration:0.25 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        backgroundPauseView.alpha = 0;
    }completion:^(BOOL finished){
        backgroundPauseView.alpha = 1;
        [backgroundPauseView removeFromSuperview];
        updateTime = YES;
        self.navigationItem.leftBarButtonItem.enabled = YES;
    }];
}

-(void)pauseViewDidQuit {
    [UIView animateKeyframesWithDuration:0.25 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        backgroundPauseView.alpha = 0;
    }completion:^(BOOL finished){
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

-(void)viewDismissed {
    
    if(!([self.level.completed boolValue] && [self.level.seconds integerValue] < elapsed/2)){
        self.level.completed = [NSNumber numberWithBool:YES];
        self.level.seconds = [NSNumber numberWithInteger:elapsed/2];
        self.level.stars = [NSNumber numberWithInteger:[manager computeStars:floor(elapsed/2)]];
        WorldDAO * worldDA0 = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).worldDAO;
        [worldDA0 updateLevel:self.level forWorld:nil];
    }
    
    [UIView animateKeyframesWithDuration:0.25 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        completed.alpha = 0;
    }completion:^(BOOL finished){
        [completed removeFromSuperview];
        [backgroundCompletedView removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}



-(void)updateStraightPieceCount:(NSInteger)straight corner:(NSInteger)corner {
    [pieceView updateRemainingStraightPieces:straight corner:corner];
}

-(void)setupBoard {
    for(int i = 0; i < self.maze.originalBoard.count; i++) {
        MazePiece *piece = [manager getPieceForIndex:i];
        if(piece.piece != MazePieceEmpty)
            [mazeView placePiece:piece atIndex:i];
    }
}

@end
