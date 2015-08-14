//
//  BGRosterController.m
//  BaseballGame
//
//  Created by Chappy Asel on 8/14/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "BGRosterController.h"

@implementation BGRosterController

+ (BGRosterController *)sharedInstance {
    static BGRosterController *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[BGRosterController alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)initWithTeams: (NSMutableArray <BGTeam *> *) teams {
    if (self = [super init]) {
        self.teams = teams;
    }
    return self;
}

#pragma mark - Public Methods

- (void)loadRosterFromESPN {
    
}

#pragma mark - NSCoding

#define kTeams @"Teams"

- (id)initWithCoder:(NSCoder *)decoder {
    NSMutableArray <BGTeam *> *teams = [decoder decodeObjectForKey:kTeams];
    return [self initWithTeams:teams];
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.teams forKey:kTeams];
}

@end
