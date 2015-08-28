//
//  BGPitcher.m
//  BaseballGame
//
//  Created by Chappy Asel on 8/27/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "BGPitcher.h"

@implementation BGPitcher

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"BGPitcher";
}

@end
