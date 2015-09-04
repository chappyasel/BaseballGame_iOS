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

#import "BGTeamInfo.h"
#import "BGTeamDetails.h"

#import "BGPitcher.h"
#import "BGBatter.h"

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
    if (leagueController.leagues.count == 0) [self loadCurrentLeague];
    //[leagueController deleteAllLeaguesWithContext:self.managedObjectContext];
    //[self loadCurrentLeague];
    [self loadTableView];
}

- (void)loadCurrentLeague {
    progressView = [[UCZProgressView alloc] initWithFrame:CGRectMake(0, 0, 130, 130)];
    progressView.center = self.view.center;
    progressView.radius = 60.0;
    progressView.textSize = 25.0;
    progressView.showsText = YES;
    [self.view addSubview:progressView];
    
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    int year = (int)[gregorian component:NSCalendarUnitYear fromDate:NSDate.date];
    [leagueController loadLeagueForYear:year context:self.managedObjectContext WithProgressBlock:^(float progress) {
        progressView.progress = progress;
    }];
}

- (void)loadTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return leagueController.leagues[0].details.teams.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BGTeamDetails *details = leagueController.leagues[0].details.teams[section].details;
    int len = (int)details.pitchers.count + (int)details.batters.count;
    return len;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return leagueController.leagues[0].details.teams[section].name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:MyIdentifier];
    int len = (int)leagueController.leagues[0].details.teams[indexPath.section].details.batters.count;
    if (indexPath.row < len) {
        BGBatter *batter = leagueController.leagues[0].details.teams[indexPath.section].details.batters[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ - %@",batter.firstName, batter.lastName, batter.position];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"  Overall: %@     (%@ %@ %@ %@ %@ %@)",batter.overall,batter.contact,batter.clutch,batter.fielding,batter.power,batter.speed,batter.vision];
    }
    else {
        BGPitcher *pitcher = leagueController.leagues[0].details.teams[indexPath.section].details.pitchers[indexPath.row-len];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ - %@",pitcher.firstName, pitcher.lastName, pitcher.position];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"  Overall: %@     (%@ %@ %@ %@ %@ %@)",pitcher.overall,pitcher.endurance,pitcher.accuracy,pitcher.velocity,pitcher.composure,pitcher.deception,pitcher.unhittable];
    }
    return cell;
}

@end
