//
//  World.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/12/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "WorldDAO.h"

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
    
    NSLog(@"%@", ((World *)[self.worlds firstObject]).restrictions);
    
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
    for(int i = 0; i < 12; i++) {
        [self createLevelsForWorld:firstWorld];
    }
    firstWorld.restrictions = @"none";
    
    World *secondWorld = [NSEntityDescription insertNewObjectForEntityForName:@"World" inManagedObjectContext:self.managedObjectContext];
    secondWorld.number = [NSNumber numberWithInt:2];
    secondWorld.unlocked = [NSNumber numberWithBool:YES];
    secondWorld.red = [NSNumber numberWithFloat: 0.18];
    secondWorld.green = [NSNumber numberWithFloat: 0.80];
    secondWorld.blue = [NSNumber numberWithFloat: 0.251];
    for(int i = 0; i < 12; i++) {
        [self createLevelsForWorld:secondWorld];
    }
    secondWorld.restrictions = @"finish first world";
    
    World *thirdWorld = [NSEntityDescription insertNewObjectForEntityForName:@"World" inManagedObjectContext: self.managedObjectContext];
    thirdWorld.number = [NSNumber numberWithInt:3];
    thirdWorld.unlocked = [NSNumber numberWithBool:YES];
    thirdWorld.red = [NSNumber numberWithFloat: 1.0];
    thirdWorld.green = [NSNumber numberWithFloat: 0.7098];
    thirdWorld.blue = [NSNumber numberWithFloat: 0.7568];
    for(int i = 0; i < 12; i++) {
        [self createLevelsForWorld:thirdWorld];
    }
    thirdWorld.restrictions = @"finish second world";
    
    World *fourthWorld = [NSEntityDescription insertNewObjectForEntityForName:@"World" inManagedObjectContext:self.managedObjectContext];
    fourthWorld.number = [NSNumber numberWithInt:4];
    fourthWorld.unlocked = [NSNumber numberWithBool:YES];
    fourthWorld.red = [NSNumber numberWithFloat: 0.224];
    fourthWorld.green = [NSNumber numberWithFloat: 0.80];
    fourthWorld.blue = [NSNumber numberWithFloat: 0.80];
    for(int i = 0; i < 12; i++) {
        [self createLevelsForWorld:fourthWorld];
    }
    fourthWorld.restrictions = @"finish third world";
    
    World *fifthWorld = [NSEntityDescription insertNewObjectForEntityForName:@"World" inManagedObjectContext:self.managedObjectContext];
    fifthWorld.number = [NSNumber numberWithInt:5];
    fifthWorld.unlocked = [NSNumber numberWithBool:NO];
    fifthWorld.red = [NSNumber numberWithFloat: 1.0];
    fifthWorld.green = [NSNumber numberWithFloat: 0.252];
    fifthWorld.blue = [NSNumber numberWithFloat: 0.212];
    for(int i = 0; i < 12; i++) {
        [self createLevelsForWorld:fifthWorld];
    }
    fifthWorld.restrictions = @"need to be purchased";
    NSError *error;
    [self.managedObjectContext save:&error];
    
    if(error) {
        NSLog(@"%@, %@", error.description, error.debugDescription);
    }
    
}

-(void)createLevelsForWorld:(World *)world {
    //read in file
    //set stuff
    //save
    Level *l = [NSEntityDescription insertNewObjectForEntityForName:@"Level" inManagedObjectContext:self.managedObjectContext];
    l.world = world; //set ownership to the world
    l.completed = [NSNumber numberWithBool:NO];
    l.available = world.unlocked;
    l.stars = [NSNumber numberWithInt:0];
    
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




@end
