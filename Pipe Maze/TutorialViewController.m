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
    self.pageControl.numberOfPages = 13;
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
    return 13;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *images = @[@"01start", @"02tap_piece", @"03place_piece", @"04rotate", @"05undo", @"06delete", @"07checkmaze", @"08completed", @"09allpieces", @"10alltouch", @"11error", @"12restart", @"13pause"];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *image = [[UIImageView alloc] initWithFrame:cell.bounds];
    image.image = [UIImage imageNamed:images[indexPath.section]];
    
    [cell addSubview:image];
    
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSArray *arr = [self.collectionView indexPathsForVisibleItems];
    NSArray *desc = @[@"The goal is to complete the maze", @"Tap a piece to select it", @"Then tap where you want to place it", @"Tap the piece again to rotate it", @"You can undo a move if you please", @"Or you can delete it by holding it down", @"Touch the play button to check the maze", @"Hopefully you get this screen", @"Make sure all the pieces are used", @"And they all touch", @"Or you'll get this screen", @"You can restart whenever you want", @"Or pause if needed. Have fun!"];
    self.pageControl.currentPage = ((NSIndexPath *)arr[0]).section;
    taskLabel.text = desc[self.pageControl.currentPage];
    taskLabel.minimumScaleFactor = 0.7;
    taskLabel.adjustsFontSizeToFitWidth = YES;
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
