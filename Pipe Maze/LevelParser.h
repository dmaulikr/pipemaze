//
//  LevelParser.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/15/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Maze.h"

@interface LevelParser : NSObject

-(instancetype)init;
-(instancetype)initWithFilename:(NSString *)fileName;

-(Maze *)loadMaze;



@end
