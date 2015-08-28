//
//  BGPitcher.h
//  BaseballGame
//
//  Created by Chappy Asel on 8/27/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "BGPlayer.h"

@interface BGPitcher : BGPlayer
+ (NSString *)parseClassName;

@property int velocity; //determined using SO9                  Strikeouts
@property int accuracy; //determined using SO/BB, HBP/IP, WP    Walks
@property int deception; //determined using BAbip, HR/H         Power against
@property int endurance; //determined using IP/G                Innings without losing effectivness
@property int composure; //determined using ERA, WL%            How good pitcher is!

@end
