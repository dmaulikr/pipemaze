//
//  StatisticTableViewCell.m
//  Pipe Maze
//
//  Created by Jack Arendt on 2/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "StatisticTableViewCell.h"
#import "PMConstants.h"

@interface StatisticTableViewCell () {
    UIView *_statisticView;
    UIView *_statisticBar;
    UILabel *_statisticLabel;
    Statistic *_statistic;
}

@end

@implementation StatisticTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        _statisticLabel = [[UILabel alloc] init];
        _statisticView = [[UIView alloc] init];
        _statisticBar = [[UIView alloc] init];
        
        [self addSubview:_statisticLabel];
        [self addSubview:_statisticView];
        [self addSubview:_statisticBar];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setStatistic:(Statistic *)statistic {
    _statistic = statistic;
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    
    _statisticLabel.frame = CGRectMake(10, 5, width - 20, 20);
    _statisticLabel.text = @"Levels Completed";
    _statisticLabel.font = [UIFont fontWithName:kFontName size:14.0];
    _statisticLabel.textColor = [UIColor lightGrayColor];
    
    _statisticView.frame = CGRectMake(10, 25, width - 20, height - 30);
    _statisticView.backgroundColor = [PMConstants getGrayBackgroundColor];
    _statisticView.layer.borderWidth = 1.0;
    _statisticView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _statisticBar.frame = CGRectMake(10, 25, _statisticView.bounds.size.width * 0.6, height - 30);
    _statisticBar.backgroundColor = [PMConstants getPipeColor];
}


@end
