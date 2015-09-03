//
//  AppDelegate.m
//  BaseballGame
//
//  Created by Chappy Asel on 8/14/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "BGLeagueController.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"BGLegueController" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (error) NSLog(@"%@",error);
    BGLeagueController *leagueController;
    if (!fetchedObjects) {
        rosterController = [BGRosterController object];
        dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
        dispatch_async(myQueue, ^{
            [rosterController loadCurrentRosterFromBBRWithProgressBlock:^void(float progress) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    progressView.progress = progress;
                });
            }];
            [rosterController saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (error) NSLog(@"%@",error);
                if (succeeded) NSLog(@"SAVED ROSTER CONTROLLER");
            }];
            [self loadTableView];
        });
    }
    else {
        if (fetchedObjects.count != 1) NSLog(@"Error: Multiple leagueControllers");
        leagueController = fetchedObjects.firstObject;
    }
    leagueController = [BGLeagueController sharedInstance];
    leagueController = localRC;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
