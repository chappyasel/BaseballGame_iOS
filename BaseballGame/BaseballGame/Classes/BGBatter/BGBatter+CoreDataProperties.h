//
//  BGBatter+CoreDataProperties.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BGBatter.h"

NS_ASSUME_NONNULL_BEGIN

@interface BGBatter (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;

@property (nullable, nonatomic, retain) NSString *position;

@property (nullable, nonatomic, retain) NSNumber *overall;

@property (nullable, nonatomic, retain) NSNumber *contact; //avg
@property (nullable, nonatomic, retain) NSNumber *power; //slg
@property (nullable, nonatomic, retain) NSNumber *speed; //SbG
@property (nullable, nonatomic, retain) NSNumber *vision; //BbPa
@property (nullable, nonatomic, retain) NSNumber *clutch; //RbiPa
@property (nullable, nonatomic, retain) NSNumber *fielding; //dwar

@property (nullable, nonatomic, retain) BGTeamDetails *team;

@end

NS_ASSUME_NONNULL_END
