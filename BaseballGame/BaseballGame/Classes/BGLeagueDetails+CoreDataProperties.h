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

- (void)insertObject:(BGTeamInfo *)value inPitchersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPitchersAtIndex:(NSUInteger)idx;
- (void)insertPitchers:(NSArray<BGTeamInfo *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePitchersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPitchersAtIndex:(NSUInteger)idx withObject:(BGTeamInfo *)value;
- (void)replacePitchersAtIndexes:(NSIndexSet *)indexes withPitchers:(NSArray<BGTeamInfo *> *)values;
- (void)addPitchersObject:(BGTeamInfo *)value;
- (void)removePitchersObject:(BGTeamInfo *)value;
- (void)addPitchers:(NSOrderedSet<BGTeamInfo *> *)values;
- (void)removePitchers:(NSOrderedSet<BGTeamInfo *> *)values;

@end

NS_ASSUME_NONNULL_END
