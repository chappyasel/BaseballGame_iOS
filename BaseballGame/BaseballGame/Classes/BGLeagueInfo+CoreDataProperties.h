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

NS_ASSUME_NONNULL_BEGIN

@interface BGLeagueInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *year;
@property (nullable, nonatomic, retain) NSNumber *isCustom;
@property (nullable, nonatomic, retain) NSManagedObject *details;

@end

NS_ASSUME_NONNULL_END
