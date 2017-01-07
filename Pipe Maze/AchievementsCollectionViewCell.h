//
//  AchievementsCollectionViewCell.h
//  Pipe Maze
//
//  Created by Jack Arendt on 2/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AchievementCollectionViewCellDelegate <NSObject>

-(void)achievementCellDidSwipe;
//-(NSInteger)numberOfAchievements;
//-(void)achievementForIndex:(NSInteger)index; //fix TODO: shouldnt be void

@end

@interface AchievementsCollectionViewCell : UICollectionViewCell<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property id<AchievementCollectionViewCellDelegate> delegate;

@end
