//
//  BGPitcher.h
//  BaseballGame
//
//  Created by Chappy Asel on 8/27/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGPitcher : PFObject <PFSubclassing>
+ (NSString *)parseClassName;

@property NSString *firstName;
@property NSString *lastName;

@property NSNumber *overall;

@property NSNumber *velocity; //determined using SO9                        Strikeouts
@property NSNumber *accuracy; //determined using BB9, SO/BB, HBP/IP, WP     Walks
@property NSNumber *deception; //determined using BAbip, HR/H               Power against
@property NSNumber *endurance; //determined using IP/G                      Innings without losing effectivness
@property NSNumber *composure; //determined using ERA, WL%                  How good pitcher is!

@end
