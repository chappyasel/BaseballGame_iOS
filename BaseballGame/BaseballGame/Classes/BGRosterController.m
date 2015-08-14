//
//  BGRosterController.m
//  BaseballGame
//
//  Created by Chappy Asel on 8/14/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "BGRosterController.h"

@implementation BGRosterController

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"BGRosterController";
}

+ (BGRosterController *)sharedInstance {
    static BGRosterController *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[BGRosterController alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - Public Methods

- (void)loadRosterFromESPN {
    
}

@end
