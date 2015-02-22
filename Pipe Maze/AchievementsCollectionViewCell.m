//
//  AchievementsCollectionViewCell.m
//  Pipe Maze
//
//  Created by Jack Arendt on 2/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "AchievementsCollectionViewCell.h"


@interface AchievementsCollectionViewCell () {
    UISwipeGestureRecognizer *swipeGesture;
}

@end

@implementation AchievementsCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe)];
        swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipeGesture];
    }
    return self;
}

-(void)didSwipe {
    if(self.delegate) {
        [self.delegate achievementCellDidSwipe];
    }
}


@end
