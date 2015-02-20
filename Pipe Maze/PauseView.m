//
//  PauseView.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/30/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "PauseView.h"

#define BUTTON_HEIGHT 50

@interface PauseView ()
@property (nonatomic, strong) UILabel *pauseLabel;
@property (nonatomic, strong) UIButton *resumeButton;
@property (nonatomic, strong) UIButton *quitButton;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) StarView *starView;
@end

@implementation PauseView
@synthesize manager = _manager;
@synthesize currentTime = _currentTime;

-(instancetype)init {
    self = [super init];
    if(self) {
        [self createView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self createView];
    }
    return self;
}

-(void)createView {
    
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = self.bounds;
    self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    [self addSubview:effectView];
    self.layer.cornerRadius = 4.0;
    self.clipsToBounds = YES;
    
    self.pauseLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, width, 30)];
    self.pauseLabel.text = @"pause";
    self.pauseLabel.textAlignment = NSTextAlignmentCenter;
    self.pauseLabel.font = [UIFont fontWithName:kFontName size:21.0];
    [self addSubview:self.pauseLabel];
    
    UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(0, height - BUTTON_HEIGHT, width, BUTTON_HEIGHT)];
    sepView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:sepView];
    
    
    self.resumeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, height - BUTTON_HEIGHT, width/2 - 1, BUTTON_HEIGHT)];
    [self.resumeButton setTitle:@"resume" forState:UIControlStateNormal];
    [self.resumeButton setTitleColor:[UIColor colorWithRed:0.18 green:0.356 blue:0.537 alpha:1.0] forState:UIControlStateNormal];
    [self.resumeButton.titleLabel setFont:[UIFont fontWithName:kFontName size:18.0]];
    [self.resumeButton addTarget:self action:@selector(resume) forControlEvents:UIControlEventTouchUpInside];
    [self.resumeButton setBackgroundImage:[PMConstants imageWithColor:[UIColor colorWithWhite:1.0 alpha:0.9]] forState:UIControlStateNormal];
    [self.resumeButton setBackgroundImage:[PMConstants imageWithColor:[UIColor colorWithWhite:0.85 alpha:0.9]] forState:UIControlStateHighlighted];
    [self addSubview:self.resumeButton];
    
    
    self.quitButton = [[UIButton alloc] initWithFrame:CGRectMake(width/2 + 1, height - BUTTON_HEIGHT, width/2, BUTTON_HEIGHT)];
    [self.quitButton setTitle:@"quit" forState:UIControlStateNormal];
    [self.quitButton setTitleColor:[UIColor colorWithRed:1 green:0.252 blue:0.212 alpha:1] forState:UIControlStateNormal];
    [self.quitButton.titleLabel setFont:[UIFont fontWithName:kFontName size:18.0]];
    [self.quitButton addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    [self.quitButton setBackgroundImage:[PMConstants imageWithColor:[UIColor colorWithWhite:1.0 alpha:0.9]] forState:UIControlStateNormal];
    [self.quitButton setBackgroundImage:[PMConstants imageWithColor:[UIColor colorWithWhite:0.85 alpha:0.9]] forState:UIControlStateHighlighted];
    [self addSubview:self.quitButton];
    
    CGFloat xOff = 60;
    CGFloat starheight = 50;
    self.starView = [[StarView alloc] initWithFrame:CGRectMake(xOff, 60, self.bounds.size.width - 2*xOff , starheight) stars:0];
    [self.starView updateStars:3];
    [self addSubview:self.starView];

    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, self.bounds.size.width - 20, 30)];
    self.timeLabel.text = [NSString stringWithFormat:@"%lis - %lis - %lis - %lis - %lis", (long)[self.manager timeForStar:1], (long)[self.manager timeForStar:2], (long)[self.manager timeForStar:3], (long)[self.manager timeForStar:4], (long)[self.manager timeForStar:5]];
    self.timeLabel.font = [UIFont fontWithName:kFontName size:16.0];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.timeLabel];
}


-(void)resume {
    if(self.delegate) {
        [self.delegate pauseviewDidDismiss];
    }
}

-(void)quit {
    if(self.delegate) {
        [self.delegate pauseViewDidQuit];
    }
}

-(void)setManager:(MazeManager *)manager {
    self.timeLabel.text = [NSString stringWithFormat:@"%lis - %lis - %lis - %lis - %lis", (long)[manager timeForStar:1], (long)[manager timeForStar:2], (long)[manager timeForStar:3], (long)[manager timeForStar:4], (long)[manager timeForStar:5]];
    NSInteger stars = [manager computeStars:self.currentTime];
    [self.starView updateStars:stars];
}


-(void)updateTime:(NSInteger)time {
    self.currentTime = time;
    NSInteger stars = [_manager computeStars:self.currentTime];
    [self.starView updateStars:stars];
}
@end
