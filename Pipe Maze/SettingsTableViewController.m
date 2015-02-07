//
//  SettingsTableViewController.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/17/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "WorldDAO.h"

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
   if(section == 0)
       return 1;
    if(section == 1)
        return 2;
    
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if(section == 4)
        return @"(c) 2015 John Arendt. All rights reserved.";
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(indexPath.section == 1) {
        if(indexPath.row == 0) {
            cell.textLabel.text = @"App Version";
            cell.detailTextLabel.text = @"1.1 (4)";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17.0];
            cell.detailTextLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17.0];
        }
        if(indexPath.row == 1) {
            cell.textLabel.text = @"Tutorial";
            cell.textLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17.0];
            cell.detailTextLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17.0];
            cell.detailTextLabel.text = @"";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 2) {
            cell.textLabel.text = @"Themes";
            cell.textLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17.0];
            cell.detailTextLabel.text = nil;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    if(indexPath.section == 0) {
        cell.textLabel.text = nil;
        cell.detailTextLabel.text = nil;
        UIButton *button = [[UIButton alloc] initWithFrame:cell.bounds];
        [button setTitle:@"Restore Levels" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:1 green:0.252 blue:0.212 alpha:1] forState:UIControlStateNormal];
        [button setBackgroundImage:[PMConstants imageWithColor:[UIColor colorWithWhite:0.85 alpha:0.9]] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17.0];
        [button addTarget:self action:@selector(restoreLevels) forControlEvents:UIControlEventTouchUpInside];
        
        [cell addSubview:button];
    }
    
    if(indexPath.section == 2) {
        NSArray *arr = @[@"Like us on Facebook", @"Follow us on Twitter"];
        NSArray *images = @[[UIImage imageNamed:@"facebook"], [UIImage imageNamed:@"twitter"]];
        cell.textLabel.text = arr[indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17.0];
        cell.imageView.image = images[indexPath.row];
        cell.detailTextLabel.text = nil;
    }
    
    if(indexPath.section == 3) {
        cell.textLabel.text = nil;
        cell.detailTextLabel.text = nil;
        NSArray *arr = @[@"Contact the Developer", @"Report a bug"];
        UIButton *button = [[UIButton alloc] initWithFrame:cell.bounds];
        [button setTitle:arr[indexPath.row] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0 green:0.455 blue:0.851 alpha:1] forState:UIControlStateNormal];
        [button setBackgroundImage:[PMConstants imageWithColor:[UIColor colorWithWhite:0.85 alpha:0.9]] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17.0];
        [button addTarget:self action:@selector(contact:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 2){
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
    
    if(indexPath.section == 1 && indexPath.row == 1) {
        [self performSegueWithIdentifier:@"toTutorials" sender:self];
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

-(void)restoreLevels {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Restore All Levels?" message:@"This cannot be undone" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0)
        [self removeAllLevelData];
}



-(void)removeAllLevelData {
    WorldDAO *worldDA0 = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).worldDAO;
    [worldDA0 resetAllLevels];
}

@end
