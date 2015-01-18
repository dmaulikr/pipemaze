//
//  LevelCollectionViewController.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/12/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelView.h"
#import <iAd/iAd.h>

@interface LevelCollectionViewController : UICollectionViewController <UICollectionViewDelegateFlowLayout, ADBannerViewDelegate>

- (IBAction)showStore:(id)sender;
- (IBAction)showSettings:(id)sender;
@end
