//
//  BGLeagueController.m
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "BGLeagueController.h"
#import "BGLeagueInfo.h"
#import "BGLeagueDetails.h"

@implementation BGLeagueController

- (void)loadLeagueForYear: (int)year context: (NSManagedObjectContext *) context WithProgressBlock:(void (^)(float progress)) block {
    [self removeLeagueForYear:year context:context];
    
    BGLeagueInfo *info = [NSEntityDescription insertNewObjectForEntityForName:@"BGLeagueInfo" inManagedObjectContext:self.managedObjectContext];
    info.year = [NSNumber numberWithInt:year];
    info.name = nil;
    info.leagueController = self;
    BGLeagueDetails *details = [NSEntityDescription insertNewObjectForEntityForName:@"BGLeagueDetails" inManagedObjectContext:self.managedObjectContext];
    dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    dispatch_async(myQueue, ^{
        [details loadCurrentRosterFromBBRForYear:year context:self.managedObjectContext WithProgressBlock:^(float progress) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(progress);
            });
        }];
        info.details = details;
        details.info = info;
        [self addLeaguesObject:info];
        
        [self saveLeagueController];
    });
}

- (BOOL)removeLeagueForYear:(int)year context: (NSManagedObjectContext *)context {
    for (int i = 0; i < self.leagues.count; i++) {
        if ([self.leagues[i].year intValue] == year) {
            [context deleteObject:self.leagues[i]];
            [self saveLeagueController];
            return YES;
        }
    }
    return NO;
}

- (void)deleteAllLeaguesWithContext: (NSManagedObjectContext *)context {
    for (int i = 0; i < self.leagues.count; i++) {
        [context deleteObject:self.leagues[i]];
    }
    self.leagues = [[NSOrderedSet alloc] init];
    [self saveLeagueController];
}

- (void)saveLeagueController {
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Couldn't save: %@", error);
    }
    else NSLog(@"leagueController saved");

}

@end
