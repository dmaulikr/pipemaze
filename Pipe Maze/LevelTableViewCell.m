//
//  LevelTableViewCell.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/17/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "LevelTableViewCell.h"

@interface LevelTableViewCell () {
    CGFloat width;
    CGFloat height;
}

@end

@implementation LevelTableViewCell

- (void)awakeFromNib {
    width = self.bounds.size.width;
    height = self.bounds.size.height;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.levelLabel = [[UILabel alloc] init];
        self.starView = [[StarView alloc] init];
        self.timeLabel = [[UILabel alloc] init];
        self.lockedImageView = [[UIImageView alloc] init];
        
        [self addSubview:self.levelLabel];
        [self addSubview:self.starView];
        [self addSubview:self.timeLabel];
        [self addSubview:self.lockedImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setLevelAttributes:(Level *)level {
    width = self.bounds.size.width;
    height = self.bounds.size.height;
    
    //set level label attributes
    self.levelLabel.frame = CGRectMake(30, 10, width - 160, 30);
    self.levelLabel.font = [UIFont fontWithName:kFontName size:18.0];
    self.levelLabel.textColor = [PMConstants getNavyFontColor];
    self.levelLabel.text = level.levelName;

    //set star view attributes
    [self.starView setNewFrame:CGRectMake(width - 160, 25, 100, 30)];
    [self.starView updateStars:[level.stars integerValue]];
    
    //set time label attributes
    self.timeLabel.frame = CGRectMake(30, 35, width - 160, 30);
    self.timeLabel.font = [UIFont fontWithName:kFontName size:15.0];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    NSInteger seconds = [level.seconds integerValue];
    NSInteger minutes = seconds/60;
    seconds%=60;
    self.timeLabel.text = [NSString stringWithFormat:@"%02li:%02li", (long)minutes, (long)seconds];
    
    //set locked image view
    self.lockedImageView.frame = CGRectMake(5, 25, 20, 20);
    
    if(![level.available boolValue]) {
        self.lockedImageView.image = [UIImage imageNamed:@"lock"];
    }
    else {
        self.lockedImageView.image = nil;
    }
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}

@end
