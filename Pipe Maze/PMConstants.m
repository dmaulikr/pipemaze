//
//  PMConstants.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/15/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "PMConstants.h"

@implementation PMConstants


#pragma mark - utility functions

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIColor *)getBlockColor {
    return [UIColor colorWithRed:0.239 green:0.60 blue:0.439 alpha:1.0];
}

+ (UIColor *)getPipeColor {
    return [UIColor colorWithRed:0.18 green:0.356 blue:0.537 alpha:1.0];
}


#pragma mark - constants

NSString *const kFontName = @"STHeitiTC-Light";

NSString *const kUserProfilePicture = @"kUserProfilePicture";
NSString *const kUserProfileName = @"kUserProfileName";
NSString *const kUserFacebookLoggedIn = @"kUserFacebookLoggedIn";
NSString *const kTwitterUserLoggedIn = @"kUserTwitterLoggedIn";

@end
