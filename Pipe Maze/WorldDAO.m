//
//  World.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/12/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "WorldDAO.h"
#import "LevelParser.h"
#import "MazeManager.h"

@interface WorldDAO ()
@property (nonatomic, strong) NSArray *worlds;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@end

@implementation WorldDAO

-(NSManagedObjectContext *)managedObjectContext{
    return [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
}

-(instancetype)init {
    self = [super init];
    if(self) {
        [self loadObjects];
    }
    return self;
}

-(void)loadObjects {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"World"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES]];
    NSError *error;
    self.worlds = [self.managedObjectContext executeFetchRequest:fetchRequest error: &error];
    
    if(error) {
        NSLog(@"%@, %@", error.description, error.debugDescription);
        return;
    }
    
    if(self.worlds.count == 4) {
        [self createv11Worlds];
        [self loadObjects];
    }
    
    if(self.worlds.count == 0) {
        [self createWorlds];
        [self loadObjects];
    }
}

-(void)createWorlds {
    NSLog(@"Creating worlds...");
    World *firstWorld = [NSEntityDescription insertNewObjectForEntityForName:@"World" inManagedObjectContext:self.managedObjectContext];
    firstWorld.number = [NSNumber numberWithInt:1];
    firstWorld.unlocked = [NSNumber numberWithBool:YES];
    firstWorld.red = [NSNumber numberWithFloat: 1.0];
    firstWorld.green = [NSNumber numberWithFloat: 0.522];
    firstWorld.blue = [NSNumber numberWithFloat: 0.106];
    for(int i = 1; i < 13; i++) {
        [self createLevelsForWorld:firstWorld index:i];
    }
    firstWorld.restrictions = @"none";
    NSError *error;
    
    World *secondWorld = [NSEntityDescription insertNewObjectForEntityForName:@"World" inManagedObjectContext:self.managedObjectContext];
    secondWorld.number = [NSNumber numberWithInt:2];
    secondWorld.unlocked = [NSNumber numberWithBool:YES];
    secondWorld.red = [NSNumber numberWithFloat: 0.18];
    secondWorld.green = [NSNumber numberWithFloat: 0.80];
    secondWorld.blue = [NSNumber numberWithFloat: 0.251];
    for(int i = 1; i < 13; i++) {
        [self createLevelsForWorld:secondWorld index:12 + i];
    }
    secondWorld.restrictions = @"finish first world";

    World *thirdWorld = [NSEntityDescription insertNewObjectForEntityForName:@"World" inManagedObjectContext: self.managedObjectContext];
    thirdWorld.number = [NSNumber numberWithInt:3];
    thirdWorld.unlocked = [NSNumber numberWithBool:YES];
    thirdWorld.red = [NSNumber numberWithFloat: 1.0];
    thirdWorld.green = [NSNumber numberWithFloat: 0.7098];
    thirdWorld.blue = [NSNumber numberWithFloat: 0.7568];
    for(int i = 1; i < 13; i++) {
        [self createLevelsForWorld:thirdWorld index:24 + i];
    }
    thirdWorld.restrictions = @"finish second world";
    
    World *fourthWorld = [NSEntityDescription insertNewObjectForEntityForName:@"World" inManagedObjectContext:self.managedObjectContext];
    fourthWorld.number = [NSNumber numberWithInt:4];
    fourthWorld.unlocked = [NSNumber numberWithBool:YES];
    fourthWorld.red = [NSNumber numberWithFloat: 0.224];
    fourthWorld.green = [NSNumber numberWithFloat: 0.80];
    fourthWorld.blue = [NSNumber numberWithFloat: 0.80];
    for(int i = 1; i < 13; i++) {
        [self createLevelsForWorld:fourthWorld index:36 + i];
    }
    fourthWorld.restrictions = @"finish third world";
    
    
    [self createv11Worlds];
    
    [self.managedObjectContext save:&error];
    
    if(error) {
        NSLog(@"%@, %@", error.description, error.debugDescription);
    }
    
}

