//
//  StatisticsCollectionViewCell.m
//  Pipe Maze
//
//  Created by Jack Arendt on 2/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "StatisticsCollectionViewCell.h"

#define kTableViewCellIdentifier @"cell"


@interface StatisticsCollectionViewCell () {
    UISwipeGestureRecognizer *swipeGesture;
    UITableView *_tableView;
    
}

@end

@implementation StatisticsCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor blackColor];
        swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe)];
        swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeGesture];
        
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[StatisticTableViewCell class] forCellReuseIdentifier:kTableViewCellIdentifier];
        _tableView.backgroundColor = [PMConstants getGrayBackgroundColor];
        [self addSubview:_tableView];
    }
    
    return self;
}

-(void)didSwipe {
    if(self.delegate) {
        [self.delegate statisticsCellDidSwipe];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.delegate) {
        return [self.delegate numberOfStatisticsShown:self];
    }
    else return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatisticTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Statistic *stat = nil;
    if(self.delegate) {
        stat = [self.delegate statisticForIndex:indexPath.row];
    }
    [cell setStatistic:stat];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
