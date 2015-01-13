//
//  LevelCollectionViewController.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/12/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "LevelCollectionViewController.h"
#import "World.h"
#import "MazeViewController.h"

@interface LevelCollectionViewController () {
    NSInteger sections;
    NSMutableArray *worlds;
    BOOL transition;
}

@end

@implementation LevelCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    transition = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    worlds = [[NSMutableArray alloc] init];
    [worlds addObject:[[World alloc] initWithColor:[UIColor colorWithRed:1.0 green:0.522 blue:0.106 alpha:1]]];
    [worlds addObject:[[World alloc] initWithColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.251 alpha:1]]];
    [worlds addObject:[[World alloc] initWithColor:[UIColor colorWithRed:0.498 green:0.859 blue:1.0 alpha:1]]];
    [worlds addObject:[[World alloc] initWithColor:[UIColor colorWithRed:.224 green:0.80 blue:0.80 alpha:1]]];
    [worlds addObject:[[World alloc] initWithColor:[UIColor colorWithRed:1.0 green:0.252 blue:0.212 alpha:1]]];
    
    sections = [worlds count];
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return sections;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    LevelView *level = [[LevelView alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height) level:indexPath.section * 12 + indexPath.row + 1 completed:NO stars:indexPath.row % 6 color:((World *)worlds[indexPath.section]).mainColor];
    [cell addSubview:level];
    return cell;
}

#pragma mark <UICollectionViewDelegate>




-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"toMaze" sender:indexPath];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if(section == 0)
        return CGSizeMake(self.view.bounds.size.width, 10);
    return CGSizeMake(self.view.bounds.size.width, 50);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //return CGSizeMake((self.view.bounds.size.width- 50)/4, (self.view.bounds.size.width- 50)/4); //4 across
    return CGSizeMake(floor((self.view.bounds.size.width- 40)/3), floor((self.view.bounds.size.width- 40)/3)); // 3 across
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if(section == sections - 1) {
        return CGSizeMake(self.view.bounds.size.width, 10);
    }
    
    return CGSizeZero;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toMaze"]) {
        transition = YES;
        MazeViewController *maze = [segue destinationViewController];
        maze.world = worlds[((NSIndexPath *)sender).section];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSArray *arr = [self.collectionView indexPathsForVisibleItems];
    
    
    NSInteger lowest = INT_MAX;
    
    if(arr.count == 0) {
        lowest = 0;
    }
    else {
        for(NSIndexPath *index in arr) {
            if(index.section < lowest) {
                lowest = index.section;
            }
        }
    }
    if(!transition)
        self.navigationController.navigationBar.tintColor = ((World *)worlds[lowest]).mainColor;
}
@end
