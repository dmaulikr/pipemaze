//
//  ProfileHeaderView.m
//  Pipe Maze
//
//  Created by Jack Arendt on 2/20/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "ProfileHeaderView.h"


@interface ProfileHeaderView ()
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UILabel *firstNameLabel;
@property (nonatomic, strong) UILabel *lastNameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *facebookButton;
@property (nonatomic, strong) UIButton *twitterButton;
@end

@implementation ProfileHeaderView

-(instancetype)init {
    self = [super init];
    if(self) {
        self.profileImageView = [[UIImageView alloc] init];
        self.firstNameLabel = [[UILabel alloc] init];
        self.lastNameLabel = [[UILabel alloc] init];
        self.titleLabel = [[UILabel alloc] init];
        
        [self addSubview:self.profileImageView];
        [self addSubview:self.firstNameLabel];
        [self addSubview:self.lastNameLabel];
        [self addSubview:self.titleLabel];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        self.firstNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, self.bounds.size.width - 120 - 10, 30)];
        self.lastNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 50, self.bounds.size.width - 120 - 10, 30)];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 80, self.bounds.size.width - 120 - 10, 30)];
        
        [self addSubview:self.profileImageView];
        [self addSubview:self.firstNameLabel];
        [self addSubview:self.lastNameLabel];
        [self addSubview:self.titleLabel];
        
        self.backgroundColor = [UIColor whiteColor];
        UIView *sep = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1)];
        sep.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:sep];

        self.facebookButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 120, self.bounds.size.width/2 - 15, 40)];
        self.twitterButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 + 5, 120, self.bounds.size.width/2 - 15, 40)];
        [self addSubview:self.facebookButton];
        [self addSubview:self.twitterButton];
        [self setButtonViews];
    }
    return self;
}


-(void)setProfileData:(NSDictionary *)profileData {
    NSString *firstName = profileData[kUserProfileFirstName];
    NSString *lastName = profileData[kUserProfileLastName];
    UIImage *profileImage = profileData[kUserProfilePicture];
    NSString *profileTitle = profileData[kUserProfileTitle];
    
    
    self.profileImageView.image = profileImage;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.size.height/2;
    
    self.firstNameLabel.text = firstName;
    self.firstNameLabel.textColor = [PMConstants getNavyFontColor];
    self.firstNameLabel.font = [UIFont fontWithName:kFontName size:21.0];
    self.firstNameLabel.minimumScaleFactor = 0.7;
    self.firstNameLabel.adjustsFontSizeToFitWidth = YES;
    
    self.lastNameLabel.text = lastName;
    self.lastNameLabel.textColor = [PMConstants getNavyFontColor];
    self.lastNameLabel.font = [UIFont fontWithName:kFontName size:21.0];
    self.lastNameLabel.minimumScaleFactor = 0.7;
    self.lastNameLabel.adjustsFontSizeToFitWidth = YES;
    
    self.titleLabel.text = profileTitle;
    self.titleLabel.textColor = [UIColor grayColor];
    self.titleLabel.font = [UIFont fontWithName:kFontName size:16.0];
}

-(void)setButtonViews {
    [self.facebookButton setTitle:@"connect facebook" forState:UIControlStateNormal];
    self.facebookButton.titleLabel.font = [UIFont fontWithName:kFontName size:15.0];
    self.facebookButton.layer.cornerRadius = 4.0;
    self.facebookButton.layer.borderWidth = 1.0f;
    self.facebookButton.layer.borderColor = [PMConstants  getFacebookBlue].CGColor;
    
    [self.facebookButton setTitleColor:[PMConstants getFacebookBlue] forState:UIControlStateNormal];
    //[self.facebookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.facebookButton setImage:[PMConstants imageWithColor:[PMConstants getFacebookBlue]] forState:UIControlStateHighlighted];
    //[self.facebookButton setImage:[PMConstants imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    
    
    
    [self.twitterButton setTitle:@"connect twitter" forState:UIControlStateNormal];
    self.twitterButton.titleLabel.font = [UIFont fontWithName:kFontName size:15.0];
    self.twitterButton.layer.cornerRadius = 4.0;
    self.twitterButton.layer.borderWidth = 1.0f;
    self.twitterButton.layer.borderColor = [PMConstants getTwitterBlue].CGColor;
    
    [self.twitterButton setTitleColor:[PMConstants getTwitterBlue] forState:UIControlStateNormal];
    //[self.twitterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.twitterButton setImage:[PMConstants imageWithColor:[PMConstants getTwitterBlue]] forState:UIControlStateHighlighted];
    //[self.twitterButton setImage:[PMConstants imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
}


@end
