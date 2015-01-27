//
//  PiecesView.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/15/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "PiecesView.h"

@interface PiecesView (){
    BOOL straightSelected;
    BOOL cornerSelected;
}
@property (nonatomic, strong) MazePieceView *straight;
@property (nonatomic, strong) MazePieceView *corner;
@end


@implementation PiecesView

-(instancetype)init {
    self = [super init];
    if(self){
        [self createView:0 corner:0 size:CGSizeZero];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self createView:0 corner:0 size:CGSizeZero];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame straight:(NSInteger)straightPieces corner:(NSInteger)cornerPieces pieceSize:(CGSize)size{
    self = [super initWithFrame:frame];
    if(self){
        [self createView:straightPieces corner:cornerPieces size:size];
    }
    return self;
}

-(void)createView:(NSInteger)straight corner:(NSInteger)corner size:(CGSize)size{
    cornerSelected = NO;
    straightSelected = NO;
    
        self.straight = [[MazePieceView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height) piece:MazePieceStraight size:size numOfPieces:straight];
        self.straight.delegate = self;
        [self addSubview:self.straight];
        self.corner = [[MazePieceView alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height) piece:MazePieceCurved size:size numOfPieces:corner];
        self.corner.delegate = self;
        [self addSubview:self.corner];
}

-(void)updateRemainingStraightPieces:(NSInteger)straight curved:(NSInteger)corner {
    [self.straight updateRemainingPieces:straight];
    [self.corner updateRemainingPieces:corner];
}

-(void)mazePieceDidSelectPiece:(MazePiece *)piece {
    if(piece.piece == MazePieceStraight) {
        [self.straight hightlightPiece:!straightSelected];
        straightSelected = !straightSelected;
        [self.corner hightlightPiece:NO];
        cornerSelected = NO;
        
        if(self.delegate && straightSelected){
            [self.delegate piecesViewDidSelectMazePiece:piece];
        }
        else {
            [self.delegate piecesViewDidSelectMazePiece:nil];
        }
    }
    
    if(piece.piece == MazePieceCurved) {
        [self.corner hightlightPiece:!cornerSelected];
        cornerSelected = !cornerSelected;
        [self.straight hightlightPiece:NO];
        straightSelected = NO;
        if(self.delegate && cornerSelected){
            [self.delegate piecesViewDidSelectMazePiece:piece];
        }
        else {
            [self.delegate piecesViewDidSelectMazePiece:nil];
        }
    }
    
}

@end
