//
//  ViewController.m
//  BaseballGame
//
//  Created by Chappy Asel on 8/14/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "ViewController.h"
#import "BGRosterController.h"

@interface ViewController ()

@end

@implementation ViewController

BGRosterController *rosterController;

- (void)viewDidLoad {
    [super viewDidLoad];
    PFQuery *query = [PFQuery queryWithClassName:@"BGRosterController"];
    [query fromLocalDatastore];
    NSError *error;
    BGRosterController *localRC = (BGRosterController *)[query getFirstObject:&error];
    if (error) NSLog(@"%@",error);
    rosterController = [BGRosterController sharedInstance];
    if (localRC) rosterController = localRC;
    else {
        rosterController = [[BGRosterController alloc] init];
        [rosterController loadRosterFromESPN];
        [rosterController pinInBackground];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
