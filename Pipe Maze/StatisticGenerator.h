//
//  StatisticGenerator.h
//  Pipe Maze
//
//  Created by Jack Arendt on 2/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statistic.h"
#import "WorldDAO.h"

@interface StatisticGenerator : NSObject

-(instancetype)init;
-(Statistic *)getStatisticAtIndex:(NSInteger)index;
-(NSInteger)getNumberOfStatistics;
-(void)createStatistics;

@end
