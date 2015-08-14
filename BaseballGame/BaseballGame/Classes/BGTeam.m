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

@end
