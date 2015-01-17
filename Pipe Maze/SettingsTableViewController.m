//
//  SettingsTableViewController.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/17/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "SettingsTableViewController.h"

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   if(section == 0)
       return 1;
    if(section == 1)
        return 1;
    
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if(section == 2)
        return @"(c) 2015 John Arendt. All rights reserved.";
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(indexPath.section == 1) {
        cell.textLabel.text = @"App Version";
        cell.detailTextLabel.text = @"1.0";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17.0];
        cell.detailTextLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17.0];
    }
    
    if(indexPath.section == 0) {
        cell.textLabel.text = nil;
        cell.detailTextLabel.text = nil;
        UIButton *button = [[UIButton alloc] initWithFrame:cell.bounds];
        [button setTitle:@"Restore Levels" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:1 green:0.252 blue:0.212 alpha:1] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17.0];
        [button addTarget:self action:@selector(restoreLevels) forControlEvents:UIControlEventTouchUpInside];
        
        [cell addSubview:button];
    }
    
    if(indexPath.section == 2) {
        cell.textLabel.text = nil;
        cell.detailTextLabel.text = nil;
        NSArray *arr = @[@"Contact the Developer", @"Report a bug"];
        UIButton *button = [[UIButton alloc] initWithFrame:cell.bounds];
        [button setTitle:arr[indexPath.row] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0 green:0.455 blue:0.851 alpha:1] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:17.0];
        [button addTarget:self action:@selector(contact:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
    }
    return cell;
}

-(void)contact:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        UIButton *button = sender;
        
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:button.titleLabel.text];
        //[mail setMessageBody:@"Here is some main text in the email!" isHTML:NO];
        [mail setToRecipients:@[@"jack.arendt1993@gmail.com"]];
        
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
    NSLog(@"%li", (long)buttonIndex);
    if(buttonIndex == 0)
        [self removeAllLevelData];
}

-(void)removeAllLevelData {
    //need to fix
}

@end
