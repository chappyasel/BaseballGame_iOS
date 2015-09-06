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
    int year = (int)(self.currentYear-indexPath.row);
    MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if (cell == nil) cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:@"Identifier"];
    cell.delegate = self;
    MGSwipeExpansionSettings *settings = [[MGSwipeExpansionSettings alloc] init];
    settings.buttonIndex = 0;
    settings.threshold = 1.8;
    cell.leftExpansion = settings;
    cell.textLabel.text = [NSString stringWithFormat:@"      %d", year];
    cell.detailTextLabel.text = @"";
    PKDownloadButton *progressView = [[PKDownloadButton alloc] initWithFrame:CGRectMake(cell.frame.size.width-40, 7, 100, 30)];
    [progressView.downloadedButton setTitle:@"delete" forState:UIControlStateNormal];
    [progressView.downloadedButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [progressView.downloadedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    progressView.stopDownloadButton.tintColor = progressView.downloadedButton.tintColor;
    progressView.stopDownloadButton.filledLineStyleOuter = NO;
    progressView.pendingView.tintColor = progressView.downloadedButton.tintColor;
    progressView.pendingView.spinTime = 3.f;
    progressView.delegate = self;
    [progressView.startDownloadButton setImage:[UIImage imageNamed:@"download_default"] forState:UIControlStateNormal];
    if ([self.downloadedYears containsObject:[NSNumber numberWithInt:year]]) progressView.state = kPKDownloadButtonState_Downloaded;
    progressView.tag = self.currentYear-indexPath.row;
    [cell addSubview:progressView];
    cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"Details" icon:[UIImage imageNamed:@"check.png"] backgroundColor:[UIColor darkGrayColor]]];
    cell.leftSwipeSettings.transition = MGSwipeTransitionClipCenter;
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

#pragma mark - downloadButton delegate

- (void)downloadButtonTapped:(PKDownloadButton *)downloadButton currentState:(PKDownloadButtonState)state {
    if (state == kPKDownloadButtonState_StartDownload) { //start
        downloadButton.state = kPKDownloadButtonState_Pending;
        [self.leagueController loadLeagueForYear:(int)downloadButton.tag context:self.managedObjectContext WithProgressBlock:^(float progress) {
            downloadButton.state = kPKDownloadButtonState_Downloading;
            downloadButton.stopDownloadButton.progress = progress;
            if (progress > .99) {
                downloadButton.state = kPKDownloadButtonState_Downloaded;
                [self.downloadedYears addObject:[NSNumber numberWithInteger:downloadButton.tag]];
            }
        }];
    }
    else if (state == kPKDownloadButtonState_Pending) { //waiting (cancel)
        downloadButton.state = kPKDownloadButtonState_StartDownload;
        
    }
    else if (state == kPKDownloadButtonState_Downloading) { //stopped
        downloadButton.state = kPKDownloadButtonState_StartDownload;
        
    }
    else if (state == kPKDownloadButtonState_Downloaded) { //delete
        downloadButton.state = kPKDownloadButtonState_StartDownload;
        [self.leagueController removeLeagueForYear:(int)downloadButton.tag context:self.managedObjectContext];
        [self.downloadedYears removeObject:[NSNumber numberWithInteger:downloadButton.tag]];
    }
    else NSLog(@"Incorrect downloadButton state");
}

@end
