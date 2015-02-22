//
//  Statistic.m
//  Pipe Maze
//
//  Created by Jack Arendt on 2/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "Statistic.h"

@implementation Statistic

-(instancetype)init {
    self = [super init];
    if(self) {
        
    }
    return self;
}

-(float)getPercentage {
    if(self.benchmark == nil || self.value == nil) {
        return 0.0;
    }
    
    float statValue = [self.value floatValue];
    float benchmarkValue = [self.benchmark floatValue];
    if(self.type == StatisticTypeMaximumValue) {
        return statValue/benchmarkValue;
    }
    
    if(self.type == StatisticTypeMinimumValue) {
        return benchmarkValue/statValue;
    }
    
    return 0.0;
}

@end
