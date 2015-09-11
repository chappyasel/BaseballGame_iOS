//
//  BGLeagueController+CoreDataProperties.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BGLeagueController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BGLeagueController (CoreDataProperties)

@property (nullable, nonatomic, retain) NSOrderedSet<BGLeagueInfo *> *leagues;

@end

@interface BGLeagueController (CoreDataGeneratedAccessors)

- (void)insertObject:(BGLeagueInfo *)value inLeaguesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLeaguesAtIndex:(NSUInteger)idx;
- (void)insertLeagues:(NSArray<BGLeagueInfo *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLeaguesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLeaguesAtIndex:(NSUInteger)idx withObject:(BGLeagueInfo *)value;
- (void)replaceLeaguesAtIndexes:(NSIndexSet *)indexes withLeagues:(NSArray<BGLeagueInfo *> *)values;
- (void)addLeaguesObject:(BGLeagueInfo *)value;
- (void)removeLeaguesObject:(BGLeagueInfo *)value;
- (void)addLeagues:(NSOrderedSet<BGLeagueInfo *> *)values;
- (void)removeLeagues:(NSOrderedSet<BGLeagueInfo *> *)values;

@end

NS_ASSUME_NONNULL_END
