//
//  StarView.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/12/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "StarView.h"

@interface StarView (){
    NSMutableArray *starArray;
}
@property (nonatomic) NSInteger stars;

@end

@implementation StarView

-(instancetype)init {
    self = [super init];
    if(self) {
        starArray = [[NSMutableArray alloc] init];
        self.stars = 0;
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        starArray = [[NSMutableArray alloc] init];
        self.stars = 0;
        [self createView];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame stars:(NSInteger)stars {
    self = [super initWithFrame:frame];
    if(self) {
        starArray = [[NSMutableArray alloc] init];
        self.stars = stars;
        [self createView];
    }
    
    return self;
}

-(void)createView {
    CGFloat starSize = 0;
    if(self.bounds.size.width/5 > self.bounds.size.height) {
        starSize = self.bounds.size.height;
    }
    else {
        starSize = self.bounds.size.width/5;
    }
    
    for(int i = 0; i < 5; i++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(starSize * i, 0, starSize, starSize)];
        if(self.stars > i) {
            image.image = [UIImage imageNamed:@"starhighlighted"];
        }
        else {
            image.image = [UIImage imageNamed:@"star"];
        }
        [self addSubview:image];
        [starArray addObject:image];
    }
}

-(void)updateStarFrame:(CGRect)frame {
    CGFloat starSize = 0;
    if(frame.size.width/5 > frame.size.height) {
        starSize = frame.size.height;
    }
    else {
        starSize = frame.size.width/5;
    }
    
    for(int i = 0; i < 5; i++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(starSize * i, 0, starSize, starSize)];
        if(self.stars > i) {
            image.image = [UIImage imageNamed:@"starhighlighted"];
        }
        else {
            image.image = [UIImage imageNamed:@"star"];
        }
        [self addSubview:image];
        [starArray addObject:image];
    }

}

-(void)updateStars:(NSInteger)stars {
    self.stars = stars;
    for(int i = 0; i < 5; i++) {
        UIImageView *image = [starArray objectAtIndex:i];
        
        if(self.stars > i) {
            image.image = [UIImage imageNamed:@"starhighlighted"];
        }
        else {
            image.image = [UIImage imageNamed:@"star"];
        }
    }
}

-(void)setNewFrame:(CGRect)frame {
    self.frame = frame;
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [starArray removeAllObjects];
    [self createView];
}

//-(void)setFrame:(CGRect)frame {
//    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
//    [starArray removeAllObjects];
//    [self updateStarFrame:frame];
//}

@end
