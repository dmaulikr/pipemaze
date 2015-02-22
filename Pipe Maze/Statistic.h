//
//  Statistic.h
//  Pipe Maze
//
//  Created by Jack Arendt on 2/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMConstants.h"

@interface Statistic : NSObject

-(instancetype)init;
-(float)getPercentage;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *value;
@property (nonatomic, strong) NSNumber *benchmark;
@property (nonatomic) StatisticType type;

@end
