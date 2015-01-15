//
//  World.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/13/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Level;

@interface World : NSManagedObject

@property (nonatomic, retain) NSNumber * unlocked;
@property (nonatomic, retain) NSNumber * red;
@property (nonatomic, retain) NSNumber * green;
@property (nonatomic, retain) NSNumber * blue;
@property (nonatomic, retain) NSString * restrictions;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSSet *levels;
@end

@interface World (CoreDataGeneratedAccessors)

- (void)addLevelsObject:(Level *)value;
- (void)removeLevelsObject:(Level *)value;
- (void)addLevels:(NSSet *)values;
- (void)removeLevels:(NSSet *)values;

@end
