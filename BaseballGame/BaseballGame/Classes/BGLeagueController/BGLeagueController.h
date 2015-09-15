//
//  BGLeagueController.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BGLeagueInfo;

NS_ASSUME_NONNULL_BEGIN

@interface BGLeagueController : NSManagedObject

- (void)loadLeagueForYear: (int)year context: (NSManagedObjectContext *) context WithProgressBlock:(void (^)(float progress)) progress;

- (BOOL)removeLeagueForYear:(int)year context: (NSManagedObjectContext *)context;

- (void)deleteAllLeaguesWithContext: (NSManagedObjectContext *)context;

- (void)saveLeagueController;

@end

NS_ASSUME_NONNULL_END

#import "BGLeagueController+CoreDataProperties.h"
