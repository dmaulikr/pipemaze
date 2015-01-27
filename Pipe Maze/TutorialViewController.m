//
//  TutorialViewController.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/17/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController () {
    CGFloat spacing;
    UILabel *taskLabel;
}

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageControl.numberOfPages = 7;
    self.pageControl.currentPage = 0;
    
    taskLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.bounds.size.height -60, self.view.bounds.size.width - 20, 30)];
    taskLabel.text = @"The goal is to complete the maze";
    taskLabel.textAlignment = NSTextAlignmentCenter;
    taskLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:16.0];
    taskLabel.textColor = [UIColor blackColor];
    
    
    [self.view addSubview:taskLabel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate {
    return NO;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 7;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *images = @[@"start", @"place", @"rotate", @"start", @"complete", @"leftover", @"leftoveronedge"];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *image = [[UIImageView alloc] initWithFrame:cell.bounds];
    image.image = [UIImage imageNamed:images[indexPath.section]];
    
    [cell addSubview:image];
    
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSArray *arr = [self.collectionView indexPathsForVisibleItems];
    NSArray *desc = @[@"The goal is to complete the maze", @"tap a piece then tap to place", @"tap the piece again to rotate", @"You can restart, check and undo", @"You need to use all the pieces to win", @"If you don't you'll get an error", @"Make sure all the pieces touch"];
    self.pageControl.currentPage = ((NSIndexPath *)arr[0]).section;
    taskLabel.text = desc[self.pageControl.currentPage];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.view.bounds.size.width * 0.7;
    spacing = 0.15;
    if(self.view.bounds.size.height == 480){
        width = self.view.bounds.size.width * 0.6;
        spacing = 0.2;
    }
    CGFloat height = 1.7333 * width;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(40, spacing * self.view.bounds.size.width, 0, spacing * self.view.bounds.size.width);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return spacing * self.view.bounds.size.width;
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
