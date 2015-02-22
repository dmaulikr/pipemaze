//
//  ProfileHeaderView.h
//  Pipe Maze
//
//  Created by Jack Arendt on 2/20/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMConstants.h"

@interface ProfileHeaderView : UIView

-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)init;

-(void)setProfileData:(NSDictionary *)profileData;

@end
