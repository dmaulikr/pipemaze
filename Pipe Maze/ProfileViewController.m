//
//  ProfileViewController.m
//  Pipe Maze
//
//  Created by Jack Arendt on 2/20/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileHeaderView.h"
#import "Statistic.h"

#define kTableViewCellIdentifier @"tablecell"
#define kCollectionViewCellIdentifier @"collectioncell"

#define kAchievementIndex 1
#define kStatisticsIndex 0

@interface ProfileViewController ()
@property (nonatomic, strong) UISegmentedControl *control;
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [PMConstants getGrayBackgroundColor];
    CGFloat height = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    ProfileHeaderView *header = [[ProfileHeaderView alloc] initWithFrame:CGRectMake(0, height, self.view.bounds.size.width, 165)];
    [header setProfileData:@{kUserProfileFirstName : @"Jack",
                            kUserProfileLastName : @"Arendt",
                            kUserProfilePicture : [UIImage imageNamed:@"profilepicture.jpg"],
                             kUserProfileTitle : @"King Pipe Solver"}];
    [self.view addSubview:header];
    
    
    //segmented control allocation
    self.control = [[UISegmentedControl alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 120, height + header.bounds.size.height + 15, 240, 35)];
    [self.control insertSegmentWithTitle:@"Statistics" atIndex:0 animated:YES];
    [self.control insertSegmentWithTitle:@"Achievements" atIndex:1 animated:YES];
    [self.control setTintColor:[PMConstants getNavyFontColor]];
    self.control.selectedSegmentIndex = 0;
    [self.control addTarget:self action:@selector(changeIndex) forControlEvents:UIControlEventValueChanged];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont fontWithName:kFontName size:15.0]
                                                           forKey:NSFontAttributeName];
    [self.control setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self.view addSubview:self.control];
    
    
    //horizontal separator in between collection view and segmened control
    UIView *sep = [[UIView alloc] initWithFrame:CGRectMake(0, self.control.frame.origin.y + self.control.bounds.size.height + 15, self.view.bounds.size.width, 1)];
    sep.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:sep];
    
    //collection view allocation
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    CGFloat collectionYOff = self.control.frame.origin.y + self.control.bounds.size.height + 16;
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, collectionYOff, self.view.bounds.size.width, self.view.bounds.size.height - collectionYOff) collectionViewLayout:layout];
    [self.mainCollectionView registerClass:[StatisticsCollectionViewCell class] forCellWithReuseIdentifier:kTableViewCellIdentifier];
    [self.mainCollectionView registerClass:[AchievementsCollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
    [self.mainCollectionView setDataSource:self];
    [self.mainCollectionView setDelegate:self];
    self.mainCollectionView.backgroundColor = [UIColor clearColor];
    self.mainCollectionView.showsHorizontalScrollIndicator = NO;
    self.mainCollectionView.scrollEnabled = NO;
    [self.view addSubview:self.mainCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collection view delegate methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        StatisticsCollectionViewCell *cell = (StatisticsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kTableViewCellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
    else {
        AchievementsCollectionViewCell *cell = (AchievementsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.bounds.size.width, collectionView.bounds.size.height);
}

#pragma mark Segment Control Method

-(void)changeIndex {
    [self.mainCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.control.selectedSegmentIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}

#pragma mark - Statistics Delegate Methods
-(void)statisticsCellDidSwipe {
    [self.mainCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:kAchievementIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    self.control.selectedSegmentIndex = kAchievementIndex;
}

-(NSInteger)numberOfStatisticsShown:(id)sender {
    return 10;
}

-(Statistic *)statisticForIndex:(NSInteger)index {
    return nil;
}

#pragma mark - Achievement Delegate Methods
-(void)achievementCellDidSwipe{
    [self.mainCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:kStatisticsIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    self.control.selectedSegmentIndex = kStatisticsIndex;
}
@end
