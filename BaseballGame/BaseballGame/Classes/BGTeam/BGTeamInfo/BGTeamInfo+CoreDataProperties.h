//
//  BGTeamInfo+CoreDataProperties.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BGTeamInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface BGTeamInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *abbreviation;

@property (nullable, nonatomic, retain) NSNumber *overall;
@property (nullable, nonatomic, retain) NSNumber *pitchingOverall;
@property (nullable, nonatomic, retain) NSNumber *battingOverall;

@property (nullable, nonatomic, retain) BGTeamDetails *details;

@property (nullable, nonatomic, retain) BGLeagueDetails *league;

@end

NS_ASSUME_NONNULL_END
