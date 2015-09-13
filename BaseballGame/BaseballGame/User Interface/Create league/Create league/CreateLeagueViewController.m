//
//  CreateLeagueViewController.m
//  BaseballGame
//
//  Created by Chappy Asel on 9/12/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "CreateLeagueViewController.h"
#import "BGLeagueDetails.h"
#import "BGTeamInfo.h"
#import "BGTeamDetails.h"

@interface CreateLeagueViewController ()

@end

@implementation CreateLeagueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameField.delegate = self;
    self.teamsTableView.dataSource = self;
    self.teamsTableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.createdLeagueInfo.details.teams.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (self.createdLeagueInfo.details.teams.count == indexPath.row) {
        cell.textLabel.text = @"Add new team";
        return cell;
    }
    cell.textLabel.text = @"New team";
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.createdLeagueInfo.details.teams.count) {
        [self.createdLeagueInfo.details addTeamsObject:[self createEmptyTeam]];
        [self.teamsTableView reloadData];
    }
}
         
#pragma mark - helper methods
         
- (BGTeamInfo *)createEmptyTeam {
    BGTeamInfo *info = [NSEntityDescription insertNewObjectForEntityForName:@"BGTeamInfo" inManagedObjectContext:self.managedObjectContext];
    info.league = self.createdLeagueInfo.details;
    BGTeamDetails *details = [NSEntityDescription insertNewObjectForEntityForName:@"BGTeamDetails" inManagedObjectContext:self.managedObjectContext];
    info.details = details;
    details.info = info;
    return info;
}

@end
