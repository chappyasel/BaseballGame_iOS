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

@property NSString *position;

@property NSNumber *overall;

@property NSNumber *unhittable; //determined using BA A                 Avg against
@property NSNumber *deception; //determined using BAbip, HR/H           Power upon hit
@property NSNumber *composure; //determined using ERA, WL%              Hits after Hits
@property NSNumber *velocity; //determined using SO9                    Strikeouts
@property NSNumber *accuracy; //determined using BB9, SOBB, HBPIP, WP   Walks
@property NSNumber *endurance; //determined using IP/G                  Innings without losing effectivness

- (void) calculateOverall;

@end
