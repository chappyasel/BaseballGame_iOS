//
//  BGDatabase.m
//  BaseballGame
//
//  Created by Chappy Asel on 8/14/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "BGDatabase.h"
#import "BGDoc.h"

@implementation BGDatabase

+ (NSMutableArray *)loadBaseballGameDocs {
    // Get private docs dir
    NSString *documentsDirectory = [BGDatabase getPrivateDocsDir];
    NSLog(@"Loading data from %@", documentsDirectory);
    // Get contents of documents directory
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (files == nil) {
        NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }
    // Create BGDoc for each file
    NSMutableArray *retval = [NSMutableArray arrayWithCapacity:files.count];
    for (NSString *file in files) {
        if ([file.pathExtension compare:@"scarybug" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
            BGDoc *doc = [[BGDoc alloc] initWithDocPath:fullPath];
            [retval addObject:doc];
        }
    }
    return retval;
}

+ (NSString *)getPrivateDocsDir {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    return documentsDirectory;
}

+ (NSString *)nextBaseballGameDocPath {
    // Get private docs dir
    NSString *documentsDirectory = [BGDatabase getPrivateDocsDir];
    // Get contents of documents directory
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (files == nil) {
        NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }
    // Search for an available name
    int maxNumber = 0;
    for (NSString *file in files) {
        if ([file.pathExtension compare:@"scarybug" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSString *fileName = [file stringByDeletingPathExtension];
            maxNumber = MAX(maxNumber, fileName.intValue);
        }
    }
    // Get available name
    NSString *availableName = [NSString stringWithFormat:@"%d.scarybug", maxNumber+1];
    return [documentsDirectory stringByAppendingPathComponent:availableName];
}

@end
