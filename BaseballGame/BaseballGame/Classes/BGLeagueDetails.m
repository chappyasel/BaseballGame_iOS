//
//  BGLeagueDetails.m
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "BGLeagueDetails.h"
#import "BGLeagueInfo.h"
#import "BGTeamInfo.h"
#import "BGTeamDetails.h"

@implementation BGLeagueDetails

- (void)loadCurrentRosterFromBBRForYear: (int) year context: (NSManagedObjectContext *) context WithProgressBlock:(void (^)(float progress))progress {
    self.teams = [[NSOrderedSet alloc] init];
    NSArray *abbrevs = @[@"BAL", @"ARI", @"BOS", @"ATL", @"CHW", @"CHC", @"CLE", @"CIN", @"DET", @"COL", @"HOU", @"LAD",@"KCR", @"MIA", @"LAA", @"MIL", @"MIN", @"NYM", @"NYY", @"PHI", @"OAK", @"PIT", @"SEA", @"SDP", @"TBR", @"SFG", @"TEX", @"STL", @"TOR", @"WSN"];
    NSArray *names = @[@"Baltimore Orioles", @"Arizona Diamondbacks", @"Boston Red Sox", @"Atlanta Braves", @"Chicago White Sox", @"Chicago Cubs", @"Cleveland Indians", @"Cincinnati Reds", @"Detroit Tigers", @"Colorado Rockies", @"Houston Astros", @"Los Angeles Dodgers", @"Kansas City Royals", @"Miami Marlins", @"Los Angeles Angels", @"Milwaukee Brewers", @"Minnesota Twins", @"New York Mets", @"New York Yankees", @"Piladelphia Phillies", @"Oakland Athletics", @"Pittsburgh Pirates", @"Seattle Mariners", @"San Diego Padres", @"Tampa Bay Rays", @"San Francisco Giants", @"Texas Rangers", @"St. Louis Cardinals", @"Toronto Blue Jays", @"Washington Nationals"];
    for (int i = 0; i < abbrevs.count; i++) {
        @autoreleasepool {
            BGTeamInfo *info = [NSEntityDescription insertNewObjectForEntityForName:@"BGTeamInfo" inManagedObjectContext:context];
            info.abbreviation = abbrevs[i];
            info.name = names[i];
            info.league = self;
            BGTeamDetails *details = [NSEntityDescription insertNewObjectForEntityForName:@"BGTeamDetails" inManagedObjectContext:context];
            [details loadTeamWithAbbrev: abbrevs[i] year: year context: context];
            info.details = details;
            details.info = info;
            
            [self addTeamsObject:info];
            
            progress((i+1)/(float)abbrevs.count);
        }
    }
    NSLog(@"finished loading all teams");
}

- (void)addTeamsObject:(BGTeamInfo *)value {
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.teams];
    [tempSet addObject:value];
    self.teams = tempSet;
}

@end
