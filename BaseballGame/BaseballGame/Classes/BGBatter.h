//
//  BGBatter.h
//  BaseballGame
//
//  Created by Chappy Asel on 8/27/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "BGPlayer.h"

@interface BGBatter : BGPlayer
+ (NSString *)parseClassName;

@property int contact; //determined using AVG, SO/G             Hits
@property int power; //determined using SLG                     HRs, 2B
@property int speed; //determined using SB/G, CS/G, 3B/G        SBs, Extra bases
@property int vision; //determined using BB/G, SO/G             walk tendency
@property int clutch; //determined using GDP/G, (RBI-HR)/G      with RISP bonus
@property int fielding; //determined using ADV STATS - DEF 50   determining errors

@end
