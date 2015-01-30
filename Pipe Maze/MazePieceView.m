//
//  MazePieceView.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/15/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "MazePieceView.h"
@class MazePiece;


@interface MazePieceView ()
@property (nonatomic) NSInteger num;
@property (nonatomic) MazePieces pieceType;
@property (nonatomic, strong) MazePiece *backgroundPiece;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UILabel *remainingLabel;
@end

@implementation MazePieceView

-(instancetype)init {
    self = [super init];
    if(self){
        self.num = 0;
        self.pieceType = MazePieceBlock;
        [self createView:CGSizeZero];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        self.num = 0;
        self.pieceType = MazePieceBlock;
        [self createView:CGSizeZero];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame piece:(MazePieces)mazePiece size:(CGSize)size numOfPieces:(NSInteger)num{
    self = [super initWithFrame:frame];
    if(self){
        self.num = num;
        self.pieceType = mazePiece;
        [self createView:size];
    }
    return self;
}

-(void)createView:(CGSize)size{
    CGFloat height = .2 * self.frame.size.height;
    CGFloat xOff = self.bounds.size.width/2 - size.width/2;
    self.remainingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height + size.height + 0.1*self.frame.size.height, self.frame.size.width, 30)];
    self.remainingLabel.text = [NSString stringWithFormat:@"x%li", (long)self.num];
    self.remainingLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:18.0];
    self.remainingLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.remainingLabel];
    
    MazePiece *piece;
    
    if(self.frame.size.height < 100 || self.frame.size.width == 384) {
        height = 10;
        xOff = self.bounds.size.width/2 - 3*size.width/4;
        self.remainingLabel.frame = CGRectMake(xOff + size.width + 15, height + size.height/2 - 15, self.frame.size.width - xOff - size.width - 15, 30);
        self.remainingLabel.textAlignment = NSTextAlignmentLeft;
    }

    if(self.pieceType == MazePieceCorner) {
        piece = [[MazePiece alloc] initWithFrame:CGRectMake(xOff, height, size.width, size.height) pieceType:self.pieceType start:PieceDirectionNorth end:PieceDirectionEast];
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(xOff - 3, height - 3, size.width + 6, size.width + 6)];
        [self addSubview:self.backgroundView];
        [self addSubview:piece];
    }
    else {
        piece = [[MazePiece alloc] initWithFrame:CGRectMake(xOff, height, size.width, size.height) pieceType:self.pieceType start:PieceDirectionNorth end:PieceDirectionSouth];
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(xOff - 3, height - 3, size.width + 6, size.width + 6)];
        [self addSubview:self.backgroundView];
        [self addSubview:piece];
    }

    piece.layer.borderColor = [UIColor lightGrayColor].CGColor;
    piece.layer.borderWidth = 1.0;
    piece.delegate = self;
}

-(void)hightlightPiece:(BOOL)enabled {
    if(enabled) {
        self.backgroundView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.backgroundView.layer.borderWidth = 5.0;
        
    }
    else {
        self.backgroundView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.backgroundView.layer.borderWidth = 0;
        
    }
}

-(void)updateRemainingPieces:(NSInteger)remaining {
    self.num = remaining;
    self.remainingLabel.text = [NSString stringWithFormat:@"x%li", (long)self.num];
}

-(BOOL)mazePieceCanMove:(id)sender {
    return NO;
}

-(BOOL)mazePieceCanRotate:(id)sender {
    return NO;
}

-(BOOL)mazePieceCanBeLongSelected:(id)sender {
    return NO;
}

-(BOOL)mazePieceCanBeDeselected:(id)sender {
    return NO;
}

-(void)mazePieceDidEndTouching:(id)sender {
    MazePiece *piece = (MazePiece *)sender;
    piece.layer.borderColor = [UIColor lightGrayColor].CGColor;
    piece.layer.borderWidth = 1.0;
}

-(void)mazePieceDidBeginTouching:(id)sender {
    [self.delegate mazePieceDidSelectPiece:(MazePiece *)sender];
}

@end
