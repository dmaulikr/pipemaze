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
}

@end

@implementation MazeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = self.world.mainColor;
    self.toolbar.tintColor = self.world.mainColor;
    
    CGFloat height = self.navigationController.navigationBar.frame.size.height;
    CGFloat width = self.view.bounds.size.width;
//    if(self.view.bounds.size.height == 480) {
//        width = 280;
//    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateTime {
//    NSDate *date = [NSDate date];
//    NSTimeInterval difference = [date timeIntervalSinceDate:time];
//    NSDate *d = [NSDate dateWithTimeIntervalSinceNow:difference];
//    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    [format setDateFormat:@"mm:ss"];
//    timeLabel.text = [format stringFromDate:d];
    
    if(updateTime)
        elapsed++;
    NSInteger seconds = elapsed/2;
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
