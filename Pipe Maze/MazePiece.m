//
//  MazePiece.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/15/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "MazePiece.h"

#define PIECE_ROTATION_TIME 0.15

@interface MazePiece () {
    UIView *xView;
    CGPoint originalTouch;
    CGPoint endTouch;
}

#pragma mark - private variables
@property (nonatomic) CGRect originalFrame;
@property (nonatomic, strong) UIView *cornerOuterView;
@property (nonatomic, strong) UIView *cornerInnerView;

@property (nonatomic, strong) UIView *straight;
@property (nonatomic, strong) UIColor *pipeColor;
@property (nonatomic) BOOL touchMoved;
@property (nonatomic) BOOL longTouch;
@property (nonatomic) BOOL deleteVisible;
@property (nonatomic, strong) UILongPressGestureRecognizer *longGesture;
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
    self.longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longSelected:)];
    self.longGesture.minimumPressDuration = 0.3;
    [self addGestureRecognizer:self.longGesture];
    
    CGSize size = self.frame.size;
    self.pipeColor = [UIColor colorWithRed:0.18 green:0.356 blue:0.537 alpha:1.0];
    
    switch (self.piece) {
        case MazePieceStraight:
            [self createStraightView:size];
            break;
        case MazePieceCorner:
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
        self.cornerOuterView = [[UIView alloc] initWithFrame:CGRectMake(floor(self.frame.size.width/4), -self.bounds.size.height/2 + floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.cornerOuterView];
        
        self.cornerInnerView = [[UIView alloc] initWithFrame:CGRectMake(floor(self.frame.size.width/4) + self.frame.size.width/2, 0, self.frame.size.width/2, floor(self.frame.size.height/4))];
        [self addSubview:self.cornerInnerView];
    }
    
    if(self.startDirection == PieceDirectionEast) {
        self.cornerOuterView = [[UIView alloc] initWithFrame:CGRectMake(floor(self.frame.size.width/4), floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.cornerOuterView];
        
        self.cornerInnerView = [[UIView alloc] initWithFrame:CGRectMake(floor(self.frame.size.width/4) + self.frame.size.width/2, floor(self.frame.size.height/4) + self.frame.size.height/2, self.frame.size.width/2, self.frame.size.height/2)];
        [self addSubview:self.cornerInnerView];
    }
    
    if(self.startDirection == PieceDirectionSouth) {
        self.cornerOuterView = [[UIView alloc] initWithFrame:CGRectMake(-self.frame.size.width/2 + floor(self.frame.size.width/4), floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.cornerOuterView];
        
        self.cornerInnerView = [[UIView alloc] initWithFrame:CGRectMake(0, floor(self.frame.size.width/4) + self.frame.size.width/2, floor(self.frame.size.width/4), self.frame.size.width/2)];
        [self addSubview:self.cornerInnerView];
    }
    
    if(self.startDirection == PieceDirectionWest) {
        self.cornerOuterView = [[UIView alloc] initWithFrame:CGRectMake(-self.frame.size.width/2 + floor(self.frame.size.width/4), -self.frame.size.height/2 + floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.cornerOuterView];
        
        self.cornerInnerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, floor(self.frame.size.width/4), floor(self.frame.size.height/4))];
        [self addSubview:self.cornerInnerView];
    }
    
    self.cornerInnerView.clipsToBounds = YES;
    self.cornerInnerView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    self.cornerOuterView.backgroundColor = self.pipeColor;
    self.cornerOuterView.clipsToBounds = YES;
    self.clipsToBounds = YES;
}

-(void)createBlockView:(CGSize)size {
    self.backgroundColor = [UIColor colorWithRed:0.239 green:0.60 blue:0.439 alpha:1.0];
}

#pragma mark - Touch Recognizers

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if([self.delegate mazePieceCanMove:self]) {
        //self.frame = self.originalFrame;
        [self select];
    }
    [self.delegate mazePieceDidBeginTouching:self];
}

