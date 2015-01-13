//
//  World.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/12/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "World.h"

@implementation World

-(instancetype)init {
    self = [super init];
    if(self) {
        self.mainColor = nil;
    }
    return self;
}

-(instancetype)initWithColor:(UIColor *)color {
    self = [super init];
    if(self) {
        self.mainColor = color;
    }
    return self;
}

@end
