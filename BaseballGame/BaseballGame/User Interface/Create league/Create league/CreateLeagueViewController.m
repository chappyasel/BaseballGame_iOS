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

@property NSMutableArray <BGTeamInfo *> *teams;

@end

@implementation CreateLeagueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.teamsTableView.dataSource = self;
    self.teamsTableView.delegate = self;
    
    self.nameField.text = self.customLeague.name;
    self.teams = [[NSMutableArray alloc] initWithArray:self.customLeague.details.teams.array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    self.customLeague.name = self.nameField.text;
    self.customLeague.details.teams = [[NSOrderedSet alloc] initWithArray:self.teams];
    [self.delegate createLeagueViewControllerWillDismissWithResultLeague:self.customLeague];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.customLeague.details.teams.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.customLeague.details.teams.count == indexPath.row) {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = @"Add new team";
        return cell;
    }
    BGTeamInfo *team = self.teams[indexPath.row];
    static NSString *CellIdentifier = @"CreateTeamCell";
    CreateTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CreateTeamTableViewCell" owner:self options:nil].firstObject;
    }
    cell.nameLabel.text = team.name;
    cell.abbrevLabel.text = team.abbreviation;
    cell.pitchingLabel.text = [NSString stringWithFormat:@"PTH: %@",team.pitchingOverall];
    cell.battingLabel.text = [NSString stringWithFormat:@"BAT: %@",team.battingOverall];
    cell.overallLabel.text = [NSString stringWithFormat:@"%@",team.overall];
    cell.team = team;
    cell.delegate = self;
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.customLeague.details.teams.count) {
        [self.teams addObject:[self createEmptyTeam]];
        [self.teamsTableView reloadData];
    }
}

#pragma mark - teamTableViewCell delegate

- (void)shouldBeginEditingCusomTeam:(BGTeamInfo *)team {
    CreateTeamViewController *vc = [[CreateTeamViewController alloc] init];
    vc.managedObjectContext = self.managedObjectContext;
    vc.customTeam = team;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

/*

- (void)shouldDeleteCustomLeague:(BGLeagueInfo *)league {
    [self.customLeagues removeObject:league];
    [self.managedObjectContext deleteObject:league];
    [self.leagueController saveLeagueController];
    [self.tableView reloadData];
}
 
*/

#pragma mark - teamVC delegate

- (void) createTeamViewControllerWillDismissWithResultTeam: (BGTeamInfo *) team {
    NSLog(@"Dismissed");
}
         
#pragma mark - helper methods
         
- (BGTeamInfo *)createEmptyTeam {
    BGTeamInfo *info = [NSEntityDescription insertNewObjectForEntityForName:@"BGTeamInfo" inManagedObjectContext:self.managedObjectContext];
    info.name = @"Untitled Team";
    info.abbreviation = @"---";
    info.pitchingOverall = @0;
    info.battingOverall = @0;
    info.overall = @0;
    info.league = self.customLeague.details;
    BGTeamDetails *details = [NSEntityDescription insertNewObjectForEntityForName:@"BGTeamDetails" inManagedObjectContext:self.managedObjectContext];
    info.details = details;
    details.info = info;
    return info;
}

@end
