//
//  BGLeagueDetails.m
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "BGLeagueDetails.h"
#import "BGLeagueInfo.h"

@implementation BGLeagueDetails

- (void)loadCurrentRosterFromBBRWithProgressBlock:(void (^)(float progress))progress {
    self.teams = [[NSMutableArray alloc] init];
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    int year = (int)[gregorian component:NSCalendarUnitYear fromDate:NSDate.date];
    NSArray *abbrevs = @[@"BAL", @"ARI", @"BOS", @"ATL", @"CHW", @"CHC", @"CLE", @"CIN", @"DET", @"COL", @"HOU", @"LAD",@"KCR", @"MIA", @"LAA", @"MIL", @"MIN", @"NYM", @"NYY", @"PHI", @"OAK", @"PIT", @"SEA", @"SDP", @"TBR", @"SFG", @"TEX", @"STL", @"TOR", @"WSN"];
    for (int i = 0; i < abbrevs.count; i++) {
        @autoreleasepool {
            [self loadTeamWithAbbrev:abbrevs[i] andYear:[NSNumber numberWithInt:year]];
            progress(((float)i+1)/abbrevs.count);
        }
    }
    NSLog(@"finished loading all teams");
}

@end
