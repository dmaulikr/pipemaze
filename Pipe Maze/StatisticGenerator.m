//
//  StatisticGenerator.m
//  Pipe Maze
//
//  Created by Jack Arendt on 2/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "StatisticGenerator.h"

@interface StatisticGenerator () {
    NSMutableArray *_statistics;
    WorldDAO *dao;
}

@end

@implementation StatisticGenerator

-(instancetype)init {
    self = [super init];
    if(self) {
        _statistics = [[NSMutableArray alloc] init];
        dao = [WorldDAO sharedDAOSession];
    }
    return self;
}

-(void)createStatistics {
    [_statistics addObject:[self createCompletedLevelsStatistic]];
    [_statistics addObject:[self createNumberOfStarsStatistic]];
    [_statistics addObject:[self createAverageNumberOfStarsStatistic]];
    [_statistics addObject:[self createNumberOfFiveStarLevelsStatistics]];
}

-(Statistic *)getStatisticAtIndex:(NSInteger)index {
    if(index >= _statistics.count || index < 0) {
        return nil;
    }
    return _statistics[index];
}

-(NSInteger)getNumberOfStatistics {
    return _statistics.count;
}

#pragma mark - Stat creators
-(Statistic *)createCompletedLevelsStatistic {
    Statistic *stat = [[Statistic alloc] init];
    stat.name = @"Levels Completed";
    stat.value = [NSNumber numberWithInteger:[dao getCompletedLevels]];
    stat.benchmark = [NSNumber numberWithInteger:[dao getTotalLevels]];
    stat.type = StatisticTypeMaximumValue;
    
    return stat;
}

-(Statistic *)createNumberOfStarsStatistic {
    Statistic *stat = [[Statistic alloc] init];
    stat.name = @"Total Number of Stars";
    stat.value = [NSNumber numberWithInteger:[dao getNumberOfStars]];
    stat.benchmark = [NSNumber numberWithInteger:[dao getPossibleNumberOfStars]];
    stat.type = StatisticTypeMaximumValue;
    
    return stat;
}

-(Statistic *)createAverageNumberOfStarsStatistic {
    Statistic *stat = [[Statistic alloc] init];
    stat.name = @"Average Number of Stars";
    stat.value = [NSNumber numberWithFloat:[dao getAverageNumberOfStars]];
    stat.benchmark = [NSNumber numberWithInteger:[dao getPossibleAverageOfStars]];
    stat.type = StatisticTypeMaximumValue;
    
    return stat;
}

-(Statistic *)createNumberOfFiveStarLevelsStatistics {
    Statistic *stat = [[Statistic alloc] init];
    stat.name = @"Number of Levels with Five Stars";
    stat.value = [NSNumber numberWithInteger:[dao getNumberOfFiveStarLevels]];
    stat.benchmark = [NSNumber numberWithInteger:[dao getTotalLevels]];
    stat.type = StatisticTypeMaximumValue;
    
    return stat;
}

@end
