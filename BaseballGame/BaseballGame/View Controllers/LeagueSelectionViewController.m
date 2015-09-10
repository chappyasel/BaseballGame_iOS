//
//  LeagueSelectionViewController.m
//  BaseballGame
//
//  Created by Chappy Asel on 9/5/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "LeagueSelectionViewController.h"
#import "BGLeagueInfo.h"
#import "BGLeagueController.h"

@interface LeagueSelectionViewController ()

@property NSMutableArray <NSNumber *> *downloadedYears;
@property int currentYear;

@end

@implementation LeagueSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    self.currentYear = (int)[gregorian component:NSCalendarUnitYear fromDate:NSDate.date];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self loadDownloadedYears];
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:self.selectedYear.intValue-self.currentYear inSection:1] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (BGLeagueInfo *)leagueForYear: (NSNumber *) year {
    for (BGLeagueInfo *info in self.leagueController.leagues) if ([info.year isEqual:year]) return info;
    return nil;
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 0;
    return self.currentYear - 1900;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) return @"Custom";
    return @"Years";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeagueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"LeagueTableViewCell" owner:self options:nil].firstObject;
    }
    cell.year = [NSNumber numberWithLong:self.currentYear-indexPath.row];
    cell.isDownloaded = [self.downloadedYears containsObject:cell.year];
    cell.textView.text = [NSString stringWithFormat:@"%@",cell.year];
    cell.leagueController = self.leagueController;
    cell.managedObjectContext = self.managedObjectContext;
    return cell;
}

- (void)loadDownloadedYears {
    self.downloadedYears = [[NSMutableArray alloc] init];
    for (BGLeagueInfo *info in self.leagueController.leagues)
        [self.downloadedYears addObject:info.year];
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedYear = ((LeagueTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath]).year;
    [self.delegate leagueSelectionVCDidChangeSelectedLeague:[self leagueForYear:self.selectedYear]];
}

#pragma mark - tap recognition

- (IBAction)tappedOutsideModal:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
