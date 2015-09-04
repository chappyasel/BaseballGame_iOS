//
//  BGBatter.m
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "BGBatter.h"

@implementation BGBatter

- (void) calculateOverall {
    self.overall = [NSNumber numberWithInt: self.contact.intValue*.25 + self.power.intValue*.25 + self.speed.intValue*.15 + self.vision.intValue*.125 + self.clutch.intValue*.125 + self.fielding.intValue*.1];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ (%@): Overall: %@           (%@         %@         %@         %@         %@         %@)",self.firstName,self.lastName,self.position,self.overall,self.contact,self.power,self.speed,self.vision,self.clutch,self.fielding];
}

@end
