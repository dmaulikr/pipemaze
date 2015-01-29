//
//  FullScreenAdViewController.m
//  Pipe Maze
//
//  Created by Jack Arendt on 1/28/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

#import "FullScreenAdViewController.h"

@interface FullScreenAdViewController ()

@end

@implementation FullScreenAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ADInterstitialAd *ad = [[ADInterstitialAd alloc] init];
    ad.delegate = self;
    self.interstitialPresentationPolicy = ADInterstitialPresentationPolicyAutomatic;
    [self requestInterstitialAdPresentation];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd {
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
