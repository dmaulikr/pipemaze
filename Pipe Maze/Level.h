//
//  Level.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/13/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class World;


@interface Level : NSManagedObject

@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) NSNumber * available;
@property (nonatomic, retain) NSNumber * stars;
@property (nonatomic, retain) NSNumber * seconds;
@property (nonatomic, retain) NSNumber * oneStarTime;
@property (nonatomic, retain) NSNumber * twoStarTime;
@property (nonatomic, retain) NSNumber * threeStarTime;
@property (nonatomic, retain) NSNumber * fourStarTime;
@property (nonatomic, retain) NSNumber * fiveStarTime;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSString * levelName;
@property (nonatomic, retain) World *world;
@end

@interface Level (CoreDataGeneratedAccessors)

- (void)addWorldObject:(NSManagedObject *)value;
- (void)removeWorldObject:(NSManagedObject *)value;
- (void)addWorld:(NSSet *)values;
- (void)removeWorld:(NSSet *)values;

@end
