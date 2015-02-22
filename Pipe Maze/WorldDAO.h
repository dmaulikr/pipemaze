//
//  World.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/12/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "World.h"
#import "Level.h"

@interface WorldDAO : NSObject

+ (id)sharedDAOSession;

-(World *)getWorldAtIndex:(NSInteger)index;
-(NSInteger)getNumberOfWorlds;
-(Level *)getLevelForWorld:(World *)world atIndex:(NSInteger)index;
-(void)updateLevel:(Level *)level forWorld:(World *)world;
-(void)resetAllLevels;

-(void)normalizeStars;
-(BOOL)unlockLevel;

#pragma mark - statistic graph methods
-(NSInteger)getCompletedLevels;
-(NSInteger)getTotalLevels;
-(NSInteger)getNumberOfStars;
-(NSInteger)getPossibleNumberOfStars;
-(NSInteger)getPossibleAverageOfStars;
-(float)getAverageNumberOfStars;
-(NSInteger)getNumberOfFiveStarLevels;

#pragma mark - statistic text methods
-(NSInteger)getAverageTime;

@end
