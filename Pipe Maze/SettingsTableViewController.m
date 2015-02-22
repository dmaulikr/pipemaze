//
//  SettingsTableViewController.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/17/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "WorldDAO.h"

#define kRestoreSection 0
#define kAppVersionTutorialSection 1
#define kLikeSection 2
#define kContactSection 3

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Settings";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   if(section == kRestoreSection)
       return 1;
    if(section == kAppVersionTutorialSection)
        return 3;
    
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if(section == 4)
        return @"(c) 2015 John Arendt. All rights reserved.";
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(indexPath.section == kRestoreSection) {
        [self createRestoreCell:cell];
    }
    if(indexPath.section == kAppVersionTutorialSection) {
        if(indexPath.row == 0) {
            [self createAppVersionCell:cell];
        }
        if(indexPath.row == 1) {
            [self createTutorialCell:cell];
        }
        if(indexPath.row == 2) {
            [self createAppReviewCell:cell];
        }
    }
    if(indexPath.section == kLikeSection) {
        [self createLikeCell:cell indexPath:indexPath];
    }
    if(indexPath.section == kContactSection) {
        [self createContactCell:cell indexPath:indexPath];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == kLikeSection){
        NSArray *urls = @[@"http://www.facebook.com/pipemazegame", @"http://www.twitter.com/pipemazegame"];
        NSURL *url = [NSURL URLWithString:urls[indexPath.row]];
        if(indexPath.row == 0) {
            if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://profile/359913157544722"]]){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://profile/359913157544722"]];
            }
            else {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
        if(indexPath.row == 1) {
            if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=pipemazegame"]]){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=pipemazegame"]];
            }
            else {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
    
    if(indexPath.section == kAppVersionTutorialSection && indexPath.row == 1) {
        [self performSegueWithIdentifier:@"toTutorials" sender:self];
    }
    
    if(indexPath.section == kAppVersionTutorialSection && indexPath.row == 2) {
//        NSString *str = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?";
//        // Here is the app id from itunesconnect
//        str = [NSString stringWithFormat:@"%@961382659", str];
//        NSString *str = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=John+Arendt&id=961382659";
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.1) {
//            str = @"itms-apps://itunes.apple.com/app/id961";
//        }
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=961382659"]];
    }
}


#pragma mark - Row Actions
-(void)contact:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        UIButton *button = sender;
        
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:button.titleLabel.text];
        [mail setToRecipients:@[@"pipemazegame@gmail.com"]];
        
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"This device cannot send mail" delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles:nil] show];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - restore level methods

-(void)restoreLevels {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Restore All Levels?" message:@"This cannot be undone" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0)
        [self removeAllLevelData];
}

-(void)removeAllLevelData {
    WorldDAO *worldDA0 = [WorldDAO sharedDAOSession];
    [worldDA0 resetAllLevels];
}


#pragma mark - Cell Creation Helpers

-(void)createRestoreCell:(UITableViewCell *)cell {
    cell.textLabel.text = nil;
    cell.detailTextLabel.text = nil;
    UIButton *button = [[UIButton alloc] initWithFrame:cell.bounds];
    [button setTitle:@"Restore Levels" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:1 green:0.252 blue:0.212 alpha:1] forState:UIControlStateNormal];
    [button setBackgroundImage:[PMConstants imageWithColor:[UIColor colorWithWhite:0.85 alpha:0.9]] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont fontWithName:kFontName size:17.0];
    [button addTarget:self action:@selector(restoreLevels) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:button];
}

-(void)createLikeCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    NSArray *arr = @[@"Like us on Facebook", @"Follow us on Twitter"];
    NSArray *images = @[[UIImage imageNamed:@"facebook"], [UIImage imageNamed:@"twitter"]];
    cell.textLabel.text = arr[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:kFontName size:17.0];
    cell.imageView.image = images[indexPath.row];
    cell.detailTextLabel.text = nil;
}

-(void)createContactCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = nil;
    cell.detailTextLabel.text = nil;
    NSArray *arr = @[@"Contact the Developer", @"Report a bug"];
    UIButton *button = [[UIButton alloc] initWithFrame:cell.bounds];
    [button setTitle:arr[indexPath.row] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0 green:0.455 blue:0.851 alpha:1] forState:UIControlStateNormal];
    [button setBackgroundImage:[PMConstants imageWithColor:[UIColor colorWithWhite:0.85 alpha:0.9]] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont fontWithName:kFontName size:17.0];
    [button addTarget:self action:@selector(contact:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:button];
    
}

-(void)createAppVersionCell:(UITableViewCell *)cell {
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    NSString *build = infoDictionary[(NSString*)kCFBundleVersionKey];
    NSString *version = infoDictionary[@"CFBundleShortVersionString"];
    
    cell.textLabel.text = @"App Version";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@)", version, build];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:kFontName size:17.0];
    cell.detailTextLabel.font = [UIFont fontWithName:kFontName size:17.0];
}

-(void)createTutorialCell:(UITableViewCell *)cell {
    cell.textLabel.text = @"Tutorial";
    cell.textLabel.font = [UIFont fontWithName:kFontName size:17.0];
    cell.detailTextLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

-(void)createAppReviewCell:(UITableViewCell *)cell {
    cell.textLabel.text = @"Rate On App Store";
    cell.textLabel.font = [UIFont fontWithName:kFontName size:17.0];
    cell.detailTextLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}


@end
