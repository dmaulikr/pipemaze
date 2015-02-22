//
//  ProfileViewController.h
//  Pipe Maze
//
//  Created by Jack Arendt on 2/20/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMConstants.h"
#import "StatisticsCollectionViewCell.h"
#import "AchievementsCollectionViewCell.h"

@interface ProfileViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, StatisticsCollectionViewCellDelegate, AchievementCollectionViewCellDelegate>

@end
