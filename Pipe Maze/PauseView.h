//
//  PauseView.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/30/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "MazeManager.h"
#import "PMConstants.h"

@protocol PauseViewDelegate <NSObject>

@optional
-(void)pauseViewDidQuit;
-(void)pauseviewDidDismiss;

@end

@interface PauseView : UIView
@property id<PauseViewDelegate> delegate;

@property (nonatomic, strong) NSArray *starTimes;
@property (nonatomic) NSInteger currentTime;
@property (nonatomic, strong) MazeManager *manager;
@end
