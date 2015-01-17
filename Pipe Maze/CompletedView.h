//
//  CompletedView.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/17/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CompletedViewDelegate <NSObject>

-(void)viewDismissed;

@end

@interface CompletedView : UIView

-(instancetype)init;
-(instancetype)initWithFrame:(CGRect)frame;


@property (nonatomic) NSInteger stars;
//@property (nonatomic) NSInteger time;
@property (nonatomic) NSString *saying;
@property id<CompletedViewDelegate> delegate;

-(void)showView:(UIView *)view completionHandler:(void(^)())completionHandler;

@end
