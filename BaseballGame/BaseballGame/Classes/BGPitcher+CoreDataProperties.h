//
//  BGPitcher+CoreDataProperties.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BGPitcher.h"

NS_ASSUME_NONNULL_BEGIN

@interface BGPitcher (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;

@property (nullable, nonatomic, retain) NSNumber *overall;

@property (nullable, nonatomic, retain) NSString *position;

@property (nullable, nonatomic, retain) NSNumber *unhittable; //baa
@property (nullable, nonatomic, retain) NSNumber *deception; //Hr9
@property (nullable, nonatomic, retain) NSNumber *composure; //Era
@property (nullable, nonatomic, retain) NSNumber *velocity; //So9
@property (nullable, nonatomic, retain) NSNumber *accuracy; //Bb9
@property (nullable, nonatomic, retain) NSNumber *endurance; //IpG

@property (nullable, nonatomic, retain) BGTeamDetails *team;

@end

NS_ASSUME_NONNULL_END
