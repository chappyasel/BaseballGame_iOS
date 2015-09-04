//
//  BGTeamDetails.m
//  BaseballGame
//
//  Created by Chappy Asel on 9/3/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "BGTeamDetails.h"
#import "BGTeamInfo.h"
#import "TFHpple.h"
#import "BGBatter.h"
#import "BGPitcher.h"

@implementation BGTeamDetails

- (void)loadTeamWithAbbrev: (NSString *) abbrev year: (int) year context: (NSManagedObjectContext *) context {
    self.pitchers = [[NSOrderedSet alloc] init];
    self.batters = [[NSOrderedSet alloc] init];
    
    NSError *error;
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://baseball-reference.com/teams/%@/%d-organization-batting.shtml",abbrev,year]];
    NSData *html = [NSData dataWithContentsOfURL:url options:NSDataReadingMapped error:&error];
    if (error) NSLog(@"%@",error);
    TFHpple *parser = [TFHpple hppleWithHTMLData:html];
    NSString *XpathQueryString = @"//div[@id='page_content']/div";
    NSArray *nodes = [parser searchWithXPathQuery:XpathQueryString];
    NSArray *playerTables = @[nodes[2], nodes[4], nodes[6], nodes[8], nodes[10]];
    
    for (TFHppleElement *table in playerTables) {
        NSArray *players = ((TFHppleElement *)((TFHppleElement *)table.children[1]).children[5]).children;
        for (int i = 1; i < MIN(7*2, players.count); i += 2) {
            TFHppleElement *playerElement = players[i];
            NSArray <TFHppleElement *> *elements = playerElement.children;
            if (elements[4*2+1].firstChild.content.length > 2 && [[elements[4*2+1].firstChild.content substringToIndex:3] isEqualToString:@"MAJ"]) {
                BGBatter *batter = [NSEntityDescription insertNewObjectForEntityForName:@"BGBatter" inManagedObjectContext:context];
                NSArray *fullName = [elements[1*2+1].firstChild.firstChild.content componentsSeparatedByString:@", "];
                batter.firstName = fullName[1];
                batter.lastName = fullName[0];
                batter.position = elements[2*2+1].firstChild.content;
                float Avg = [elements[18*2+1].firstChild.content floatValue];
                float G = [elements[5*2+1].firstChild.content floatValue];
                float Ab = [elements[7*2+1].firstChild.content floatValue];
                float SoAb = [elements[17*2+1].firstChild.content floatValue] / Ab;
                float Slg = [elements[20*2+1].firstChild.content floatValue];
                float SbG = [elements[14*2+1].firstChild.content floatValue] / G;
                float csG = [elements[15*2+1].firstChild.content floatValue] / G;
                float TbAb = [elements[11*2+1].firstChild.content floatValue] / Ab;
                float BbAb = [elements[16*2+1].firstChild.content floatValue] / Ab;
                float GdpAb = [elements[23*2+1].firstChild.content floatValue] / Ab;
                float RRbiAb = ([elements[13*2+1].firstChild.content floatValue] - [elements[12*2+1].content floatValue]) / Ab;
                float EG = [elements[28*2+1].firstChild.content floatValue] / G; //TEMPORARY (D WAR)
                //                   MAX                           MIN     LOW  TO MAX  RANGE
                batter.contact = MIN(@100, [NSNumber numberWithInt:65+(Avg-.180)*(35/.170)]); //Avg: 65 = .210, 100 = .350
                batter.power = MIN(@100, [NSNumber numberWithInt:65+(Slg-.300)*(35/.330)]); //Slg: 65 = .320, 100 = .600
                batter.speed = MIN(@100, [NSNumber numberWithInt:65+(SbG)*(35/.24691)]); //SbG: 65 = 0/162, 100 = 30/162
                batter.vision = MIN(@100, [NSNumber numberWithInt:65+(BbAb-(20/615.0))*(35/(90/615.0))]); //BbAb: 65 = 20/615, 100 = 110/615
                batter.clutch = MIN(@100, [NSNumber numberWithInt:65+(RRbiAb-(25/615.0))*(35/(65/615.0))]); //RRbiAb: 65 = 25/615, 100 = 90/615
                batter.fielding = MIN(@100, [NSNumber numberWithInt:100-(EG)*(30/.100)]); //EG: 70 = .100, 100 = .000
                [batter calculateOverall];
                batter.team = self;
                [self addBattersObject:batter];
            }
        }
    }
    
    url = [NSURL URLWithString: [NSString stringWithFormat:@"http://baseball-reference.com/teams/%@/%d-organization-pitching.shtml",abbrev,year]];
    html = [NSData dataWithContentsOfURL:url options:NSDataReadingMapped error:&error];
    if (error) NSLog(@"%@",error);
    parser = [TFHpple hppleWithHTMLData:html];
    XpathQueryString = @"//div[@id='page_content']/div";
    nodes = [parser searchWithXPathQuery:XpathQueryString];
    playerTables = @[nodes[2], nodes[4], nodes[6], nodes[8], nodes[10]];
    
    for (int t = 0; t < playerTables.count; t++) {
        TFHppleElement *table = playerTables[t];
        NSArray *players = ((TFHppleElement *)((TFHppleElement *)table.children[1]).children[5]).children;
        for (int i = 1; i < MIN(8*2+1, players.count); i += 2) {
            TFHppleElement *playerElement = players[i];
            NSArray <TFHppleElement *> *elements = playerElement.children;
            TFHppleElement *locationElement = elements[3*2+1].firstChild;
            if (locationElement.content.length > 2 && [[locationElement.content substringToIndex:3] isEqualToString:@"MAJ"]) {
                BGPitcher *pitcher = [NSEntityDescription insertNewObjectForEntityForName:@"BGPitcher" inManagedObjectContext:context];
                NSArray *fullName = [elements[1*2+1].firstChild.firstChild.content componentsSeparatedByString:@", "];
                pitcher.firstName = fullName[1];
                pitcher.lastName = fullName[0];
                if (t <= 1)      pitcher.position = @"S";
                else if (t <= 3) pitcher.position = @"R";
                else             pitcher.position = @"C";
                float G = [elements[8*2+1].firstChild.content floatValue];
                float Ip = [elements[14*2+1].firstChild.content floatValue];
                float Baa = [elements[27*2+1].firstChild.content floatValue];
                float So9 = [elements[32*2+1].firstChild.content floatValue];
                float Bb9 = [elements[31*2+1].firstChild.content floatValue];
                float SoBb = [elements[33*2+1].firstChild.content floatValue];
                float HbpIp = [elements[17*2+1].firstChild.content floatValue] / Ip;
                float BAbip = [elements[29*2+1].firstChild.content floatValue];
                float HrH = [elements[18*2+1].firstChild.content floatValue] / [elements[15*2+1].firstChild.content floatValue];;
                float IpG = Ip / G;
                float Era = [elements[7*2+1].firstChild.content floatValue];
                float WL = [elements[6*2+1].firstChild.content floatValue];
                if ([pitcher.position isEqualToString:@"S"]) { //pitcher is starter
                    //                   MAX                           MIN     LOW  TO MAX  RANGE
                    pitcher.unhittable = MIN(@100, [NSNumber numberWithInt:100-(Baa-.205)*(35/.080)]); //Baa: 65 = .285, 100 = .205
                    pitcher.deception = MIN(@100, [NSNumber numberWithInt:100-(BAbip-.250)*(35/.080)]); //BAbip: 65 = .330, 100 = .250
                    pitcher.composure = MIN(@100, [NSNumber numberWithInt:100-(Era-2.3)*(35/2.7)]); //Era: 65 = 5.0, 100 = 2.3
                    pitcher.velocity = MIN(@100, [NSNumber numberWithInt:65+(So9-5.0)*(35/5.0)]); //So9: 65 = 5.0, 100 = 10.0
                    pitcher.accuracy = MIN(@100, [NSNumber numberWithInt:100-(Bb9-1.5)*(35/2.0)]); //Bb9: 65 = 3.5, 100 = 1.5
                }
                else { //pitcher is reliever or closer
                    pitcher.unhittable = MIN(@100, [NSNumber numberWithInt:100-(Baa-.155)*(35/.130)]); //Baa: 65 = .285, 100 = .155)
                    pitcher.deception = MIN(@100, [NSNumber numberWithInt:100-(BAbip-.220)*(35/.130)]); //BAbip: 65 = .350, 100 = .220
                    pitcher.composure = MIN(@100, [NSNumber numberWithInt:100-(Era-1.3)*(35/3.7)]); //Era: 65 = 5.0, 100 = 1.3
                    pitcher.velocity = MIN(@100, [NSNumber numberWithInt:65+(So9-5.0)*(35/8.0)]); //So9: 65 = 5.0, 100 = 13.0
                    pitcher.accuracy = MIN(@100, [NSNumber numberWithInt:100-(Bb9-1.5)*(35/3.3)]); //Bb9: 65 = 4.8, 100 = 1.5
                }
                pitcher.endurance = MIN(@100, [NSNumber numberWithInt:20+(IpG-1.0)*(80/5.5)]); //IpG: 20 = 1.0, 100 = 6.5
                [pitcher calculateOverall];
                pitcher.team = self;
                [self addPitchersObject:pitcher];
            }
        }
    }
    
    //NSLog(@"%@",self);
    NSLog(@"finished loading %@",abbrev);
}

- (void)addBattersObject:(BGBatter *)value {
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.batters];
    [tempSet addObject:value];
    self.batters = tempSet;
}

- (void)addPitchersObject:(BGPitcher *)value {
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.pitchers];
    [tempSet addObject:value];
    self.pitchers = tempSet;
}

@end