//Shrink back to normal size
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.touchMoved){
        self.touchMoved = NO;
        return;
    }
    
    if([self.delegate mazePieceCanMove:self]) {
        //self.frame = self.originalFrame;
        if(self.piece == MazePieceStraight){
            //needs some fixing
            if([self.delegate mazePieceCanRotate:self]){
                [self rotateStraightPiece:self.frame direction:self.startDirection];
            }
        }
        if(self.piece == MazePieceCorner) {
            if([self.delegate mazePieceCanRotate:self]){
                [self rotateCornerPiece:self.frame direction:self.startDirection];
            }
        }
        [self deselect];
    }
    if(self.delegate) {
        [self.delegate mazePieceDidEndTouching:self];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    self.touchMoved = YES;
    [self deselect];
}

-(void)longSelected:(UIGestureRecognizer *)gesture {
    
    if(![self.delegate mazePieceCanBeLongSelected:self]) {
        return;
    }

    if(gesture.state == UIGestureRecognizerStateEnded && self.longTouch) {
        self.longTouch = NO;
        if(self.delegate) {
            if([self.delegate mazePieceCanBeLongSelected:self]){
                [self deselect];
                [self.delegate mazePieceWasSelected:self];
            }
        }
        
        if(1) { //needs to check if piece was moved
            if(!xView) {
                xView = [[UIView alloc] initWithFrame:self.bounds];
                xView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.7];
                UIButton *button = [[UIButton alloc] initWithFrame:xView.frame];
                [button setTitle:@"X" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:self.bounds.size.height *2/3];
                [button addTarget:self action:@selector(deletePiece) forControlEvents:UIControlEventTouchUpInside];
                [xView addSubview:button];
            }
            self.deleteVisible = YES;
            [self addSubview:xView];
        }
        return;
    }
    else if(gesture.state == UIGestureRecognizerStateBegan && !self.deleteVisible){
        self.longTouch = YES;
        originalTouch = [gesture locationInView:self.superview.superview];
        if(self.delegate) {
            if([self.delegate mazePieceCanBeLongSelected:self]){
                [self select];
            }
        }
    }
    
    else if(gesture.state == UIGestureRecognizerStateEnded && self.deleteVisible) {
        [self deletePiece];
    }
    
    else if(gesture.state == UIGestureRecognizerStateChanged && !self.deleteVisible){
        endTouch = [gesture locationInView:self.superview.superview];
        float x = (originalTouch.x - endTouch.x)*(originalTouch.x - endTouch.x);
        float y = (originalTouch.y - endTouch.y)*(originalTouch.y - endTouch.y);
        float dist = sqrtf(x*x + y*y);
        if(dist > 10000) {
            self.longTouch = NO;
            [self deselect];
        }
        else {
            [self select];
            self.longTouch = YES;
        }
    }
}

-(void)deletePiece {
    if(self.delegate) {
        [self.delegate mazePieceWasDeleted:self];
        [xView removeFromSuperview];
        self.deleteVisible = NO;
    }
}

#pragma mark - Methods for changing the frame/rotation of straight piece
-(void)rotateStraightPiece:(CGRect)frame direction:(PieceDirection)direction {
    //rotate from horizontal to vertical
    [UIView animateKeyframesWithDuration:PIECE_ROTATION_TIME delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        [self getStraightNewRotation];
        [self changeStraightFrame:frame direction:self.startDirection];
    }completion:^(BOOL finished){
        [self rotatePiece];
        if(self.delegate)
            [self.delegate mazePieceDidRotate:self];
    }];

}

-(void)changeStraightFrame:(CGRect)frame direction:(PieceDirection)direction {
    if(direction == PieceDirectionEast || direction == PieceDirectionWest) //enlarge horizontal
        self.straight.frame = CGRectMake(0, floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height/2);
    else //enlarge vertical
        self.straight.frame = CGRectMake(floor(self.frame.size.width/4), 0, self.frame.size.width/2, self.frame.size.height);
}

-(void)undoRotateStraightPiece:(CGRect)frame direction:(PieceDirection)direction {
    [UIView animateKeyframesWithDuration:PIECE_ROTATION_TIME delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
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


#pragma mark - Methods for changing the frame/rotation of corner piece

//rotates corner piece with animation
-(void)rotateCornerPiece:(CGRect)frame direction:(PieceDirection)direction {
    [UIView animateKeyframesWithDuration:PIECE_ROTATION_TIME delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        [self changeCornerFrame:frame direction:self.endDirection];
    }completion:^(BOOL finished){
        self.startDirection = self.endDirection;
        [self rotatePiece];
        if(self.delegate)
           [self.delegate mazePieceDidRotate:self];
    }];
}
//undo rotation of corner piece with animation
-(void)undoRotateCornerPiece:(CGRect)frame direction:(PieceDirection)direction {
    [UIView animateKeyframesWithDuration:PIECE_ROTATION_TIME delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        [self undoCornerFrame:frame direction:direction];
    }completion:^(BOOL finished){
    }];

}

