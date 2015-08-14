//
//  BGDatabase.h
//  BaseballGame
//
//  Created by Chappy Asel on 8/14/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGDatabase : NSObject

+ (NSMutableArray *)loadBaseballGameDocs;

+ (NSString *)nextBaseballGameDocPath;

@end
