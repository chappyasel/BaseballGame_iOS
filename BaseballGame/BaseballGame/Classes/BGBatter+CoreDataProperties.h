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

@property (nullable, nonatomic, retain) NSNumber *contact;
@property (nullable, nonatomic, retain) NSNumber *clutch;
@property (nullable, nonatomic, retain) NSNumber *fielding;
@property (nullable, nonatomic, retain) NSNumber *power;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSNumber *speed;
@property (nullable, nonatomic, retain) NSString *position;
@property (nullable, nonatomic, retain) NSNumber *vision;
@property (nullable, nonatomic, retain) NSManagedObject *team;

@end

NS_ASSUME_NONNULL_END
