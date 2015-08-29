//
//  BGBatter.h
//  BaseballGame
//
//  Created by Chappy Asel on 8/27/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGBatter : PFObject <PFSubclassing>
+ (NSString *)parseClassName;

@property NSString *firstName;
@property NSString *lastName;

@property NSString *position;

@property NSNumber *overall;

@property NSNumber *contact; //determined using AVG, SO/AB             Hits
@property NSNumber *power; //determined using SLG                     HRs, 2B
@property NSNumber *speed; //determined using SB/G, CS/G, 3B/AB        SBs, Extra bases
@property NSNumber *vision; //determined using BB/AB, SO/AB             walk tendency
@property NSNumber *clutch; //determined using GDP/AB, (RBI-HR)/AB      with RISP bonus
@property NSNumber *fielding; //determined using ADV STATS - DEF 50   determining errors

- (void) calculateOverall;

@end
