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

- (void)calculateOverall {
    self.overall = [NSNumber numberWithInt: self.unhittable.intValue*.3+self.deception.intValue*.25+self.composure.intValue*.2+self.velocity.intValue*.125+self.accuracy.intValue*.125];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ (%@): Overall: %@           (%@         %@         %@         %@         %@         %@)",self.firstName,self.lastName,self.position,self.overall,self.unhittable,self.deception,self.composure,self.velocity,self.accuracy,self.endurance];
}

- (BOOL)isEqual: (BGPitcher *) object {
    return [self.firstName isEqualToString:object.firstName] && [self.lastName isEqualToString:object.lastName];
}

- (NSUInteger)hash {
    return self.firstName.hash + self.lastName.hash;
}

@end
