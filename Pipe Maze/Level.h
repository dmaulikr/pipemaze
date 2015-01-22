//
//  Level.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class World;

@interface Level : NSManagedObject

@property (nonatomic, retain) NSNumber * available;
@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSString * levelName;
@property (nonatomic, retain) NSNumber * seconds;
@property (nonatomic, retain) NSNumber * stars;
@property (nonatomic, retain) World *world;

@end
