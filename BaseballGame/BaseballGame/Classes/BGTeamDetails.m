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
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://baseball-reference.com/teams/%@/%d.shtml",abbrev,year]];
    NSData *html = [NSData dataWithContentsOfURL:url options:NSDataReadingMapped error:&error];
    if (error) NSLog(@"%@",error);
    TFHpple *parser = [TFHpple hppleWithHTMLData:html];
    
    NSString *XpathQueryString = @"//div[@id='page_content']/div";
    NSArray *nodes = [parser searchWithXPathQuery:XpathQueryString];
    NSArray *playerTables = @[nodes[7], nodes[10], nodes[13]];
    NSMutableDictionary *dwarDict = [[NSMutableDictionary alloc] init];
    TFHppleElement *dwarTable = playerTables[2];
    NSArray *playersd = ((TFHppleElement *)((TFHppleElement *)((TFHppleElement *)dwarTable.children[3]).children[1]).children[2*2+1]).children;
    for (int i = 1; i < playersd.count; i += 2) {
        TFHppleElement *playerElement = playersd[i];
        NSArray <TFHppleElement *> *elements = playerElement.children;
        NSString *fullName = [self findContentForTFHppleElement:elements[0*2+1]];
        NSNumber *dwar = [NSNumber numberWithFloat: [elements[17*2+1].firstChild.content floatValue]];
        [dwarDict setValue:dwar forKey:[NSString stringWithFormat:@"%@ %@ %@ %@",[fullName substringToIndex:2],[fullName substringFromIndex:fullName.length-2],elements[3].firstChild.content,elements[5].firstChild.content]];
    }
    
    TFHppleElement *batterTable = playerTables[0];
    NSArray *playersb = ((TFHppleElement *)((TFHppleElement *)((TFHppleElement *)batterTable.children[3]).children[1]).children[2*2+1]).children;
    for (int i = 1; i < MIN(20*2, playersb.count); i += 2) {
        TFHppleElement *playerElement = playersb[i];
        NSArray <TFHppleElement *> *elements = playerElement.children;
        if (elements[5*2+1].firstChild.content.intValue > 100) { //PA > 100
            BGBatter *batter = [NSEntityDescription insertNewObjectForEntityForName:@"BGBatter" inManagedObjectContext:context];
            NSString *fullName = [self findContentForTFHppleElement:elements[2*2+1]];
            NSArray *nameArray = [fullName componentsSeparatedByString:@" "];
            batter.firstName = nameArray[0];
            batter.lastName = [fullName substringFromIndex:batter.firstName.length];
            batter.position = [self findContentForTFHppleElement:elements[1*2+1]];
            float Avg = [elements[17*2+1].firstChild.content floatValue];
            int G = [elements[4*2+1].firstChild.content intValue];
            int Ab = [elements[6*2+1].firstChild.content intValue];
            int Pa = [elements[5*2+1].firstChild.content intValue];
            float SoPa = [elements[16*2+1].firstChild.content floatValue] / Pa;
            float BbPa = [elements[15*2+1].firstChild.content floatValue] / Pa;
            float Slg = [elements[19*2+1].firstChild.content floatValue];
            float SbG = [elements[13*2+1].firstChild.content floatValue] / G;
            float csG = [elements[14*2+1].firstChild.content floatValue] / G;
            float TbAb = [elements[10*2+1].firstChild.content floatValue] / Ab;
            float GdpAb = [elements[22*2+1].firstChild.content floatValue] / Ab;
            float RRbiAb = ([elements[12*2+1].firstChild.content floatValue] - [elements[11*2+1].content floatValue]) / Ab;
            float dwar = [[dwarDict objectForKey:[NSString stringWithFormat:@"%@ %@ %@ %@",[fullName substringToIndex:2],[fullName substringFromIndex:fullName.length-2],elements[7].firstChild.content,elements[9].firstChild.content]] floatValue];
            //Low: bottom 10 in league (qualified), high: top 15 in league (qualified), max: top 10 individual players all time (beyond 1901)
            batter.contact = [self ratingForStat:Avg minRating:64 low:.230 high:.310 max:.390];
            batter.power = [self ratingForStat:Slg minRating:64 low:.345 high:.520 max:.730];
            batter.speed = [self ratingForStat:SbG minRating:64 low:0.0/150 high:25.0/150 max:80.0/150];
            batter.vision = [self ratingForStat:BbPa minRating:64 low:.040 high:.120 max:.215];
            batter.clutch = [self ratingForStat:RRbiAb minRating:64 low:40.0/560 high:75.0/560 max:120.0/560];//.065 .122 .2
            batter.fielding = [self ratingForStat:dwar minRating:64 low:-1.2 high:1.5 max:4.3];
            [batter calculateOverall];
            batter.team = self;
            [self addBattersObject:batter];
        }
    }
    
    TFHppleElement *pitcherTable = playerTables[1];
    NSArray *pitchers = ((TFHppleElement *)((TFHppleElement *)((TFHppleElement *)pitcherTable.children[3]).children[1]).children[2*2+1]).children;
    for (int i = 1; i < MIN(15*2+1, pitchers.count); i += 2) {
        TFHppleElement *playerElement = pitchers[i];
        NSArray <TFHppleElement *> *elements = playerElement.children;
        if (elements[8*2+1].firstChild.content.intValue > 10 && elements[14*2+1].firstChild.content.floatValue > 25 &&
            [self findContentForTFHppleElement:elements[1*2+1]] != nil) {
            BGPitcher *pitcher = [NSEntityDescription insertNewObjectForEntityForName:@"BGPitcher" inManagedObjectContext:context];
            NSString *fullName = [self findContentForTFHppleElement:elements[2*2+1]];
            NSArray *nameArray = [fullName componentsSeparatedByString:@" "];
            pitcher.firstName = nameArray[0];
            pitcher.lastName = [fullName substringFromIndex:pitcher.firstName.length];
            pitcher.position = [self findContentForTFHppleElement:elements[1*2+1]];
            int G = [elements[8*2+1].firstChild.content intValue];
            float Ip = [elements[14*2+1].firstChild.content floatValue];
            int H = [elements[15*2+1].firstChild.content intValue];
            float Baa = (float)H / (Ip * 3 + H + elements[19*2+1].firstChild.content.intValue);
            //float Baa = [elements[27*2+1].firstChild.content floatValue];
            float So9 = [elements[32*2+1].firstChild.content floatValue];
            float Bb9 = [elements[31*2+1].firstChild.content floatValue];
            float SoBb = [elements[33*2+1].firstChild.content floatValue];
            float HbpIp = [elements[17*2+1].firstChild.content floatValue] / Ip;
            //float BAbip = [elements[29*2+1].firstChild.content floatValue];
            float HrH = [elements[18*2+1].firstChild.content floatValue] / H;
            float IpG = Ip / G;
            float Era = [elements[7*2+1].firstChild.firstChild.content floatValue];
            float WL = [elements[6*2+1].firstChild.content floatValue];
            if ([pitcher.position isEqualToString:@"SP"]) { //pitcher is starter
                //Low: bottom 10 in league (qualified), high: top 15 in league (qualified), max: top 10 individual players all time
                pitcher.unhittable = [self ratingForStat:Baa minRating:64 low:.275 high:.225 max:.180];
                pitcher.deception = [self ratingForStat:Baa /* */ minRating:64 low:0 high:0 max:0]; //BAbip: 65 = .330, 100 = .250
                pitcher.composure = [self ratingForStat:Era minRating:64 low:4.8 high:2.8 max:1.25];
                pitcher.velocity = [self ratingForStat:So9 minRating:64 low:6.0 high:9.2 max:11.1];
                pitcher.accuracy = [self ratingForStat:Bb9 minRating:64 low:3.3 high:1.85 max:0.8];
            }
            else { //pitcher is RP or CL
                pitcher.unhittable = [self ratingForStat:Baa minRating:64 low:.280 high:.180 max:.140];
                pitcher.deception = [self ratingForStat:Baa /* */ minRating:64 low:-1.2 high:1.5 max:4.3]; //BAbip: 65 = .350, 100 = .220
                pitcher.composure = [self ratingForStat:Era minRating:64 low:4.55 high:1.9 max:1.0];
                pitcher.velocity = [self ratingForStat:So9 minRating:64 low:5.5 high:11.3 max:14.7];
                pitcher.accuracy = [self ratingForStat:Bb9 minRating:64 low:4.5 high:1.7 max:0.9];
            }
            pitcher.endurance = [self ratingForStat:IpG minRating:10 low:0.5 high:6.0 max:8.2];
            [pitcher calculateOverall];
            pitcher.team = self;
            [self addPitchersObject:pitcher];
        }
    }
    
    //NSLog(@"%@",self);
    NSLog(@"finished loading %@",abbrev);
}

- (NSString *)findContentForTFHppleElement: (TFHppleElement *)element {
    while (element.hasChildren) {
        if (element.content != nil) return element.content;
        element = element.firstChild;
    }
    if (element.content != nil) return element.content;
    return nil;
}

- (NSNumber *)ratingForStat: (float) stat minRating: (int)min low: (float)low high: (float)high max: (float)max {
    if (max < low) {
        if (stat <= max) return @99;
        if (stat <= high) return [NSNumber numberWithInt:90 + (stat-max)*(9.0/(high-max))];
        if (stat <= low) return [NSNumber numberWithInt:min + (stat-high)*((90.0-min)/(low-high))];
        return [NSNumber numberWithInt:min];
    }
    if (stat <= low) return [NSNumber numberWithInt:min];
    if (stat <= high) return [NSNumber numberWithInt:min + (stat-low)*((90-min)/(high-low))];
    if (stat <= max) return [NSNumber numberWithInt:90 + (stat-high)*(9/(max-high))];
    return @99;
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
