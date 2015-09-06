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

@end

@implementation LeagueSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.delegate leagueSelectionVCWillDismissWithSelectedLeague:self.leagueController.leagues[0]];
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leagueController.leagues.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:MyIdentifier];
    cell.delegate = self;
    MGSwipeExpansionSettings *settings = [[MGSwipeExpansionSettings alloc] init];
    settings.buttonIndex = 0;
    settings.threshold = 1.8;
    cell.leftExpansion = settings;
    cell.textLabel.text = @"";
    cell.detailTextLabel.text = @"";
    cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"Details" icon:[UIImage imageNamed:@"check.png"] backgroundColor:[UIColor darkGrayColor]]];
    cell.leftSwipeSettings.transition = MGSwipeTransitionClipCenter;
    return cell;
}

@end
