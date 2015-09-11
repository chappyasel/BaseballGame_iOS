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
#import "TFHpple.h"

@implementation BGLeagueDetails

- (void)loadCurrentRosterFromBBRForYear: (int) year context: (NSManagedObjectContext *) context WithProgressBlock:(void (^)(float progress))progress {
    self.teams = [[NSOrderedSet alloc] init];
    NSArray *abbrevs = [self teamsForYear:year];
    progress((2)/((float)abbrevs.count+2));
    for (int i = 0; i < abbrevs.count; i++) {
        @autoreleasepool {
            BGTeamInfo *info = [NSEntityDescription insertNewObjectForEntityForName:@"BGTeamInfo" inManagedObjectContext:context];
            info.abbreviation = abbrevs[i];
            info.league = self;
            BGTeamDetails *details = [NSEntityDescription insertNewObjectForEntityForName:@"BGTeamDetails" inManagedObjectContext:context];
            info.details = details;
            details.info = info;
            [details loadTeamWithAbbrev: abbrevs[i] year: year context: context teamNameBlock:^(NSString *name) { info.name = name; }];
            [self addTeamsObject:info];
            progress((i+3)/((float)abbrevs.count+2));
        }
    }
    NSLog(@"finished loading all teams");
}

- (NSArray *)teamsForYear: (int)year {
    NSMutableArray *abbrevs = [[NSMutableArray alloc] init];
    TFHpple *alParser = [[TFHpple alloc] initWithHTMLData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.baseball-reference.com/leagues/AL/%d.shtml",year]]]];
    TFHpple *nlParser = [[TFHpple alloc] initWithHTMLData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.baseball-reference.com/leagues/NL/%d.shtml",year]]]];
    NSArray *leagues = @[((TFHppleElement *)[alParser searchWithXPathQuery:@"//table[@id='teams_standard_batting']/tbody"].firstObject).children,
                         ((TFHppleElement *)[nlParser searchWithXPathQuery:@"//table[@id='teams_standard_batting']/tbody"].firstObject).children];
    for (NSArray *league in leagues) {
        for (int i = 1; i < league.count-2; i += 2) {
            TFHppleElement *team = league[i];
            TFHppleElement *abbrevContainer = ((TFHppleElement *)team.children[1]).firstChild.firstChild;
            [abbrevs addObject:abbrevContainer.content];
        }
    }
    return abbrevs;
}

- (void)addTeamsObject:(BGTeamInfo *)value {
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.teams];
    [tempSet addObject:value];
    self.teams = tempSet;
}

@end
