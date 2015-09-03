//
//  BGLeagueController.m
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "BGLeagueController.h"
#import "BGLeagueInfo.h"

@implementation BGLeagueController

+ (BGLeagueController *)sharedInstance {
    static BGLeagueController *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[BGLeagueController alloc] init];
    });
    return _sharedInstance;
}

@end
