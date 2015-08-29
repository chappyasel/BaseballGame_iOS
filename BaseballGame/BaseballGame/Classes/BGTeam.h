//
//  BGTeam.h
//  BaseballGame
//
//  Created by Chappy Asel on 8/14/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGBatter.h"
#import "BGPitcher.h"

@interface BGTeam : PFObject <PFSubclassing>
+ (NSString *)parseClassName;

@property NSString *name;
@property NSString *abbreviation;
@property int year;

@property (nonatomic, strong) NSMutableArray <BGBatter *> *batters;
@property (nonatomic, strong) NSMutableArray <BGPitcher *> *pitchers;

- (void) loadTeamFromAbbreviation: (NSString *) abbrev;

- (void) addBatter: (BGBatter *) batter;

- (void) addPitcher: (BGPitcher *) pitcher;

@end
