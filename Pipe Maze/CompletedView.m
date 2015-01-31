//
//  CompletedView.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/17/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "CompletedView.h"
#import "StarView.h"
#import "PMConstants.h"

@interface CompletedView () {
    BOOL buttonPressed;
}
@property (nonatomic, strong) UILabel *compeltionLabel;
@property (nonatomic, strong) StarView *starView;
@property (nonatomic, strong) UIButton *dismissButton;
@end

@implementation CompletedView
@synthesize saying = _saying;
@synthesize stars = _stars;
//@synthesize time = _time;

-(instancetype)init {
    self = [super init];
    if(self) {
        [self createView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self createView];
    }
    return self;
}

-(void)createView {
    buttonPressed = NO;
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = self.bounds;
    self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    [self addSubview:effectView];
    
    
    self.compeltionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.bounds.size.width - 40, 30)];
    self.compeltionLabel.text = self.saying;
    self.compeltionLabel.textAlignment = NSTextAlignmentCenter;
    self.compeltionLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:22.0];
    [self addSubview:self.compeltionLabel];
    
    
    CGFloat xOff = 60;
    CGFloat height = 50;
    self.starView = [[StarView alloc] initWithFrame:CGRectMake(xOff, self.bounds.size.height - height - 40, self.bounds.size.width - 2*xOff , height) stars:self.stars];
    
    [self addSubview:self.starView];
    
    
    height = 100;
    self.dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(0, height, self.bounds.size.width, self.bounds.size.height - height)];
    [self.dismissButton setTitle:@"dismiss" forState:UIControlStateNormal];
    [self.dismissButton setBackgroundImage:[PMConstants imageWithColor:[UIColor colorWithWhite:1.0 alpha:0.9]] forState:UIControlStateNormal];
    [self.dismissButton setBackgroundImage:[PMConstants imageWithColor:[UIColor colorWithWhite:0.75 alpha:0.9]] forState:UIControlStateHighlighted];
    [self.dismissButton setTitleColor:[UIColor colorWithRed:0 green:0.478 blue:1.0 alpha:1] forState:UIControlStateNormal];
    self.dismissButton.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17.0];
    [self.dismissButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.dismissButton];
    
    self.layer.cornerRadius = 4.0;
    self.clipsToBounds = YES;
}

-(void)buttonPressed {
    buttonPressed = YES;
    if(self.delegate)
       [self.delegate viewDismissed];
}

-(void)showView:(UIView *)view completionHandler:(void (^)())completionHandler{
    [view addSubview:self];
    self.alpha = 0;
    [UIView animateKeyframesWithDuration:0.15 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        self.alpha = 1;
    }completion:nil];
}

-(void)setSaying:(NSString *)saying {
    self.compeltionLabel.text = saying;
}

-(void)setStars:(NSInteger)stars {
    [self.starView updateStars:stars];
}
@end
