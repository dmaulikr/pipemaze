//
//  MazePiece.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/15/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "MazePiece.h"

@interface MazePiece ()

@property (nonatomic) CGRect originalFrame;


@property (nonatomic, strong) UIView *curvedOuterView;
@property (nonatomic, strong) UIView *curvedInnerView;

@property (nonatomic, strong) UIView *straight;
@property (nonatomic, strong) UIColor *pipeColor;
@end

@implementation MazePiece

#pragma mark - Init functions
-(instancetype)init {
    self = [super init];
    if(self){
        self.piece = MazePieceBlock;
        self.startDirection = PieceDirectionNone;
        self.endDirection = PieceDirectionNone;
        self.originalFrame = CGRectZero;
        [self createView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        self.piece = MazePieceBlock;
        self.startDirection = PieceDirectionNone;
        self.endDirection = PieceDirectionNone;
        self.originalFrame = frame;
        [self createView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame pieceType:(MazePieces)piece start:(PieceDirection)start end:(PieceDirection)end {
    self = [super initWithFrame:frame];
    if(self){
        self.piece = piece;
        self.startDirection = start;
        self.endDirection = end;
        self.originalFrame = frame;
        [self createView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame pieceType:(MazePieces)piece start:(PieceDirection)start end:(PieceDirection)end index:(NSInteger)index {
    self = [super initWithFrame:frame];
    if(self){
        self.piece = piece;
        self.startDirection = start;
        self.endDirection = end;
        self.originalFrame = frame;
        self.index = [[NSNumber alloc] initWithInteger:index];
        [self createView];
    }
    return self;
}

#pragma mark - View Creators

-(void)createView {
    CGSize size = self.frame.size;
    self.pipeColor = [UIColor colorWithRed:0.18 green:0.356 blue:0.537 alpha:1.0];
    
    switch (self.piece) {
        case MazePieceStraight:
            [self createStraightView:size];
            break;
        case MazePieceCurved:
            [self createCornerView:size];
            break;
        case MazePieceBlock:
            [self createBlockView:size];
            break;
        default:
            break;
    }
}

-(void)createStraightView:(CGSize)size {
    if(self.startDirection == PieceDirectionNorth || self.startDirection == PieceDirectionSouth) { //vertical straight piece
        self.straight = [[UIView alloc] initWithFrame:CGRectMake(floor(self.frame.size.width/4), 0, self.frame.size.width/2, self.frame.size.height)];
        self.straight.backgroundColor = self.pipeColor;
        
        [self addSubview:self.straight];
    }
    
    else { //horizontal straight piece
        self.straight = [[UIView alloc] initWithFrame:CGRectMake(0, floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height/2)];
        self.straight.backgroundColor = self.pipeColor;
        
        [self addSubview:self.straight];
    }
    self.backgroundColor = [UIColor whiteColor];
}

-(void)createCornerView:(CGSize)size {
    if(self.startDirection == PieceDirectionNorth) {
        
        self.curvedOuterView = [[UIView alloc] initWithFrame:CGRectMake(floor(self.frame.size.width/4), -self.bounds.size.height/2 + floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.curvedOuterView];
        
        self.curvedInnerView = [[UIView alloc] initWithFrame:CGRectMake(floor(self.frame.size.width/4) + self.frame.size.width/2, 0, self.frame.size.width/2, floor(self.frame.size.height/4))];
        [self addSubview:self.curvedInnerView];
    }
    
    if(self.startDirection == PieceDirectionEast) {
        
        self.curvedOuterView = [[UIView alloc] initWithFrame:CGRectMake(floor(self.frame.size.width/4), floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.curvedOuterView];
        
        self.curvedInnerView = [[UIView alloc] initWithFrame:CGRectMake(floor(self.frame.size.width/4) + self.frame.size.width/2, floor(self.frame.size.height/4) + self.frame.size.height/2, self.frame.size.width/2, self.frame.size.height/2)];
        [self addSubview:self.curvedInnerView];
    }
    
    if(self.startDirection == PieceDirectionSouth) {
        self.curvedOuterView = [[UIView alloc] initWithFrame:CGRectMake(-self.frame.size.width/2 + floor(self.frame.size.width/4), floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.curvedOuterView];
        
        self.curvedInnerView = [[UIView alloc] initWithFrame:CGRectMake(0, floor(self.frame.size.width/4) + self.frame.size.width/2, floor(self.frame.size.width/4), self.frame.size.width/2)];
        [self addSubview:self.curvedInnerView];
    }
    
    if(self.startDirection == PieceDirectionWest) {
        self.curvedOuterView = [[UIView alloc] initWithFrame:CGRectMake(-self.frame.size.width/2 + floor(self.frame.size.width/4), -self.frame.size.height/2 + floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.curvedOuterView];
        
        self.curvedInnerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, floor(self.frame.size.width/4), floor(self.frame.size.height/4))];
        [self addSubview:self.curvedInnerView];
    }
    
    self.curvedInnerView.clipsToBounds = YES;
    self.curvedInnerView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    self.curvedOuterView.backgroundColor = self.pipeColor;
    self.curvedOuterView.clipsToBounds = YES;
    self.clipsToBounds = YES;

}

-(void)createBlockView:(CGSize)size {
    self.backgroundColor = [UIColor colorWithRed:0.239 green:0.60 blue:0.439 alpha:1.0];
}

#pragma mark - Touch Recognizers

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if([self.delegate mazePieceCanMove:self]) {
        //CGRect frame = CGRectMake(self.frame.origin.x - 0.1*self.frame.size.width, self.frame.origin.y - 0.1*self.frame.size.height, 1.2 * self.frame.size.width, 1.2 * self.frame.size.height);
        self.frame = self.originalFrame;
        if(self.piece == MazePieceStraight){
            [self enlargeStraightPiece:self.originalFrame direction:self.startDirection];
        }
        if(self.piece == MazePieceCurved) {
            [self enlargeCurvedPiece:self.originalFrame direction:self.startDirection];
        }
        [self enlarge];
    }
    [self.delegate mazePieceDidBeginTouching:self];
}

//Shrink back to normal size
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if([self.delegate mazePieceCanMove:self]) {
        self.frame = self.originalFrame;
        if(self.piece == MazePieceStraight){
            //needs some fixing
            if([self.delegate mazePieceCanRotate:self]){
                [self shrinkStraightPieceAndRotate:self.frame direction:self.startDirection];
            }
            else {
                [self shrinkStraightPiece:self.frame direction:self.startDirection];
            }
        }
        if(self.piece == MazePieceCurved) {
            if([self.delegate mazePieceCanRotate:self]){
                [self shrinkCurvedPieceAndRotate:self.frame direction:self.startDirection];
            }
            else {
                [self shrinkCurvedPiece:self.frame direction:self.startDirection];
            }
        }
        [self shrink];
    }
    if(self.delegate) {
        [self.delegate mazePieceDidEndTouching:self];
    }
}

#pragma mark - Methods for changing the frame/rotation of straight piece

-(void)shrinkStraightPieceAndRotate:(CGRect)frame direction:(PieceDirection)direction {
    //rotate from horizontal to vertical
    [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        [self getStraightNewRotation];
        [self changeStraightFrame:frame direction:self.startDirection];
    }completion:^(BOOL finished){
        [self rotatePiece];
        if(self.delegate)
            [self.delegate mazePieceDidRotate:self];
    }];

}

-(void)shrinkStraightPiece:(CGRect)frame direction:(PieceDirection)direction {
    [self changeStraightFrame:frame direction:self.startDirection];
    [self rotatePiece];
}

-(void)enlargeStraightPiece:(CGRect)frame direction:(PieceDirection)direction {
    [self changeStraightFrame:frame direction:direction];
}


-(void)changeStraightFrame:(CGRect)frame direction:(PieceDirection)direction {
    if(direction == PieceDirectionEast || direction == PieceDirectionWest) //enlarge horizontal
        self.straight.frame = CGRectMake(0, floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height/2);
    else //enlarge vertical
        self.straight.frame = CGRectMake(floor(self.frame.size.width/4), 0, self.frame.size.width/2, self.frame.size.height);
}

#pragma mark - Methods for changing the frame/rotation of curved piece

-(void)enlargeCurvedPiece:(CGRect)frame direction:(PieceDirection)direction {
    [self changeCurvedFrame:frame direction:self.startDirection];
}

-(void)shrinkCurvedPiece:(CGRect)frame direction:(PieceDirection)direction {
    [self changeCurvedFrame:frame direction:self.startDirection];
}

-(void)shrinkCurvedPieceAndRotate:(CGRect)frame direction:(PieceDirection)direction {
    [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        [self changeCurvedFrame:frame direction:self.endDirection];
    }completion:^(BOOL finished){
        self.startDirection = self.endDirection;
        [self rotatePiece];
        if(self.delegate)
           [self.delegate mazePieceDidRotate:self];
    }];
}

-(void)undoRotateCurvedPiece:(CGRect)frame direction:(PieceDirection)direction {
    [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        [self undoCurvedFrame:frame direction:direction];
    }completion:^(BOOL finished){
    }];

}


-(void)changeCurvedFrame:(CGRect)frame direction:(PieceDirection)direction{
    if(direction == PieceDirectionNorth){
        self.curvedOuterView.frame = CGRectMake(floor(self.frame.size.width/4), -self.bounds.size.height/2 + floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height);
        self.curvedInnerView.frame = CGRectMake(floor(self.frame.size.width/4) + self.frame.size.width/2, 0, self.frame.size.width/2, floor(self.frame.size.height/4));
    }
    if(direction == PieceDirectionEast) {
        self.curvedOuterView.frame = CGRectMake(floor(self.frame.size.width/4), floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height);
        self.curvedInnerView.frame = CGRectMake(floor(self.frame.size.width/4) + self.frame.size.width/2, floor(self.frame.size.height/4) + self.frame.size.height/2, self.frame.size.width/2, self.frame.size.height/2);
    }
    
    if(direction == PieceDirectionSouth) {
        self.curvedOuterView.frame = CGRectMake(-self.frame.size.width/2 + floor(self.frame.size.width/4), floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height);
        self.curvedInnerView.frame = CGRectMake(0, floor(self.frame.size.width/4) + self.frame.size.width/2, floor(self.frame.size.width/4), self.frame.size.width/2);
    }
    
    if(direction == PieceDirectionWest) {
        self.curvedOuterView.frame = CGRectMake(-self.frame.size.width/2 + floor(self.frame.size.width/4), -self.frame.size.height/2 + floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height);
        self.curvedInnerView.frame =CGRectMake(0, 0, floor(self.frame.size.width/4), floor(self.frame.size.height/4));
    }

}

-(void)undoCurvedFrame:(CGRect)frame direction:(PieceDirection)direction {
    if(direction == PieceDirectionNorth){
        self.curvedOuterView.frame = CGRectMake(-self.frame.size.width/2 + floor(self.frame.size.width/4), -self.frame.size.height/2 + floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height);
        self.curvedInnerView.frame =CGRectMake(0, 0, floor(self.frame.size.width/4), floor(self.frame.size.height/4));
    }
    if(direction == PieceDirectionEast) {
        self.curvedOuterView.frame = CGRectMake(floor(self.frame.size.width/4), -self.bounds.size.height/2 + floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height);
        self.curvedInnerView.frame = CGRectMake(floor(self.frame.size.width/4) + self.frame.size.width/2, 0, self.frame.size.width/2, floor(self.frame.size.height/4)); //east
    }
    
    if(direction == PieceDirectionSouth) {
        self.curvedOuterView.frame = CGRectMake(floor(self.frame.size.width/4), floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height);
        self.curvedInnerView.frame = CGRectMake(floor(self.frame.size.width/4) + self.frame.size.width/2, floor(self.frame.size.height/4) + self.frame.size.height/2, self.frame.size.width/2, self.frame.size.height/2); //south
    }
    
    if(direction == PieceDirectionWest) {
        self.curvedOuterView.frame = CGRectMake(-self.frame.size.width/2 + floor(self.frame.size.width/4), floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height);
        self.curvedInnerView.frame = CGRectMake(0, floor(self.frame.size.width/4) + self.frame.size.width/2, floor(self.frame.size.width/4), self.frame.size.width/2); //west

    }

}

-(void)undoRotateStraightPiece:(CGRect)frame direction:(PieceDirection)direction {
    [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        [self undoStraigthPiece:frame direction:direction];
    }completion:^(BOOL finished){
    }];

}

-(void)undoStraigthPiece:(CGRect)frame direction:(PieceDirection)direction {
    if(direction == PieceDirectionEast || direction == PieceDirectionWest) //enlarge horizontal
        self.straight.frame = CGRectMake(floor(self.frame.size.width/4), 0, self.frame.size.width/2, self.frame.size.height); 
    else //enlarge vertical
        self.straight.frame = CGRectMake(0, floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height/2);
}

#pragma mark - Methods to add borders when selected

-(void)enlarge {
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1.0f;
}

-(void)shrink {
    self.layer.borderWidth = 0.0f;
}

#pragma mark - logic to determine start and end locations

-(void)rotatePiece {
    if(self.piece == MazePieceCurved) {
        if(self.startDirection == PieceDirectionNorth)
            self.endDirection = PieceDirectionEast;
        else if(self.startDirection == PieceDirectionEast)
            self.endDirection = PieceDirectionSouth;
        else if(self.startDirection == PieceDirectionSouth)
            self.endDirection = PieceDirectionWest;
        else
            self.endDirection = PieceDirectionNorth;
    }
    if(self.piece == MazePieceStraight) {
        if(self.startDirection == PieceDirectionNorth)
            self.endDirection = PieceDirectionSouth;
        else if(self.startDirection == PieceDirectionEast)
            self.endDirection = PieceDirectionWest;
        else if(self.startDirection == PieceDirectionSouth)
            self.endDirection = PieceDirectionNorth;
        else
            self.endDirection = PieceDirectionEast;
    }
}

-(void)getStraightNewRotation {
    if(self.startDirection == PieceDirectionNorth)
        self.startDirection = PieceDirectionEast;
    else if(self.startDirection == PieceDirectionEast)
        self.startDirection = PieceDirectionSouth;
    else if(self.startDirection == PieceDirectionSouth)
        self.startDirection = PieceDirectionWest;
    else
        self.startDirection = PieceDirectionNorth;
}
@end
