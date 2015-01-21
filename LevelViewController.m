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

@interface LevelViewController (){
    NSInteger sections;
    BOOL transition;
    WorldDAO *worldDA0;
    ADBannerView *_bannerView;
    BOOL _bannerIsVisible;
}

@end

@implementation LevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    worldDA0 = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).worldDAO;
    sections = [worldDA0 getNumberOfWorlds];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//[UIColor colorWithRed:1 green:0.252 blue:0.212 alpha:1];
    self.navigationItem.title = @"Pipe Maze";
   

    _bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50)];
    _bannerView.delegate = self;
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    transition = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0 green:0.117 blue:0.251 alpha:1]];

//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0 green:0.117 blue:0.251 alpha:1]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if(!_bannerIsVisible) {
        if(_bannerView.superview == nil) {
            [self.view addSubview:_bannerView];
        }
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"%@ - %@", error.description, error.debugDescription);
    [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
    banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
    
    [UIView commitAnimations];
    
    _bannerIsVisible = NO;
}


- (IBAction)showSettings:(id)sender {
    [self performSegueWithIdentifier:@"toSettings" sender:self];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(!cell.levelLabel) {
        cell.levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, cell.bounds.size.width - 160, 30)];
        cell.levelLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:18.0];
        cell.levelLabel.textColor = [UIColor colorWithRed:0 green:0.117 blue:0.251 alpha:1];
        [cell addSubview:cell.levelLabel];
    }
    cell.levelLabel.text = [NSString stringWithFormat:@"Level %li", ((long)indexPath.row + 12*(long)indexPath.section)];
    CGSize textSize = [[cell.levelLabel text] sizeWithAttributes:@{NSFontAttributeName:[cell.levelLabel font]}];
    CGFloat strikeWidth = textSize.width;
    cell.levelLabel.frame = CGRectMake(30, 10, strikeWidth, 30);
    
    if(!cell.starView) {
        cell.starView = [[StarView alloc] initWithFrame:CGRectMake(cell.bounds.size.width - 160, 25, 100, 30)];
        [cell addSubview:cell.starView];
    }
    [cell.starView updateStars: indexPath.row%6];
    
    if(!cell.timeLabel) {
        cell.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 35, cell.bounds.size.width - 160, 30)];
        cell.timeLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:15.0];
        cell.timeLabel.textColor = [UIColor lightGrayColor];
        [cell addSubview:cell.timeLabel];
    }
    
    cell.timeLabel.text = @"00:34";
    
    if(!cell.lockedImageView) {
        cell.lockedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 25, 20, 20)];
        [cell addSubview:cell.lockedImageView];
    }
    if(indexPath.section == 4) {
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
        return @" ";
    else
        return nil;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toMaze"]) {
        transition = YES;
        MazeViewController *maze = [segue destinationViewController];
        maze.world = sender;
        LevelParser *parser = [[LevelParser alloc] initWithFilename:@"level4"];
        maze.maze = [parser loadMaze];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"toMaze" sender:[worldDA0 getWorldAtIndex:indexPath.section]];
}

@end
