//
//  BGLeagueDetails.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BGLeagueInfo, BGTeamInfo;

NS_ASSUME_NONNULL_BEGIN

@interface BGLeagueDetails : NSManagedObject

- (void)loadCurrentRosterFromBBRForYear: (int) year context: (NSManagedObjectContext *) context WithProgressBlock:(void (^)(float progress))progress;

@end

NS_ASSUME_NONNULL_END

#import "BGLeagueDetails+CoreDataProperties.h"
