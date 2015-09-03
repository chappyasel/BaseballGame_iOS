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

@property (nullable, nonatomic, retain) NSManagedObject *teams;
@property (nullable, nonatomic, retain) BGLeagueInfo *info;

@end

NS_ASSUME_NONNULL_END
