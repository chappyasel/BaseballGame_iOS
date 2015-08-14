//
//  BGDoc.h
//  BaseballGame
//
//  Created by Chappy Asel on 8/14/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGDoc : NSObject {
    NSString *_docPath;
}

@property (copy) NSString *docPath;

- (id)init;

- (id)initWithDocPath:(NSString *)docPath;

- (void)saveData;

- (void)deleteDoc;

@end
