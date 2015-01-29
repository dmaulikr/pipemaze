//
//  NavigationViewController.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/28/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate {
    //BOOL rotate = [self.topViewController shouldAutorotate];
    
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations {
    //return [self.topViewController supportedInterfaceOrientations];
    return UIInterfaceOrientationMaskAll;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
