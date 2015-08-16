//
//  BGRosterController.m
//  BaseballGame
//
//  Created by Chappy Asel on 8/14/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "BGRosterController.h"
#import "TFHpple.h"

@implementation BGRosterController

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"BGRosterController";
}

+ (BGRosterController *)sharedInstance {
    static BGRosterController *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[BGRosterController alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - Public Methods

- (void)loadRosterFromESPN {
    NSArray *names = @[@"BAL", @"ARI", @"BOS", @"ATL", @"CHW", @"CHC", @"CLE", @"CIN", @"DET", @"COL", @"HOU", @"LAD",@"KC",@"MIA",@"LAA",@"MIL",@"MIN",@"NYM",@"NYY", @"PHI", @"OAK", @"PIT", @"SEA", @"SD", @"TB", @"SF", @"TEX", @"STL", @"TOR", @"WAS"];
    TFHpple *parser;
    for (int i = 0; i < names.count; i++) {
        NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://espn.go.com/mlb/team/depth/_/name/%@",names[i]]];
        NSError *error;
        NSData *html = [NSData dataWithContentsOfURL:url options:NSDataReadingMapped error:&error];
        if (error) NSLog(@"%@",error);
        parser = [TFHpple hppleWithHTMLData:html];
        NSString *XpathQueryString = @"//script";
        NSArray *nodes = [parser searchWithXPathQuery:XpathQueryString];
        for (TFHppleElement *node in nodes) {
            
        }
    }
}

@end
