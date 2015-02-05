//
//  TutorialViewController.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/17/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)goBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *slideShowButton;
- (IBAction)toggleSlideshow:(id)sender;

@property (nonatomic) BOOL newSlideShow;

@end
