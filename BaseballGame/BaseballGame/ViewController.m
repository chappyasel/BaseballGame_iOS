//
//  ViewController.m
//  BaseballGame
//
//  Created by Chappy Asel on 8/14/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "ViewController.h"
#import "UCZProgressView.h"
#import "BGRosterController.h"

@interface ViewController ()

@end

@implementation ViewController

BGRosterController *rosterController;
UCZProgressView *progressView;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    progressView = [[UCZProgressView alloc] initWithFrame:CGRectMake(0, 0, 130, 130)];
    progressView.center = self.view.center;
    progressView.radius = 60.0;
    progressView.textSize = 25.0;
    progressView.showsText = YES;
    [self.view addSubview:progressView];
    
    //[PFObject unpinAllObjectsWithName:@"RC"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"BGRosterController"];
    //[query fromLocalDatastore];
    NSError *error;
    NSArray *results = [query findObjects];
    BGRosterController *localRC = (BGRosterController *)[query getFirstObject:&error];
    if (error) NSLog(@"%@",error);
    rosterController = [BGRosterController sharedInstance];
    if (localRC) {
        rosterController = localRC;
        [self loadTableView];
    }
    else {
        rosterController = [BGRosterController object];
        dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
        dispatch_async(myQueue, ^{
            [rosterController loadCurrentRosterFromBBRWithProgressBlock:^void(float progress) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    progressView.progress = progress;
                });
            }];
            [rosterController saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (error) NSLog(@"%@",error);
                if (succeeded) NSLog(@"SAVED ROSTER CONTROLLER");
            }];
            [self loadTableView];
        });
    }
}

- (void)loadTableView {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
