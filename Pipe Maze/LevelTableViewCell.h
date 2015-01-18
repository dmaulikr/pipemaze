//
//  LevelTableViewCell.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/17/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"

@interface LevelTableViewCell : UITableViewCell

@property (nonatomic, strong) StarView *starView;
@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UIImageView *lockedImageView;
@property (nonatomic, strong) UILabel *levelLabel;
@end
