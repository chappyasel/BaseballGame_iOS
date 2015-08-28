//
//  BGTeam.m
//  BaseballGame
//
//  Created by Chappy Asel on 8/14/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "BGTeam.h"

@implementation BGTeam

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"BGTeam";
}

- (instancetype) initWithAbbreviation: (NSString *) abbrev {
    if (self = [super init]) {
        NSArray *abbrevs = @[@"BAL", @"ARI", @"BOS", @"ATL", @"CHW", @"CHC", @"CLE", @"CIN", @"DET", @"COL", @"HOU", @"LAD", @"KCR", @"MIA", @"LAA", @"MIL", @"MIN", @"NYM", @"NYY", @"PHI", @"OAK", @"PIT", @"SEA", @"SDP", @"TBR", @"SFG", @"TEX", @"STL", @"TOR", @"WSN"];
        NSArray *names = @[@"Baltimore Orioles", @"Arizona Diamondbacks", @"Boston Red Sox", @"Atlanta Braves", @"Chicago White Sox", @"Chicago Cubs", @"Cleveland Indians", @"Cincinnati Reds", @"Detroit Tigers", @"Colorado Rockies", @"Houston Astros", @"Los Angeles Dodgers", @"Kansas City Royals", @"Miami Marlins", @"Los Angeles Angels", @"Milwaukee Brewers", @"Minnesota Twins", @"New York Mets", @"New York Yankees", @"Piladelphia Phillies", @"Oakland Athletics", @"Pittsburgh Pirates", @"Seattle Mariners", @"San Diego Padres", @"Tampa Bay Rays", @"San Francisco Giants", @"Texas Rangers", @"St. Louis Cardinals", @"Toronto Blue Jays", @"Washington Nationals"];
        self.abbreviation = abbrev;
        if ([names containsObject:abbrev]) self.name = names[(int)[abbrevs indexOfObject:abbrev]];
    }
    return self;
}

@end
