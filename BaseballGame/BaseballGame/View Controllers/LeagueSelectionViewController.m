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
    self.selectedYear = [NSNumber numberWithInt: self.currentYear];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self loadDownloadedYears];
    [self.tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.delegate leagueSelectionVCWillDismissWithSelectedLeague:[self leagueForYear:self.selectedYear]];
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
    if (cell == nil) cell = [[LeagueTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"Identifier"];
    //cell.delegate = self;
    cell.year = [NSNumber numberWithLong:self.currentYear-indexPath.row];
    cell.isDownloaded = [self.downloadedYears containsObject:cell.year];
    cell.textView.text = [NSString stringWithFormat:@"%@",cell.year];
    return cell;
}

- (void)loadDownloadedYears {
    self.downloadedYears = [[NSMutableArray alloc] init];
    for (BGLeagueInfo *info in self.leagueController.leagues)
        [self.downloadedYears addObject:info.year];
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (![self.downloadedYears containsObject:[NSNumber numberWithInt:self.currentYear-(int)indexPath.row]]) {
        return;
    }
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:self.currentYear - self.selectedYear.intValue inSection:1]];
    [[oldCell viewWithTag:-10] removeFromSuperview];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView *check = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check.png"]];
    check.frame = CGRectMake(14, 14, 16, 16);
    check.tag = -10;
    [cell addSubview:check];
    self.selectedYear = [NSNumber numberWithInt:self.currentYear - (int)indexPath.row];
}

@end
