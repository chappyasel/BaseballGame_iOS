//
//  BGPlayer.h
//  BaseballGame
//
//  Created by Chappy Asel on 8/14/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGPlayer : PFObject <PFSubclassing>
+ (NSString *)parseClassName;

@property NSString *firstName;
@property NSString *lastName;

@property NSString *position;

@end
