//
//  AchievementsCollectionViewCell.m
//  Pipe Maze
//
//  Created by Jack Arendt on 2/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "AchievementsCollectionViewCell.h"


@interface AchievementsCollectionViewCell () {
    UISwipeGestureRecognizer *swipeGesture;
    UICollectionView *_collectionView;
}

@end

@implementation AchievementsCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe)];
        swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipeGesture];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
    }
    return self;
}

-(void)didSwipe {
    if(self.delegate) {
        [self.delegate achievementCellDidSwipe];
    }
}

#pragma mark - collection view delegate methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15; //TODO: make correct number of items
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //TODO: make correct cell and load it with achievement
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 100); //TODO: fix for correct size
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
