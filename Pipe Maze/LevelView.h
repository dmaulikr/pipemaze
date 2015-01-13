//
//  LevelView.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/12/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelView : UIView

-(instancetype)init;
-(instancetype)initWithFrame:(CGRect)frame;
-(id)initWithCoder:(NSCoder *)aDecoder;
-(instancetype)initWithFrame:(CGRect)frame level:(NSUInteger)level completed:(BOOL)completed stars:(NSInteger)stars color:(UIColor *)color;



@end
