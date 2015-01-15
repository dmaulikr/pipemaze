//
//  PiecesView.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/15/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "PiecesView.h"

@interface PiecesView ()
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
    if(straight > 0 && corner > 0) {
        self.straight = [[MazePieceView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height) piece:MazePieceStraight size:size numOfPieces:straight];
        self.straight.delegate = self;
        [self addSubview:self.straight];
        self.corner = [[MazePieceView alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height) piece:MazePieceCurved size:size numOfPieces:corner];
        self.corner.delegate = self;
        [self addSubview:self.corner];
    }
    
    if(straight > 0 && corner <= 0) {
        self.straight = [[MazePieceView alloc] initWithFrame:CGRectMake(self.frame.size.width/4, 0, self.frame.size.width/2, self.frame.size.height) piece:MazePieceStraight size:size numOfPieces:straight];
        self.straight.delegate = self;
        [self addSubview:self.straight];
    }
    
    if(straight <= 0 && corner > 0) {
        self.corner = [[MazePieceView alloc] initWithFrame:CGRectMake(self.frame.size.width/4, 0, self.frame.size.width/2, self.frame.size.height) piece:MazePieceCurved size:size numOfPieces:corner];
        self.corner.delegate = self;
        [self addSubview:self.corner];
    }
}

-(void)mazePieceDidSelectPiece:(MazePiece *)piece {
    if(self.delegate){
       [self.delegate piecesViewDidSelectMazePiece:piece];
    }
}

@end
