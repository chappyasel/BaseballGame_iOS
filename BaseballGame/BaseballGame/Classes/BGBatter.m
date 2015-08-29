//
//  BGBatter.m
//  BaseballGame
//
//  Created by Chappy Asel on 8/27/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "BGBatter.h"

@implementation BGBatter

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"BGBatter";
}

- (void) calculateOverall {
    self.overall = [NSNumber numberWithInt: self.contact.intValue*.25 + self.power.intValue*.25 + self.speed.intValue*.15 + self.vision.intValue*.125 + self.clutch.intValue*.125 + self.fielding.intValue*.1];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ (%@): Overall: %@           (%@         %@         %@         %@         %@         %@)",self.firstName,self.lastName,self.position,self.overall,self.contact,self.power,self.speed,self.vision,self.clutch,self.fielding];
}

- (BOOL)isEqual: (BGBatter *) object {
    return [self.firstName isEqualToString:object.firstName] && [self.lastName isEqualToString:object.lastName];
}

- (NSUInteger)hash {
    return self.firstName.hash + self.lastName.hash;
}

@end
