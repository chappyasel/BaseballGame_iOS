//
//  BGTeamDetails.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BGBatter, BGPitcher, BGTeamInfo;

NS_ASSUME_NONNULL_BEGIN

@interface BGTeamDetails : NSManagedObject

- (void)loadTeamWithAbbrev: (NSString *) abbrev year: (int) year context: (NSManagedObjectContext *) context;

@end

NS_ASSUME_NONNULL_END

#import "BGTeamDetails+CoreDataProperties.h"
