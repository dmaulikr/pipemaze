//
//  LevelParser.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/15/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "LevelParser.h"

@interface LevelParser ()
@property (nonatomic, strong) NSString *contentString;
@end

@implementation LevelParser

-(instancetype)init {
    self = [super init];
    if(self){
        
    }
    
    return self;
}

-(instancetype)initWithFilename:(NSString *)fileName {
    self = [super init];
    if(self){
        self.contentString = [self loadFile:fileName];
    }
    return self;
}

-(NSString *)loadFile:(NSString *)fileName {
    if(fileName == nil) {
        NSLog(@"ERROR, NULL FILENAME, CANNOT LOAD LEVEL");
        return nil;
    }
    
    NSStringEncoding encoding;
    NSString* content;
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    if(path)
    {
        content = [NSString stringWithContentsOfFile:path  usedEncoding:&encoding  error:NULL];
    }
    return content;
}

-(Maze *)loadMaze {
    Maze *maze = [[Maze alloc] init];
    NSArray *contents = [self.contentString componentsSeparatedByString:@"\n"];
    NSMutableArray *orig = [[NSMutableArray alloc] init];
    maze.levelName = (NSString *)contents[0];
    for (int i = 1; i < 6; i++) {
        NSArray *row = [(NSString *)contents[i] componentsSeparatedByString:@" "];
        [orig addObjectsFromArray:row];
    }
    
    NSArray *start = [(NSString *)contents[6] componentsSeparatedByString:@" "];
    maze.startPiece = [self getPiece:(NSString *)start[0]];
    maze.startDirection = [self getDirection:(NSString *)start[1]];
    
    NSArray *end = [(NSString *) contents[7] componentsSeparatedByString:@" "];
    maze.endPiece = [self getPiece:(NSString *)end[0]];
    maze.endDirection = [self getDirection:(NSString *)end[1]];
    
    maze.curvedPieces = [(NSString *)contents[8] integerValue];
    maze.straightPieces = [(NSString *)contents[9] integerValue];
    
    maze.originalBoard = orig;
    maze.playingBoard = orig;
    
    //Needs more work
    return maze;
}

-(PieceDirection)getDirection:(NSString *)direction {
    if([direction isEqualToString:@"0"])
        return PieceDirectionNorth;
    if([direction isEqualToString:@"1"])
        return PieceDirectionEast;
    if([direction isEqualToString:@"2"])
        return PieceDirectionSouth;
    if([direction isEqualToString:@"3"])
        return PieceDirectionWest;
    else
        return PieceDirectionNone;
}

-(MazePieces)getPiece:(NSString *)piece {
    if([piece isEqualToString:@"1"])
        return MazePieceCurved;
    if([piece isEqualToString:@"2"])
        return MazePieceStraight;
    if([piece isEqualToString:@"0"])
        return MazePieceBlock;
    else
        return MazePieceEmpty;
}

@end
