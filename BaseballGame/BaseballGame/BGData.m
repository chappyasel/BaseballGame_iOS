//
//  BGData.m
//  BaseballGame
//
//  Created by Chappy Asel on 8/14/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "BGData.h"

@implementation BGData

- (instancetype) initWithRosterController: (BGRosterController *) rosterController {
    if (self = [super init]) {
        self.rosterController = rosterController;
    }
    return self;
}

#pragma mark - NSCoding

#define kRosterController @"RosterController"

- (id)initWithCoder:(NSCoder *)decoder {
    BGRosterController *RC = [decoder decodeObjectForKey:kRosterController];
    return [self initWithRosterController:RC];
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.rosterController forKey:kRosterController];
}

@end
