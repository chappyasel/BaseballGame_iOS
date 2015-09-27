//
//  CreateTeamViewController.m
//  BaseballGame
//
//  Created by Chappy Asel on 9/26/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "CreateTeamViewController.h"
#import "BGTeamDetails.h"
#import "BGBatter.h"
#import "BGPitcher.h"

@interface CreateTeamViewController ()

@property NSMutableArray <BGBatter *> *batters;
@property NSMutableArray <BGPitcher *> *pitchers;

@end

@implementation CreateTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.nameTextField.text = self.customTeam.name;
    self.abbrevTextField.text = self.customTeam.abbreviation;
    self.batters = [[NSMutableArray alloc] initWithArray:self.customTeam.details.batters.array];
    self.pitchers = [[NSMutableArray alloc] initWithArray:self.customTeam.details.pitchers.array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadExistingTeamPressed:(UIButton *)sender {
    
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    self.customTeam.name = self.nameTextField.text;
    self.customTeam.abbreviation = self.abbrevTextField.text;
    self.customTeam.details.batters = [[NSOrderedSet alloc] initWithArray:self.batters];
    self.customTeam.details.pitchers = [[NSOrderedSet alloc] initWithArray:self.pitchers];
    [self.delegate createTeamViewControllerWillDismissWithResultTeam:self.customTeam];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - tableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return self.batters.count + 1;
    return self.pitchers.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.section == 0 && self.batters.count == indexPath.row) ||
        (indexPath.section == 1 && self.pitchers.count == indexPath.row)) return 44;
    else return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && self.batters.count == indexPath.row) {
        static NSString *CellIdentifier = @"BaCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = @"Add new batter";
        return cell;
    }
    if (indexPath.section == 1 && self.pitchers.count == indexPath.row) {
        static NSString *CellIdentifier = @"PaCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = @"Add new pitcher";
        return cell;
    }
    static NSString *CellIdentifier = @"CreatePlayerCell";
    CreatePlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CreatePlayerTableViewCell" owner:self options:nil].firstObject;
    }
    id player;
    if (indexPath.section == 0) player = self.batters[indexPath.row];
    else player = self.pitchers[indexPath.row];
    [cell loadCustomPlayer:player];
    cell.delegate = self;
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == self.batters.count) {
        [self.batters addObject:[self createEmptyBatter]];
        [self.tableView reloadData];
    }
    else if (indexPath.section == 1 && indexPath.row == self.pitchers.count) {
        [self.pitchers addObject:[self createEmptyPitcher]];
        [self.tableView reloadData];
    }
}

#pragma mark - helper methods

- (BGBatter *)createEmptyBatter {
    BGBatter *batter = [NSEntityDescription insertNewObjectForEntityForName:@"BGBatter" inManagedObjectContext:self.managedObjectContext];
    batter.firstName = @"Untitled";
    batter.lastName = @"Batter";
    batter.team = self.customTeam.details;
    batter.position = @"-";
    batter.contact = @0;
    batter.power = @0;
    batter.speed = @0;
    batter.vision = @0;
    batter.clutch = @0;
    batter.fielding = @0;
    batter.overall = @0;
    return batter;
}

- (BGPitcher *)createEmptyPitcher {
    BGPitcher *pitcher = [NSEntityDescription insertNewObjectForEntityForName:@"BGPitcher" inManagedObjectContext:self.managedObjectContext];
    pitcher.firstName = @"Untitled";
    pitcher.lastName = @"Pitcher";
    pitcher.team = self.customTeam.details;
    pitcher.position = @"-";
    pitcher.unhittable = @0;
    pitcher.deception = @0;
    pitcher.composure = @0;
    pitcher.velocity = @0;
    pitcher.accuracy = @0;
    pitcher.endurance = @0;
    pitcher.overall = @0;
    return pitcher;
}

#pragma mark - teamTableViewCell delegate

/*

- (void)shouldBeginEditingCustomPlayer:(id)player {
    CreateTeamViewController *vc = [[CreateTeamViewController alloc] init];
    vc.managedObjectContext = self.managedObjectContext;
    vc.customPlayer = player;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}
 
 */
 
/*
 
 - (void)shouldDeleteCustomLeague:(BGLeagueInfo *)league {
 [self.customLeagues removeObject:league];
 [self.managedObjectContext deleteObject:league];
 [self.leagueController saveLeagueController];
 [self.tableView reloadData];
 }
 
 */

@end
