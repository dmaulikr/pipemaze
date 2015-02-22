//
//  StatisticsCollectionViewCell.h
//  Pipe Maze
//
//  Created by Jack Arendt on 2/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMConstants.h"
#import "StatisticTableViewCell.h"
#import "Statistic.h"

@protocol StatisticsCollectionViewCellDelegate <NSObject>

-(void)statisticsCellDidSwipe;
-(NSInteger)numberOfStatisticsShown:(id)sender;
-(Statistic *)statisticForIndex:(NSInteger)index; //fix TODO: shouldnt be void

@end

@interface StatisticsCollectionViewCell : UICollectionViewCell <UITableViewDataSource, UITableViewDelegate>

@property id<StatisticsCollectionViewCellDelegate> delegate;
@end
