//
//  BGLeagueController+CoreDataProperties.m
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BGLeagueController+CoreDataProperties.h"

@implementation BGLeagueController (CoreDataProperties)

@dynamic leagues;

- (void)addLeaguesObject:(BGLeagueInfo *)value {
    NSMutableOrderedSet<BGLeagueInfo *> *tempSet = [[NSMutableOrderedSet alloc] initWithOrderedSet:self.leagues];
    if (![self.leagues containsObject:value]) [tempSet addObject:value];
    self.leagues = tempSet;
}

@end
