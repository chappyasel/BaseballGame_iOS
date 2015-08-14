//
//  BGTeam.h
//  BaseballGame
//
//  Created by Chappy Asel on 8/14/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGPlayer.h"

@interface BGTeam : NSObject

@property NSString *name;
@property NSString *abbreviation;

@property NSMutableArray <BGPlayer *> *players;

@end
