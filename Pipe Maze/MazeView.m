//
//  MazeView.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/12/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "MazeView.h"

@interface MazeView () {
    CGPoint touchedLocation;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MazePiece *selectedPiece;
@end

@implementation MazeView

static NSString * const reuseIdentifier = @"Cell";

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
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout: layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[MazePieceCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self addSubview:self.collectionView];
}

#pragma mark - collection view delegate methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 25;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MazePieceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:0.957 green:0.957 blue:0.957 alpha:1.0];
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.layer.borderWidth = 0.5f;
    cell.piece = nil;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.bounds.size.width/5, self.bounds.size.height/5);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(self.selectedPiece){
        [self.selectedPiece deselect];
    }

    MazePiece *piece = [self.delegate touchReceivedOnMaze];
    if(![self.delegate canPlaceMazePiece:piece]){
        return;
    }
    MazePieceCollectionViewCell *cell = (MazePieceCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    MazePiece *item = [[MazePiece alloc] initWithFrame:CGRectMake(0, 0, piece.frame.size.width, piece.frame.size.height) pieceType:piece.piece start:piece.startDirection end:piece.endDirection index:indexPath.row];
    item.delegate = self;
    
    [self.delegate mazePiecePlaced:piece atIndex:indexPath.row];
    piece.index = [NSNumber numberWithInteger:indexPath.row];
    cell.piece = item;
    self.selectedPiece = item;
    [cell addSubview:item];
}

-(CGSize)getPieceSize {
    return CGSizeMake(self.bounds.size.width/5, self.bounds.size.height/5);
}

#pragma mark - Maze Piece Delegate Methods

-(BOOL)mazePieceCanMove:(id)sender {
    return YES;
}

-(BOOL)mazePieceCanRotate:(id)sender {
    return YES;
}

-(BOOL)mazePieceCanBeLongSelected:(id)sender {
    return YES;
}

-(BOOL)mazePieceCanBeDeselected:(id)sender {
    return YES;
}

-(void)mazePieceDidBeginTouching:(id)sender {
    if(self.selectedPiece){
        [self.selectedPiece deselect];
    }
    self.selectedPiece = sender;
}

-(void)mazePieceDidEndTouching:(id)sender {
    
}

-(void)mazePieceWasSelected:(id)sender {
    if(self.delegate){
        [self.delegate deselectMazePieces];
    }
}

-(void)mazePieceDidRotate:(id)sender {
    MazePiece *piece = (MazePiece *)sender;
    if(self.delegate)
        [self.delegate mazePiecePlaced:sender atIndex:[piece.index integerValue]];
}

-(void)placePiece:(MazePiece *)piece atIndex:(NSInteger)index {
    MazePieceCollectionViewCell *cell = (MazePieceCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.piece = piece;
    [cell addSubview:piece];
}

-(void)mazePieceWasDeleted:(id)sender {
    MazePiece *piece = sender;
    MazePieceCollectionViewCell *cell = (MazePieceCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:[piece.index integerValue] inSection:0]];
    [cell.piece removeFromSuperview];
    if(self.delegate) {
        [self.delegate mazePieceWasDeleted:cell.piece atIndex:[cell.piece.index integerValue]];
    }
    cell.piece = nil;
}

-(void)restartMaze {
    for(int i = 0; i < 25; i++) {
        MazePieceCollectionViewCell *cell = (MazePieceCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        NSArray *arr = [cell subviews];
        if(arr.count > 1) {
            MazePiece *piece = arr[1];
            [piece removeFromSuperview];
        }
    }
}

-(void)undoMove:(MazeMove *)move {
    MazePieceCollectionViewCell *cell = (MazePieceCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:move.newIndex inSection:0]];
    NSArray *arr = [cell subviews];
    if(arr.count > 1) {
        MazePiece *piece = arr[1];
        if(move.oldPiece == MazePieceEmpty) {
            [piece removeFromSuperview];
            cell.piece = nil;
        }
        if(move.oldPiece == MazePieceCorner) {
            [piece undoRotateCornerPiece:piece.frame direction:move.newStartDirection];
            piece.startDirection = move.oldStartDirection;
            piece.endDirection = move.oldEndDirection;
        }
        
        if(move.oldPiece == MazePieceStraight) {
            [piece undoRotateStraightPiece:piece.frame direction:move.newStartDirection];
            piece.startDirection = move.oldStartDirection;
            piece.endDirection = move.oldEndDirection;
        }
    }
}

@end
