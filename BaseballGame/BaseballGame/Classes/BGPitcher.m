//
//  BGPitcher.m
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "BGPitcher.h"
#import "BGTeamDetails.h"

@implementation BGPitcher

- (void)calculateOverall {
    self.overall = [NSNumber numberWithInt: self.unhittable.intValue*.3+self.deception.intValue*.25+self.composure.intValue*.2+self.velocity.intValue*.125+self.accuracy.intValue*.125];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ (%@): Overall: %@           (%@         %@         %@         %@         %@         %@)",self.firstName,self.lastName,self.position,self.overall,self.unhittable,self.deception,self.composure,self.velocity,self.accuracy,self.endurance];
}

@end
