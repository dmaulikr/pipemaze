//
//  LevelViewController.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/17/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "LevelViewController.h"
#import "LevelTableViewCell.h"
#import "WorldDAO.h"
#import "World.h"
#import "MazeViewController.h"
#import "LevelParser.h"
#import "TutorialViewController.h"

#define firstVisit @"firstVisit"
#define firstVisit11 @"firstVisit11"

@interface LevelViewController (){
    NSInteger sections; //number of sections in table view
    BOOL transition; //variable to tell if the view is transitioning from one view to another
    WorldDAO *worldDA0; //object used to get core data
    ADBannerView *_bannerView; //banner view at the bottom of the view
    BOOL _bannerIsVisible; //boolean to tell whether the banner is visible or not
    BOOL firstLoad; //boolean to tell if this is the first time the view is loaded (app start)
    BOOL adShown; //boolean to tell if a full screen ad has been shown before
    BOOL newTutorial;
}

@end

@implementation LevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    worldDA0 = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).worldDAO;
    ADInterstitialAd *ad = [[ADInterstitialAd alloc] init];
    ad.delegate = self;
    self.interstitialPresentationPolicy = ADInterstitialPresentationPolicyAutomatic;
    
    sections = [worldDA0 getNumberOfWorlds]; //get the number of sections
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"Pipeline"; //set tint color and title
    
    [worldDA0 normalizeStars]; //normalizes the stars in case i change the times
    
    _bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50)];
    _bannerView.delegate = self;
    self.canDisplayBannerAds = YES; //set up banner ad at the bototm of subview
    
    firstLoad = YES; //says that it is app startup
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger seen = [userDefaults integerForKey:firstVisit]; //get variable to determine if the app has been opened before
    
    if(seen == 0) { //if not, show an alert prompting them to look at a tutorial
        [userDefaults setInteger:1 forKey:firstVisit];
        [userDefaults setInteger:1 forKey:firstVisit11]; //first visit, don't need to show whats new.
        [userDefaults synchronize];
        newTutorial = NO;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"I see this is your first time playing the game" message:@"Check out a tour of the game before starting" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
        [alertView show];
    }
    NSInteger seen11 = [userDefaults integerForKey:firstVisit11];
    if(seen11 == 0) {
        [userDefaults setInteger:1 forKey:firstVisit11];
        [userDefaults synchronize];
        newTutorial = YES; //only show what's new
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"We've updated a lot of stuff!" message:@"Check it out here" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
        [alertView show];
    }
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    transition = NO;
    adShown = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0 green:0.117 blue:0.251 alpha:1]];
    //set bar color to navy and get the DAO object
    
    BOOL unlocked = false;
    BOOL completed = true;
    //This is in charge of unlocking new levels as they become available
    for(int i = 0; i < [worldDA0 getNumberOfWorlds]; i++) {
        World *world = [worldDA0 getWorldAtIndex:i];
        for(int j = 0; j < world.levels.count; j++) {
            if(unlocked || !completed) //if a new level has been unlocked, break
                break;
            Level *level = [worldDA0 getLevelForWorld:world atIndex:i*12 + j + 1]; //get level
            if(![level.available boolValue]) {
                level.available = [NSNumber numberWithBool:YES];
                [worldDA0 updateLevel:level forWorld:world];
                unlocked = YES; //unlock new level
            }
            else {
                if(level.completed.boolValue)
                    completed = true;
                else
                    completed = false;
            }
        }
        if(unlocked || !completed)
            break;
    }
    
    if(!firstLoad) {
        [self requestInterstitialAdPresentation];
        adShown = YES;
    }
    else {
        adShown = YES;
    }

    [self.tableView reloadData];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    firstLoad = NO; //when the Level View is shown again, it would not be the first time (okay to display full screen ads)
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate {
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

#pragma mark - Ad methods
-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if(banner == _bannerView) {
        if(!_bannerIsVisible) { //animate banner view and put it in the main view at bottom of screen
            if(_bannerView.superview == nil) {
                [self.view addSubview:_bannerView];
            }
            [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
            banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
            
            [UIView commitAnimations];
            _bannerIsVisible = YES;
        }
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if(banner == _bannerView) {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = NO;
    }
}




-(void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    
}

-(void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd {
   
}

-(void)interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd {
   
}

#pragma mark - IBActions
- (IBAction)showSettings:(id)sender {
    [self performSegueWithIdentifier:@"toSettings" sender:self];
}


#pragma mark - tableview delegate and data source methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [worldDA0 getNumberOfWorlds];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    World *world = [worldDA0 getWorldAtIndex:indexPath.section];
    Level *level = [worldDA0 getLevelForWorld:world atIndex:indexPath.section * 12 + indexPath.row + 1];
    if(!cell.levelLabel) {
        cell.levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, cell.bounds.size.width - 160, 30)];
        cell.levelLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:18.0];
        cell.levelLabel.textColor = [UIColor colorWithRed:0 green:0.117 blue:0.251 alpha:1];
        [cell addSubview:cell.levelLabel];
    }
    cell.levelLabel.text = level.levelName;
    CGSize textSize = [[cell.levelLabel text] sizeWithAttributes:@{NSFontAttributeName:[cell.levelLabel font]}];
    CGFloat strikeWidth = textSize.width;
    cell.levelLabel.frame = CGRectMake(30, 10, strikeWidth, 30);
    
    if(!cell.starView) {
        cell.starView = [[StarView alloc] initWithFrame:CGRectMake(cell.bounds.size.width - 160, 25, 100, 30)];
        [cell addSubview:cell.starView];
    }
    [cell.starView updateStars: [level.stars integerValue]];
    
    if(!cell.timeLabel) {
        cell.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 35, cell.bounds.size.width - 160, 30)];
        cell.timeLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:15.0];
        cell.timeLabel.textColor = [UIColor lightGrayColor];
        [cell addSubview:cell.timeLabel];
    }
    
    NSInteger seconds = [level.seconds integerValue];
    NSInteger minutes = seconds/60;
    seconds%=60;
    cell.timeLabel.text = [NSString stringWithFormat:@"%02li:%02li", (long)minutes, (long)seconds];;
    
    if(!cell.lockedImageView) {
        cell.lockedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 25, 20, 20)];
        [cell addSubview:cell.lockedImageView];
    }
    if(![level.available boolValue]) {
        cell.lockedImageView.image = [UIImage imageNamed:@"lock"];
    }
    else {
        cell.lockedImageView.image = nil;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0)
        return nil;
    return @" ";
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if(section == sections - 1)
        return @" \n ";
    else
        return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    World *world = [worldDA0 getWorldAtIndex:indexPath.section];
    Level *level = [worldDA0 getLevelForWorld:world atIndex:indexPath.section*12 + indexPath.row+1];
    if([level.available boolValue])
        [self performSegueWithIdentifier:@"toMaze" sender:indexPath];
}

#pragma mark - navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toTutorial"]){
        TutorialViewController *vc = [segue destinationViewController];
        vc.newSlideShow = newTutorial;
    }
    if([segue.identifier isEqualToString:@"toMaze"]) {
        transition = YES;
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        World *world = [worldDA0 getWorldAtIndex:indexPath.section];
        Level *level = [worldDA0 getLevelForWorld:world atIndex:indexPath.section*12 + indexPath.row+1];
        MazeViewController *maze = [segue destinationViewController];
        maze.world = world;
        maze.level = level;
        LevelParser *parser = [[LevelParser alloc] initWithFilename:level.fileName];
        maze.maze = [parser loadMaze];
    }
}

#pragma mark - alertview delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self performSegueWithIdentifier:@"toTutorial" sender:self];
}





@end
