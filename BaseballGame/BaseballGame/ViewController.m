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
#import "ZFModalTransitionAnimator.h"

#import "BGLeagueController.h"

#import "BGLeagueInfo.h"
#import "BGLeagueDetails.h"

#import "BGTeamInfo.h"
#import "BGTeamDetails.h"

#import "BGPitcher.h"
#import "BGBatter.h"

@interface ViewController ()

@property UCZProgressView *progressView;
@property (nonatomic, strong) ZFModalTransitionAnimator *animator;

@property BGLeagueController *leagueController;
@property NSArray *searchResults;

@property BGLeagueInfo *currentLeague;

@end

@implementation ViewController

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
            self.leagueController = [NSEntityDescription insertNewObjectForEntityForName:@"BGLeagueController" inManagedObjectContext:self.managedObjectContext];
        }
        else {
            if (fetchedObjects.count > 1) NSLog(@"Error: more than 1 league controller");
            self.leagueController = fetchedObjects.firstObject;
        }
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target: self action:@selector(editButtonPressed:)];
    self.navigationController.navigationBar.translucent = NO;
    [self loadTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    //[leagueController deleteAllLeaguesWithContext:self.managedObjectContext];
    //[self loadCurrentLeague];
    if (!self.leagueController.leagues || self.leagueController.leagues.count == 0) [self loadCurrentLeague];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)loadCurrentLeague {
    self.progressView = [[UCZProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.progressView.center = self.view.center;
    self.progressView.radius = 60.0;
    self.progressView.textSize = 25.0;
    self.progressView.showsText = YES;
    [self.view addSubview:self.progressView];
    
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    int year = (int)[gregorian component:NSCalendarUnitYear fromDate:NSDate.date];
    [self.leagueController loadLeagueForYear:year context:self.managedObjectContext WithProgressBlock:^(float progress) {
        self.progressView.progress = progress;
        if (progress > .99) [self performSelector:@selector(loadTableView) withObject:nil afterDelay:1.0];
    }];
}

- (void)loadTableView {
    self.currentLeague = self.leagueController.leagues[0];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection = NO;
    [self.view addSubview:self.tableView];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.scopeButtonTitles = @[@"Batters", @"Pitchers"];
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.barTintColor = [UIColor colorWithWhite:.95 alpha:1];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.placeholder = @"Search by first name or last name";
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    self.title = [NSString stringWithFormat:@"Player Dictionary: %@",self.currentLeague.year];
    if (self.searchResults) return 1;
    return self.currentLeague.details.teams.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchResults) return self.searchResults.count;
    BGTeamDetails *details = self.currentLeague.details.teams[section].details;
    int len = (int)details.pitchers.count + (int)details.batters.count;
    return len;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.searchResults != nil) return nil;
    BGTeamInfo *info = self.currentLeague.details.teams[section];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    header.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 250, 30)];
    label.text = [NSString stringWithFormat:@"%@ (%@)",info.name,info.abbreviation];
    [header addSubview:label];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(header.frame.size.width-100, 0, 90, 30)];
    label2.text = [NSString stringWithFormat:@"Overall: %@",info.overall];
    label2.textAlignment = NSTextAlignmentRight;
    [header addSubview:label2];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PlayerTableViewCell" owner:self options:nil].firstObject;
    }
    if (self.searchResults) [cell loadPlayer:self.searchResults[indexPath.row]];
    else {
        int len = (int)self.currentLeague.details.teams[indexPath.section].details.batters.count;
        if (indexPath.row < len) {
            BGBatter *batter= self.currentLeague.details.teams[indexPath.section].details.batters[indexPath.row];
            [cell loadPlayer:batter];
        }
        else {
            BGPitcher *pitcher = self.currentLeague.details.teams[indexPath.section].details.pitchers[indexPath.row-len];
            [cell loadPlayer:pitcher];
        }
    }
    cell.delegate = self;
    return cell;
}

#pragma mark - searchController methods

- (void)searchForText: (NSString *) string scope: (NSInteger) index {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSString *searchString = (index == 0) ? @"BGBatter" : @"BGPitcher";
    
    [request setEntity:[NSEntityDescription entityForName:searchString inManagedObjectContext:self.managedObjectContext]];
    
    if (string.length == 0) {
        NSPredicate *league = [NSPredicate predicateWithFormat:@"team.info.league.info.year == %@",self.currentLeague.year];
        [request setPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:@[league]]];
    }
    else {
        NSPredicate *lName = [NSPredicate predicateWithFormat:@"lastName CONTAINS %@", string];
        NSPredicate *fName = [NSPredicate predicateWithFormat:@"firstName CONTAINS %@", string];
        NSCompoundPredicate *compound = [NSCompoundPredicate orPredicateWithSubpredicates:@[fName, lName]];
        NSPredicate *league = [NSPredicate predicateWithFormat:@"team.info.league.info.year == %@",self.currentLeague.year];
        [request setPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:@[compound, league]]];
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"overall" ascending:NO];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (array != nil && array.count > 0) {
        self.searchResults = array;
    }
    else {
        self.searchResults = nil; //TEMPORARY (NO RESULTS)
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    CGRect searchBarFrame = self.searchController.searchBar.frame;
    [self.tableView scrollRectToVisible:searchBarFrame animated:NO];
    
    NSString *searchString = searchController.searchBar.text;
    [self searchForText:searchString scope:searchController.searchBar.selectedScopeButtonIndex];
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark - searchBar delegate mathods

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    self.searchResults = nil;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

#pragma mark - modal presentation

- (void)editButtonPressed: (UIBarButtonItem *) sender {
    LeagueSelectionViewController *modalVC = [[LeagueSelectionViewController alloc] init];
    modalVC.delegate = self;
    modalVC.managedObjectContext = self.managedObjectContext;
    modalVC.leagueController = self.leagueController;
    modalVC.selectedYear = self.currentLeague.year;
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    self.animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:modalVC];
    self.animator.dragable = YES;
    self.animator.bounces = YES;
    self.animator.behindViewAlpha = 0.6;
    self.animator.behindViewScale = 0.95;
    self.animator.transitionDuration = 0.5;
    self.animator.direction = ZFModalTransitonDirectionBottom;
    [self.animator setContentScrollView:modalVC.tableView];
    modalVC.transitioningDelegate = self.animator;
    [self presentViewController:modalVC animated:YES completion:nil];
}

#pragma mark - LeagueSelectionViewController delegate methods

- (void)leagueSelectionVCDidChangeSelectedLeague:(BGLeagueInfo *)league {
    self.currentLeague = league;
    [self.tableView reloadData];
}

@end
