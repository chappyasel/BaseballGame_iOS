//
//  ViewController.m
//  BaseballGame
//
//  Created by Chappy Asel on 8/14/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "UCZProgressView.h"

#import "BGLeagueController.h"

#import "BGLeagueInfo.h"
#import "BGLeagueDetails.h"

@interface ViewController ()

@end

@implementation ViewController

BGLeagueController *leagueController;
UCZProgressView *progressView;

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BGLeagueController" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) NSLog(@"Error: %@",error);
    else {
        if (fetchedObjects.count == 0) {
            NSLog(@"Error: no league controller");
            leagueController = [NSEntityDescription insertNewObjectForEntityForName:@"BGLeagueController" inManagedObjectContext:self.managedObjectContext];
        }
        else {
            if (fetchedObjects.count > 1) NSLog(@"Error: more than 1 league controller");
            leagueController = fetchedObjects.firstObject;
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    if (leagueController.leagues.count == 0) {
        progressView = [[UCZProgressView alloc] initWithFrame:CGRectMake(0, 0, 130, 130)];
        progressView.center = self.view.center;
        progressView.radius = 60.0;
        progressView.textSize = 25.0;
        progressView.showsText = YES;
        [self.view addSubview:progressView];
        
        NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        int year = (int)[gregorian component:NSCalendarUnitYear fromDate:NSDate.date];
        BGLeagueInfo *info = [NSEntityDescription insertNewObjectForEntityForName:@"BGLeagueInfo" inManagedObjectContext:self.managedObjectContext];
        info.year = [NSNumber numberWithInt:year];
        info.isCustom = [NSNumber numberWithBool:NO];
        BGLeagueDetails *details = [NSEntityDescription insertNewObjectForEntityForName:@"BGLeagueDetails" inManagedObjectContext:self.managedObjectContext];
        dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
        dispatch_async(myQueue, ^{
            [details loadCurrentRosterFromBBRForYear:year context:self.managedObjectContext WithProgressBlock:^(float progress) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    progressView.progress = progress;
                });
            }];
            info.details = details;
            details.info = info;
            [leagueController addLeaguesObject:info];
            
            NSError *error;
            if (![leagueController.managedObjectContext save:&error]) {
                NSLog(@"Couldn't save: %@", [error localizedDescription]);
            }
            else NSLog(@"leagueController saved");
        });
    }
    [self loadTableView];
}

- (void)loadTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