//rotates cw
-(void)changeCornerFrame:(CGRect)frame direction:(PieceDirection)direction{
    if(direction == PieceDirectionNorth){
        self.cornerOuterView.frame = CGRectMake(floor(self.frame.size.width/4), -self.bounds.size.height/2 + floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height);
        self.cornerInnerView.frame = CGRectMake(floor(self.frame.size.width/4) + self.frame.size.width/2, 0, self.frame.size.width/2, floor(self.frame.size.height/4));
    }
    if(direction == PieceDirectionEast) {
        self.cornerOuterView.frame = CGRectMake(floor(self.frame.size.width/4), floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height);
        self.cornerInnerView.frame = CGRectMake(floor(self.frame.size.width/4) + self.frame.size.width/2, floor(self.frame.size.height/4) + self.frame.size.height/2, self.frame.size.width/2, self.frame.size.height/2);
    }
    
    if(direction == PieceDirectionSouth) {
        self.cornerOuterView.frame = CGRectMake(-self.frame.size.width/2 + floor(self.frame.size.width/4), floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height);
        self.cornerInnerView.frame = CGRectMake(0, floor(self.frame.size.width/4) + self.frame.size.width/2, floor(self.frame.size.width/4), self.frame.size.width/2);
    }
    
    if(direction == PieceDirectionWest) {
        self.cornerOuterView.frame = CGRectMake(-self.frame.size.width/2 + floor(self.frame.size.width/4), -self.frame.size.height/2 + floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height);
        self.cornerInnerView.frame =CGRectMake(0, 0, floor(self.frame.size.width/4), floor(self.frame.size.height/4));
    }

}


//Does the above function in reverse (ccw)
-(void)undoCornerFrame:(CGRect)frame direction:(PieceDirection)direction {
    if(direction == PieceDirectionNorth){
        self.cornerOuterView.frame = CGRectMake(-self.frame.size.width/2 + floor(self.frame.size.width/4), -self.frame.size.height/2 + floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height);
        self.cornerInnerView.frame =CGRectMake(0, 0, floor(self.frame.size.width/4), floor(self.frame.size.height/4));
    }
    if(direction == PieceDirectionEast) {
        self.cornerOuterView.frame = CGRectMake(floor(self.frame.size.width/4), -self.bounds.size.height/2 + floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height);
        self.cornerInnerView.frame = CGRectMake(floor(self.frame.size.width/4) + self.frame.size.width/2, 0, self.frame.size.width/2, floor(self.frame.size.height/4)); //east
    }
    
    if(direction == PieceDirectionSouth) {
        self.cornerOuterView.frame = CGRectMake(floor(self.frame.size.width/4), floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height);
        self.cornerInnerView.frame = CGRectMake(floor(self.frame.size.width/4) + self.frame.size.width/2, floor(self.frame.size.height/4) + self.frame.size.height/2, self.frame.size.width/2, self.frame.size.height/2); //south
    }
    
    if(direction == PieceDirectionWest) {
        self.cornerOuterView.frame = CGRectMake(-self.frame.size.width/2 + floor(self.frame.size.width/4), floor(self.frame.size.height/4), self.frame.size.width, self.frame.size.height);
        self.cornerInnerView.frame = CGRectMake(0, floor(self.frame.size.width/4) + self.frame.size.width/2, floor(self.frame.size.width/4), self.frame.size.width/2); //west
    }

}


#pragma mark - Methods to add/remove borders for selection/deselection
-(void)select {
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.layer.borderWidth = 3.0f;
    
}

-(void)deselect {
    if([self.delegate mazePieceCanBeDeselected:self]){
        self.layer.borderWidth = 0.0f;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    [xView removeFromSuperview];
    self.deleteVisible = NO;
}


#pragma mark - logic to determine start and end locations
-(void)rotatePiece {
    if(self.piece == MazePieceCorner) {
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
