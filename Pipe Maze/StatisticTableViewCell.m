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
    UILabel *_statValueLabel;
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
        _statValueLabel = [[UILabel alloc] init];
        
        [self addSubview:_statisticLabel];
        [self addSubview:_statisticView];
        [self addSubview:_statisticBar];
        [self addSubview:_statValueLabel];
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
    _statisticLabel.text = _statistic.name;
    _statisticLabel.font = [UIFont fontWithName:kFontName size:14.0];
    _statisticLabel.textColor = [UIColor lightGrayColor];
    
    _statisticView.frame = CGRectMake(10, 25, width - 20, height - 30);
    _statisticView.backgroundColor = [PMConstants getGrayBackgroundColor];
    _statisticView.layer.borderWidth = 1.0;
    _statisticView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    float percentage = [_statistic getPercentage];
    if(percentage > 1.0) percentage = 1.0;
    if(percentage < 0.0) percentage = 0.0;
    _statisticBar.frame = CGRectMake(10, 25, _statisticView.bounds.size.width * percentage, height - 30);
    _statisticBar.backgroundColor = [PMConstants getPipeColor];
    
    UIFont *font = [UIFont fontWithName:kFontName size:15];
    NSDictionary *userAttributes = @{NSFontAttributeName: font,
                                     NSForegroundColorAttributeName: [UIColor blackColor]};
    NSString *text = nil;
    if([_statistic.name isEqualToString:@"Average Number of Stars"]) {
        text = [NSString stringWithFormat:@"%.02f/%li", statistic.value.floatValue, (long)statistic.benchmark.integerValue];
    }
    else {
        text = [NSString stringWithFormat:@"%li/%li", (long)statistic.value.integerValue, (long)statistic.benchmark.integerValue];
    }
    const CGSize textSize = [text sizeWithAttributes: userAttributes];
    CGFloat strikeWidth = textSize.width;
    
    if(_statisticBar.bounds.size.width > strikeWidth + 10) {
        _statValueLabel.frame = CGRectMake(15, 25, width - 25, height - 30);
        _statValueLabel.text = text;
        _statValueLabel.textColor = [UIColor whiteColor];
        _statValueLabel.font = font;
    }
    
    else {
        _statValueLabel.frame = CGRectMake(_statisticBar.bounds.size.width + 20 , 25, width - 30 - _statisticBar.bounds.size.width, height - 30);
        _statValueLabel.text = text;
        _statValueLabel.textColor = [PMConstants getNavyFontColor];
        _statValueLabel.font = font;
    }
}


@end
