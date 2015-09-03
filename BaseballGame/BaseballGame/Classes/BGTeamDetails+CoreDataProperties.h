//
//  BGTeamDetails+CoreDataProperties.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BGTeamDetails.h"

NS_ASSUME_NONNULL_BEGIN

@interface BGTeamDetails (CoreDataProperties)

@property (nullable, nonatomic, retain) NSOrderedSet<BGPitcher *> *pitchers;
@property (nullable, nonatomic, retain) NSOrderedSet<BGBatter *> *batters;

@property (nullable, nonatomic, retain) BGTeamInfo *info;

@end

@interface BGTeamDetails (CoreDataGeneratedAccessors)

- (void)insertObject:(BGPitcher *)value inPitchersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPitchersAtIndex:(NSUInteger)idx;
- (void)insertPitchers:(NSArray<BGPitcher *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePitchersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPitchersAtIndex:(NSUInteger)idx withObject:(BGPitcher *)value;
- (void)replacePitchersAtIndexes:(NSIndexSet *)indexes withPitchers:(NSArray<BGPitcher *> *)values;
- (void)addPitchersObject:(BGPitcher *)value;
- (void)removePitchersObject:(BGPitcher *)value;
- (void)addPitchers:(NSOrderedSet<BGPitcher *> *)values;
- (void)removePitchers:(NSOrderedSet<BGPitcher *> *)values;

- (void)insertObject:(BGBatter *)value inBattersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromBattersAtIndex:(NSUInteger)idx;
- (void)insertBatters:(NSArray<BGBatter *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeBattersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInBattersAtIndex:(NSUInteger)idx withObject:(BGBatter *)value;
- (void)replaceBattersAtIndexes:(NSIndexSet *)indexes withBatters:(NSArray<BGBatter *> *)values;
- (void)addBattersObject:(BGBatter *)value;
- (void)removeBattersObject:(BGBatter *)value;
- (void)addBatters:(NSOrderedSet<BGBatter *> *)values;
- (void)removeBatters:(NSOrderedSet<BGBatter *> *)values;

@end

NS_ASSUME_NONNULL_END
