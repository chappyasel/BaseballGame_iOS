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
@property NSMutableArray <BGLeagueInfo *> *customLeagues;
@property int currentYear;

@end

@implementation LeagueSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    self.currentYear = (int)[gregorian component:NSCalendarUnitYear fromDate:NSDate.date];
    [self loadDownloadedYears];
    [self loadCustomLeagues];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:self.selectedLeague.year.intValue-self.currentYear inSection:1] animated:NO scrollPosition:UITableViewScrollPositionNone];
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
    if (section == 0) return self.customLeagues.count + 1;
    return self.currentYear - 1900;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) return @"Custom Leagues";
    return @"All Years";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == self.customLeagues.count) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier3"];
            if (cell == nil) {
                //cell = [[NSBundle mainBundle] loadNibNamed:@"LeagueTableViewCell" owner:self options:nil].firstObject;
                cell = [[UITableViewCell alloc] init];
            }
            cell.textLabel.text = @"New custom league";
            return cell;
        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier2"];
        if (cell == nil) {
            //cell = [[NSBundle mainBundle] loadNibNamed:@"LeagueTableViewCell" owner:self options:nil].firstObject;
            cell = [[UITableViewCell alloc] init];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.customLeagues[indexPath.row].name];
        //cell.textView.text = [NSString stringWithFormat:@"%@",cell.year];
        //cell.leagueController = self.leagueController;
        //cell.managedObjectContext = self.managedObjectContext;
        return cell;
    }
    else {
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
}

- (void)loadDownloadedYears {
    self.downloadedYears = [[NSMutableArray alloc] init];
    for (BGLeagueInfo *info in self.leagueController.leagues)
        [self.downloadedYears addObject:info.year];
}

- (void)loadCustomLeagues {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"BGLeagueInfo" inManagedObjectContext:self.managedObjectContext]];
    
    NSPredicate *hasName = [NSPredicate predicateWithFormat:@"!(name == nil)"];
    [request setPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:@[hasName]]];
    
    //NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"overall" ascending:NO];
    //[request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (array != nil && array.count > 0) {
        self.customLeagues = [[NSMutableArray alloc] initWithArray:array];
    }
    else {
        self.customLeagues = [[NSMutableArray alloc] init];
    }
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == self.customLeagues.count) { //new custom league
            
        }
        else [self.delegate leagueSelectionVCDidChangeSelectedLeague:self.customLeagues[indexPath.row]];
    }
    else {
        NSNumber *year = ((LeagueTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath]).year;
        [self.delegate leagueSelectionVCDidChangeSelectedLeague:[self leagueForYear:year]];
    }
}

#pragma mark - tap recognition

- (IBAction)tappedOutsideModal:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
