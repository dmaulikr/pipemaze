//
//  LevelViewController.h
//  Pipe Maze
//
//  Created by Jack Arendt on 1/17/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface LevelViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ADBannerViewDelegate, UIAlertViewDelegate, ADInterstitialAdDelegate>
- (IBAction)showSettings:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
