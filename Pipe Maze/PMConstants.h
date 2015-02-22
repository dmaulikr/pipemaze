//
//  PMConstants.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/15/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PMConstants : NSObject

#define mark - utility classes

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIColor *)getPipeColor;
+ (UIColor *)getBlockColor;
+ (UIColor *)getNavyFontColor;
+ (UIColor *)getFacebookBlue;
+ (UIColor *)getTwitterBlue;
+ (UIColor *)getGrayBackgroundColor;

#pragma mark - enums

enum {
    MazePieceStraight = 2,
    MazePieceCorner = 1,
    MazePieceBlock = 0,
    MazePieceEmpty = 3
    
} typedef MazePieces;

enum {
    PieceDirectionNorth = 0,
    PieceDirectionEast = 1,
    PieceDirectionSouth = 2,
    PieceDirectionWest = 3,
    PieceDirectionNone = 4
} typedef PieceDirection;

enum {
    StatisticTypeChart,
    StatisticTypeText
} typedef StatisticType;


#pragma mark - constants

extern NSString *const kFontName;

extern NSString *const kUserProfilePicture;
extern NSString *const kUserProfileFirstName;
extern NSString *const kUserProfileLastName;
extern NSString *const kUserProfileTitle;
extern NSString *const kUserFacebookLoggedIn;
extern NSString *const kTwitterUserLoggedIn;



@end
