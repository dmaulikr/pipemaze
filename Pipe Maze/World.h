//
//  World.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/12/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface World : NSObject

-(instancetype)initWithColor:(UIColor *)color;

@property (nonatomic, strong) UIColor *mainColor;
@end
