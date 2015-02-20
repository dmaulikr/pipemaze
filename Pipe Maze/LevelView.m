//
//  LevelView.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/12/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "LevelView.h"
#import "StarView.h"
#import "PMConstants.h"

@interface LevelView ()
@property (nonatomic, strong) UIColor *color;
@property (nonatomic) NSInteger level;
@property (nonatomic) BOOL completed;
@property (nonatomic) NSInteger stars;
@end

@implementation LevelView

-(instancetype)init {
    self = [super init];
    if(self){
        self.color = nil;
        self.level = 0;
        self.stars = 0;
        self.completed = NO;
        [self createView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        self.color = nil;
        self.level = 0;
        self.stars = 0;
        self.completed = NO;
        [self createView];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
        self.color = nil;
        self.level = 0;
        self.stars = 0;
        self.completed = NO;
        [self createView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame level:(NSUInteger)level completed:(BOOL)completed stars:(NSInteger)stars color:(UIColor *)color {
    self = [super initWithFrame:frame];
    if(self){
        self.color = color;
        self.level = level;
        self.stars = stars;
        self.completed = completed;
        [self createView];
    }
    return self;
}

-(void)createView {
    UIView *banner = [[UIView alloc] initWithFrame:CGRectMake(0, 0.55*self.bounds.size.height, self.bounds.size.width, 0.4*self.bounds.size.height)];
    banner.backgroundColor = [UIColor whiteColor];
    banner.layer.borderColor = [UIColor lightGrayColor].CGColor;
    banner.layer.borderWidth = 1.0f;
    [self addSubview:banner];
    
    
    CGFloat circleOffset = self.bounds.size.width/2 - 0.375* self.bounds.size.width;
    CGFloat circleWidth = 0.75 * (float)self.bounds.size.width;
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(circleOffset, 0, circleWidth, circleWidth)];
    circle.backgroundColor = self.color;
    circle.layer.cornerRadius = circleWidth/2;
//    circle.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    circle.layer.borderWidth = 1.0f;
    [self addSubview:circle];
    
    UILabel *level = [[UILabel alloc] initWithFrame:circle.frame];
    level.text = [NSString stringWithFormat:@"%li", (long)self.level];
    level.textAlignment = NSTextAlignmentCenter;
    level.textColor = [UIColor darkGrayColor];
    level.font = [UIFont fontWithName:kFontName size:self.bounds.size.width/3.214];
    [self addSubview:level];
        
    StarView *stars = [[StarView alloc] initWithFrame:CGRectMake(0, banner.bounds.size.height * 0.5, banner.bounds.size.width, banner.bounds.size.height * 0.5) stars:self.stars];
    
    [banner addSubview:stars];
    
    self.backgroundColor = [UIColor clearColor];
}

@end
