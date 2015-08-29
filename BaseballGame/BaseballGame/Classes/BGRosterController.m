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
    NSArray *abbrevs = @[@"CIN",@"BAL", @"ARI", @"BOS", @"ATL", @"CHW", @"CHC", @"CLE", @"CIN", @"DET", @"COL", @"HOU", @"LAD",@"KCR", @"MIA", @"LAA", @"MIL", @"MIN", @"NYM", @"NYY", @"PHI", @"OAK", @"PIT", @"SEA", @"SDP", @"TBR", @"SFG", @"TEX", @"STL", @"TOR", @"WSN"];
    TFHpple *parser;
    for (int i = 0; i < abbrevs.count; i++) {
        BGTeam *team = [BGTeam object];
        [team loadTeamFromAbbreviation: abbrevs[i]];
        team.pitchers = [[NSMutableArray alloc] init];
        team.batters = [[NSMutableArray alloc] init];
        
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
            for (int i = 1; i < MIN(10, players.count); i += 2) {
                TFHppleElement *playerElement = players[i];
                NSArray <TFHppleElement *> *elements = playerElement.children;
                if (elements[4*2+1].content.length > 2 && [[elements[4*2+1].content substringToIndex:3] isEqualToString:@"MAJ"]) {
                    BGBatter *batter = [BGBatter object];
                    NSArray *fullName = [elements[1*2+1].content componentsSeparatedByString:@", "];
                    batter.firstName = fullName[0];
                    batter.lastName = fullName[1];
                    batter.position = elements[2*2+1].content;
                    float Avg = [elements[18*2+1].content floatValue];
                    float G = [elements[5*2+1].content floatValue];
                    float Ab = [elements[7*2+1].content floatValue];
                    float SoAb = [elements[17*2+1].content floatValue] / Ab;
                    float Slg = [elements[20*2+1].content floatValue];
                    float SbG = [elements[14*2+1].content floatValue] / G;
                    float csG = [elements[15*2+1].content floatValue] / G;
                    float TbAb = [elements[11*2+1].content floatValue] / Ab;
                    float BbAb = [elements[16*2+1].content floatValue] / Ab;
                    float GdpAb = [elements[23*2+1].content floatValue] / Ab;
                    float RRbiAb = ([elements[13*2+1].content floatValue] - [elements[12*2+1].content floatValue]) / Ab;
                    float EG = [elements[28*2+1].content floatValue] / G; //TEMPORARY (D WAR)
                    //                   MAX                           MIN     LOW  TO MAX  RANGE
                    batter.contact = MIN(@100, [NSNumber numberWithInt:65+(Avg-.180)*(35/.170)]); //Avg: 65 = .180, 100 = .350
                    batter.power = MIN(@100, [NSNumber numberWithInt:65+(Slg-.300)*(35/.330)]); //Slg: 65 = .300, 100 = .630
                    batter.speed = MIN(@100, [NSNumber numberWithInt:65+(SbG)*(35/.24691)]); //SbG: 65 = 0/162, 100 = 40/162
                    batter.vision = MIN(@100, [NSNumber numberWithInt:65+(BbAb-(20/615.0))*(35/(90/615.0))]); //BbAb: 65 = 20/615, 100 = 110/615
                    batter.clutch = MIN(@100, [NSNumber numberWithInt:65+(RRbiAb-(30/615.0))*(35/(60/615.0))]); //RRbiAb: 65 = 30/615, 100 = 90/615
                    batter.fielding = MIN(@100, [NSNumber numberWithInt:100-(EG)*(30/.100)]); //EG: 70 = .100, 100 = .000
                    [batter calculateOverall];
                    [team.batters addObject:batter];
                }
            }
        }
        NSLog(@"%@",team);
        
        url = [NSURL URLWithString: [NSString stringWithFormat:@"http://baseball-reference.com/teams/%@/%d-organization-pitching.shtml",abbrevs[i],year]];
        html = [NSData dataWithContentsOfURL:url options:NSDataReadingMapped error:&error];
        if (error) NSLog(@"%@",error);
        parser = [TFHpple hppleWithHTMLData:html];
        XpathQueryString = @"//table[@id='40man']/tbody/tr";
        nodes = [parser searchWithXPathQuery:XpathQueryString];
        for (TFHppleElement *player in nodes) {
            
        }
        
        //team.year = year;
        NSLog(@"finished loading %@",abbrevs[i]);
    }
}

@end
