//
//  StarView.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/12/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView

-(instancetype)init;
-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame stars:(NSInteger)stars;

-(void)updateStars:(NSInteger)stars;

@end
