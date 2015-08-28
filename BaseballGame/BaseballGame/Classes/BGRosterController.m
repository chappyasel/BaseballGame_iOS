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

- (void)loadCurrentRosterFromBBR {
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    int year = (int)[gregorian component:NSCalendarUnitYear fromDate:NSDate.date];
    NSArray *abbrevs = @[@"BAL", @"ARI", @"BOS", @"ATL", @"CHW", @"CHC", @"CLE", @"CIN", @"DET", @"COL", @"HOU", @"LAD",@"KCR", @"MIA", @"LAA", @"MIL", @"MIN", @"NYM", @"NYY", @"PHI", @"OAK", @"PIT", @"SEA", @"SDP", @"TBR", @"SFG", @"TEX", @"STL", @"TOR", @"WSN"];
    TFHpple *parser;
    for (int i = 0; i < abbrevs.count; i++) {
        BGTeam *team = [[BGTeam alloc] initWithAbbreviation:abbrevs[i]];
        
        NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://baseball-reference.com/teams/%@/%d-organization-batting.shtml",abbrevs[i],year]];
        NSError *error;
        NSData *html = [NSData dataWithContentsOfURL:url options:NSDataReadingMapped error:&error];
        if (error) NSLog(@"%@",error);
        parser = [TFHpple hppleWithHTMLData:html];
        NSString *XpathQueryString = @"//div[@id='page_content']/div";
        NSArray *nodes = [parser searchWithXPathQuery:XpathQueryString];
        NSArray *playerTables = @[nodes[2], nodes[4], nodes[6], nodes[8], nodes[10]];
        for (TFHppleElement *table in playerTables) {
            NSArray *players = ((TFHppleElement *)((TFHppleElement *)table.children[1]).children[5]).children;
            for (int i = 1; i < players.count; i += 2) {
                TFHppleElement *playerElement = players[i];
                BGPlayer *player = [[BGPlayer alloc] init];
                int x = 1;
                for (int i = 1; i < playerElement.children.count; i+= 2) {
                    TFHppleElement *element = playerElement.children[i];
                    if (x == 2) player.name = element.content;
                    x++;
                }
                
            }
        }
        
        url = [NSURL URLWithString: [NSString stringWithFormat:@"http://baseball-reference.com/teams/%@/%d-organization-pitching.shtml",abbrevs[i],year]];
        html = [NSData dataWithContentsOfURL:url options:NSDataReadingMapped error:&error];
        if (error) NSLog(@"%@",error);
        parser = [TFHpple hppleWithHTMLData:html];
        XpathQueryString = @"//table[@id='40man']/tbody/tr";
        nodes = [parser searchWithXPathQuery:XpathQueryString];
        for (TFHppleElement *player in nodes) {
            
        }
        
        team.year = year;
        NSLog(@"finished loading %@",abbrevs[i]);
    }
}

@end