-(void)createv11Worlds {
    NSLog(@"Creating v1.1 Worlds...");
    World *firstWorld = [NSEntityDescription insertNewObjectForEntityForName:@"World" inManagedObjectContext:self.managedObjectContext];
    firstWorld.number = [NSNumber numberWithInt:5];
    firstWorld.unlocked = [NSNumber numberWithBool:YES];
    firstWorld.red = [NSNumber numberWithFloat: 1.0];
    firstWorld.green = [NSNumber numberWithFloat: 0.522];
    firstWorld.blue = [NSNumber numberWithFloat: 0.106];
    for(int i = 49; i < 61; i++) {
        [self createLevelsForWorld:firstWorld index:i];
    }
    firstWorld.restrictions = @"none";
    NSError *error;
    
    World *secondWorld = [NSEntityDescription insertNewObjectForEntityForName:@"World" inManagedObjectContext:self.managedObjectContext];
    secondWorld.number = [NSNumber numberWithInt:6];
    secondWorld.unlocked = [NSNumber numberWithBool:YES];
    secondWorld.red = [NSNumber numberWithFloat: 0.18];
    secondWorld.green = [NSNumber numberWithFloat: 0.80];
    secondWorld.blue = [NSNumber numberWithFloat: 0.251];
    for(int i = 61; i < 73; i++) {
        [self createLevelsForWorld:secondWorld index:i];
    }
    secondWorld.restrictions = @"finish first world";
    
    World *thirdWorld = [NSEntityDescription insertNewObjectForEntityForName:@"World" inManagedObjectContext: self.managedObjectContext];
    thirdWorld.number = [NSNumber numberWithInt:7];
    thirdWorld.unlocked = [NSNumber numberWithBool:YES];
    thirdWorld.red = [NSNumber numberWithFloat: 1.0];
    thirdWorld.green = [NSNumber numberWithFloat: 0.7098];
    thirdWorld.blue = [NSNumber numberWithFloat: 0.7568];
    for(int i = 73; i < 85; i++) {
        [self createLevelsForWorld:thirdWorld index:i];
    }
    thirdWorld.restrictions = @"finish second world";
    
    World *fourthWorld = [NSEntityDescription insertNewObjectForEntityForName:@"World" inManagedObjectContext:self.managedObjectContext];
    fourthWorld.number = [NSNumber numberWithInt:7];
    fourthWorld.unlocked = [NSNumber numberWithBool:YES];
    fourthWorld.red = [NSNumber numberWithFloat: 0.224];
    fourthWorld.green = [NSNumber numberWithFloat: 0.80];
    fourthWorld.blue = [NSNumber numberWithFloat: 0.80];
    for(int i = 85; i < 97; i++) {
        [self createLevelsForWorld:fourthWorld index:i];
    }
    fourthWorld.restrictions = @"finish third world";
    
    [self.managedObjectContext save:&error];
    
    if(error) {
        NSLog(@"%@, %@", error.description, error.debugDescription);
    }

}

-(void)createLevelsForWorld:(World *)world index:(NSInteger)index{
    //read in file
    //set stuff
    //save
    Level *l = [NSEntityDescription insertNewObjectForEntityForName:@"Level" inManagedObjectContext:self.managedObjectContext];
    l.world = world; //set ownership to the world
    l.completed = [NSNumber numberWithBool:NO]; //not completed
    l.available = [NSNumber numberWithBool:NO]; //not available
    l.stars = [NSNumber numberWithInt:0];
    l.fileName = [NSString stringWithFormat:@"level%li", (long)index];
    l.seconds = [NSNumber numberWithInt:0];
    l.levelName = [NSString stringWithFormat:@"Level %li", (long)index];
    
    NSError *error;
    [self.managedObjectContext save:&error];
    
    if(error) {
        NSLog(@"%@, %@", error.description, error.debugDescription);
    }
}

-(World *)getWorldAtIndex:(NSInteger)index {
    if(index >= self.worlds.count || index < 0) {
        NSLog(@"Error, index out of bounds, cannot fetch world at index %li", (long)index);
        return nil;
    }
    return self.worlds[index];
}

-(NSInteger)getNumberOfWorlds {
    return self.worlds.count;
}

-(Level *)getLevelForWorld:(World *)world atIndex:(NSInteger)index {
    for(Level *level in world.levels) {
        if([level.fileName isEqualToString:[NSString stringWithFormat:@"level%li", (long)index]]) {
            return level;
        }
    }
    return nil;
}

-(void)updateLevel:(Level *)level forWorld:(World *)world{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Level" inManagedObjectContext:self.managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fileName == %@", level.fileName];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if(results.count > 0) {
        Level *newLevel = [results firstObject];
        newLevel = level;
        [self.managedObjectContext save:nil];
    }
}

-(void)resetAllLevels {
    for(World *world in self.worlds) {
        for(Level *level in world.levels) {
            level.available = [NSNumber numberWithBool:NO];
            level.completed = [NSNumber numberWithBool:NO];
            level.seconds = [NSNumber numberWithInteger:0];
            level.stars = [NSNumber numberWithInteger:0];
        }
    }
}

-(void)normalizeStars {
    for(World *world in self.worlds) {
        for(Level *level in world.levels) {
            if([level.completed boolValue]){
                LevelParser *parser = [[LevelParser alloc] initWithFilename:level.fileName];
                Maze *maze = [parser loadMaze];
                NSInteger stars = [MazeManager computeStars:[level.seconds integerValue] forMaze:maze];
                level.stars = [NSNumber numberWithInteger:stars];
            }
        }
    }
    
    [self.managedObjectContext save:nil];
}




@end
