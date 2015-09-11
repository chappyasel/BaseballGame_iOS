//
//  BGLeagueDetails+CoreDataProperties.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BGLeagueDetails.h"

NS_ASSUME_NONNULL_BEGIN

@interface BGLeagueDetails (CoreDataProperties)

@property (nullable, nonatomic, retain) NSOrderedSet<BGTeamInfo *> *teams;

@property (nullable, nonatomic, retain) BGLeagueInfo *info;

@end

@interface BGLeagueDetails (CoreDataGeneratedAccessors)

- (void)insertObject:(BGTeamInfo *)value inTeamsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromTeamsAtIndex:(NSUInteger)idx;
- (void)insertTeams:(NSArray *)array atIndexes:(NSIndexSet *)indexes;
- (void)removeTeamsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInTeamsAtIndex:(NSUInteger)idx withObject:(BGTeamInfo *)value;
- (void)replaceTeamsAtIndexes:(NSIndexSet *)indexes withTeams:(NSArray<BGTeamInfo *> *)values;
- (void)addTeamsObject:(BGTeamInfo *)value;
- (void)removeTeamsObject:(BGTeamInfo *)value;
- (void)addTeams:(NSOrderedSet<BGTeamInfo *> *)values;
- (void)removeTeams:(NSOrderedSet<BGTeamInfo *> *)values;

@end

NS_ASSUME_NONNULL_END
