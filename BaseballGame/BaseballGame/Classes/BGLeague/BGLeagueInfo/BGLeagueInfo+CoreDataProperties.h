//
//  BGLeagueInfo+CoreDataProperties.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BGLeagueInfo.h"
#import "BGLeagueController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BGLeagueInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *year;

@property (nullable, nonatomic, retain) NSString *name;

@property (nullable, nonatomic, retain) BGLeagueDetails *details;

@property (nullable, nonatomic, retain) BGLeagueController *leagueController;

@end

NS_ASSUME_NONNULL_END
