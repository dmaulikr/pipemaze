//
//  TutorialViewController.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/17/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "TutorialViewController.h"

#define visited @"visited"

@interface TutorialViewController () {
    CGFloat spacing;
    UILabel *taskLabel;
    NSArray *images;
    NSArray *desc;
    UIBarButtonItem *goBackBarButton;
    BOOL isPlaying;
    BOOL didEnd;
    NSInteger index;
}

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    taskLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.bounds.size.height -60, self.view.bounds.size.width - 20, 30)];
    taskLabel.textAlignment = NSTextAlignmentCenter;
    taskLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:16.0];
    taskLabel.textColor = [UIColor blackColor];
    
    desc = @[@"the goal is to complete the maze", @"tap a piece to select it", @"then tap where you want to place it", @"tap the piece again to rotate it", @"you can undo a move if you please", @"or you can delete it by holding it down", @"touch the play button to check the maze", @"hopefully you get this screen", @"make sure all the pieces are used", @"and they all touch", @"or you'll get this screen", @"you can restart whenever you want", @"or pause if needed. have fun!", @"stars are based on time. faster the better"];
    
    NSArray *images4S = @[@"01start4S", @"02tap_piece4S", @"03place_piece4S", @"04rotate4S", @"05undo4S", @"06delete4S", @"07checkmaze4S", @"08completed4S", @"09allpieces4S", @"10alltouch4S", @"11error4S", @"12restart4S", @"13pause4S", @"13pause4S"];
    NSArray *images5 = @[@"01start", @"02tap_piece", @"03place_piece", @"04rotate", @"05undo", @"06delete", @"07checkmaze", @"08completed", @"09allpieces", @"10alltouch", @"11error", @"12restart", @"13pause", @"13pause"];
    NSArray *imagesiPad = @[@"01startiPad", @"02tap_pieceiPad", @"03place_pieceiPad", @"04rotateiPad", @"05undoiPad", @"06deleteiPad", @"07checkmazeiPad", @"08completediPad", @"09allpiecesiPad", @"10alltouchiPad", @"11erroriPad", @"12restartiPad", @"13pauseiPad", @"13pauseiPad"];
    
    
    if(self.newSlideShow == true) {
        self.navigationItem.title = @"What's New";
        if(self.view.bounds.size.height == 480) {
            images = @[@"06delete4S", @"13pause4S", @"13pause4S"];
        }
        else if(self.view.bounds.size.height == 1024) {
            images = @[@"06deleteiPad", @"13pauseiPad", @"13pauseiPad"];
        }
        else {
            images = @[@"06delete", @"13pause", @"13pause"];
        }
        desc = @[@"hold a piece down to delete it.", @"you can pause whenever you like", @"stars are based on time. faster the better"];
    }
    else {
        if(self.view.bounds.size.height == 480) {
            images = images4S;
        }
        else if(self.view.bounds.size.height == 1024) {
            images = imagesiPad;
        }
        else {
            images = images5;
        }
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL seen = [userDefaults boolForKey:visited];
    goBackBarButton = self.goBackButton;
    if(!seen) {
        self.navigationItem.rightBarButtonItem = nil;
        [userDefaults setBool:YES forKey:visited];
        [userDefaults synchronize];
    }
    
//    if(self.newSlideShow) {
//        self.navigationItem.rightBarButtonItem = nil;
//    }
    
    
    self.pageControl.numberOfPages = images.count;
    self.pageControl.currentPage = 0;
    taskLabel.text = desc[0];
    [self.navigationItem setHidesBackButton:YES];
    
    
    [self.view addSubview:taskLabel];
    isPlaying = NO;
    didEnd = NO;
    
    index = 0;
    NSTimer *timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(nextSlide) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collection view delegate methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *image = [[UIImageView alloc] initWithFrame:cell.bounds];
    image.image = [UIImage imageNamed:images[indexPath.section]];
    
    [cell addSubview:image];
    
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSArray *arr = [self.collectionView indexPathsForVisibleItems];
    index = ((NSIndexPath *)arr[0]).section;
    [self updateTaskLabelAndPageControl];
    
    if(index == images.count -1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(toggleSlideshow:)];
        didEnd = YES;
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.view.bounds.size.width * 0.75;
    CGFloat height = 1.7333 * width;
    spacing = 0.125;
    if(self.view.bounds.size.height == 480){
        width = self.view.bounds.size.width * 0.65;
        spacing = 0.175;
        height = 1.5 * width;
    }
    
    if(self.view.bounds.size.height == 1024) {
        width = self.view.bounds.size.width * 0.8;
        spacing = 0.1;
        height = 1.333333 * width;
    }
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(40, spacing * self.view.bounds.size.width, 0, spacing * self.view.bounds.size.width);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return spacing * self.view.bounds.size.width;
}

#pragma mark - IBActions

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)toggleSlideshow:(id)sender {
    if(isPlaying) {
        isPlaying = NO;
        self.collectionView.userInteractionEnabled = YES;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(toggleSlideshow:)];
    }
    else if(!isPlaying && !didEnd) {
        isPlaying = YES;
        self.collectionView.userInteractionEnabled = NO;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(toggleSlideshow:)];
    }
    
    else if(didEnd) {
        didEnd = NO;
        self.collectionView.userInteractionEnabled = YES;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(toggleSlideshow:)];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        index = 0;
        [self updateTaskLabelAndPageControl];
        
    }
}

- (void)updateTaskLabelAndPageControl {
    self.pageControl.currentPage = index;
    taskLabel.text = desc[self.pageControl.currentPage];
    taskLabel.minimumScaleFactor = 0.7;
    taskLabel.adjustsFontSizeToFitWidth = YES;
    
    if(self.pageControl.currentPage == images.count -1) {
        self.navigationItem.rightBarButtonItem = goBackBarButton;
    }
}

-(void)nextSlide {
    
    if(isPlaying) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        [self updateTaskLabelAndPageControl];
        index++;
    }
    
    if(index == images.count) {
        self.collectionView.userInteractionEnabled = YES;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(toggleSlideshow:)];
        didEnd = YES;
        isPlaying = NO;
    }
}
@end
