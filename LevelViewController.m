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
    
    self.navigationItem.title = @"Pipe Maze";

    _bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50)];
    _bannerView.delegate = self;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    transition = NO;
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
}


- (IBAction)showSettings:(id)sender {
    [self performSegueWithIdentifier:@"toSettings" sender:self];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    World *world = [worldDA0 getWorldAtIndex:indexPath.section];
    UIColor *worldColor = [UIColor colorWithRed:[world.red floatValue] green:[world.green floatValue] blue:[world.blue floatValue] alpha:1];
    
    if(!cell.colorView) {
        cell.colorView = [[UIView alloc] initWithFrame:CGRectMake(15, (cell.bounds.size.height - 30)/2, 30, 30)];
        cell.colorView.layer.cornerRadius = 15;
        cell.colorView.clipsToBounds = YES;
        [cell addSubview:cell.colorView];
    }
    
    cell.colorView.backgroundColor = worldColor;
    
    if(!cell.levelLabel) {
        cell.levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, cell.bounds.size.width - 160, cell.bounds.size.height)];
        cell.levelLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:18.0];
        [cell addSubview:cell.levelLabel];
    }
    cell.levelLabel.text = [NSString stringWithFormat:@"Level %li", ((long)indexPath.row + 12*(long)indexPath.section)];
    
    
    if(!cell.starView) {
        cell.starView = [[StarView alloc] initWithFrame:CGRectMake(cell.bounds.size.width - 160, 12, 100, cell.bounds.size.height-24)];
        [cell addSubview:cell.starView];
    }
    [cell.starView updateStars: indexPath.row%6];
    
    if(!cell.lockedImageView) {
        cell.lockedImageView = [[UIImageView alloc] initWithFrame:cell.colorView.bounds];
        [cell.colorView addSubview:cell.lockedImageView];
    }
    if(indexPath.section == 4) {
        cell.lockedImageView.image = [UIImage imageNamed:@"lock"];
    }
    else
        cell.lockedImageView.image = nil;
    
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSArray *arr = [self.tableView indexPathsForVisibleRows];
    
    
    NSInteger lowest = INT_MAX;
    World *world;
    
    if(arr.count == 0) {
        lowest = 0;
    }
    else {
        for(NSIndexPath *index in arr) {
            if(index.section < lowest) {
                lowest = index.section;
            }
        }
    }
    
    world = [worldDA0 getWorldAtIndex:lowest];
    if(!transition){
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:[world.red floatValue] green:[world.green floatValue] blue:[world.blue floatValue] alpha:1];
    }
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toMaze"]) {
        transition = YES;
        MazeViewController *maze = [segue destinationViewController];
        maze.world = sender;
        LevelParser *parser = [[LevelParser alloc] initWithFilename:@"level1"];
        maze.maze = [parser loadMaze];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"toMaze" sender:[worldDA0 getWorldAtIndex:indexPath.section]];
}

@end
