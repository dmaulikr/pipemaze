//
//  MazeViewController.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/12/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "MazeViewController.h"
#import "MazeView.h"

@interface MazeViewController (){
    UILabel *timeLabel;
    NSDate *time;
    NSInteger elapsed;
    BOOL updateTime;
    BOOL toolbarVisible;
}

@end

@implementation MazeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - self.toolbar.bounds.size.height,self.view.bounds.size.width, 44)];
    UIBarButtonItem *leftFixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftFixed.width = 50.0f;
    UIBarButtonItem *rightFixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightFixed.width = 50.0f;
    
    self.toolbar.items = @[leftFixed, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(restartMaze:)], [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(checkMaze:)], [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"undo"] style:UIBarButtonItemStylePlain target:self action:@selector(undoMove:)], rightFixed];
    [self.view addSubview:self.toolbar];
    
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:[self.world.red floatValue] green:[self.world.green floatValue] blue:[self.world.blue floatValue] alpha:1];
    self.toolbar.tintColor = [UIColor colorWithRed:[self.world.red floatValue] green:[self.world.green floatValue] blue:[self.world.blue floatValue] alpha:1];
    
    CGFloat height = self.navigationController.navigationBar.frame.size.height;
    CGFloat width = self.view.bounds.size.width;
    if(self.view.bounds.size.height != 480) {
        self.navigationItem.rightBarButtonItem = nil;
        self.toolbar.frame = CGRectMake(0, self.view.bounds.size.height, width, self.toolbar.bounds.size.height);
        toolbarVisible = NO;
    }
    else {
        self.toolbar.frame = CGRectMake(0, self.view.bounds.size.height - self.toolbar.bounds.size.height, width, self.toolbar.bounds.size.height);
        toolbarVisible = YES;
    }
    
    
    MazeView *maze = [[MazeView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - width)/2, height +20, width, width)];
    [self.view addSubview:maze];

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    titleView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 200, 20)];
    titleLabel.text = @"level 1";
    titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:21.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:titleLabel];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 200, 20)];
    timeLabel.text = @"00:00";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:15.0];
    [titleView addSubview:timeLabel];
    elapsed = 0;
    updateTime = YES;
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.navigationItem.titleView = titleView;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showActionItems:self];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showActionItems:(id)sender {
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

- (IBAction)restartMaze:(id)sender {
    NSLog(@"restart maze");
}

- (IBAction)checkMaze:(id)sender {
    NSLog(@"check maze");
    updateTime = !updateTime;
}

- (IBAction)undoMove:(id)sender {
    NSLog(@"undo move");
}
@end
