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

- (void)loadTeamWithAbbrev: (NSString *) abbrev year: (int) year context: (NSManagedObjectContext *) context teamNameBlock:(void (^)(NSString *name))teamName{
    self.pitchers = [[NSOrderedSet alloc] init];
    self.batters = [[NSOrderedSet alloc] init];
    
    NSError *error;
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://baseball-reference.com/teams/%@/%d.shtml",abbrev,year]];
    NSData *html = [NSData dataWithContentsOfURL:url options:NSDataReadingMapped error:&error];
    if (error) NSLog(@"%@",error);
    TFHpple *parser = [TFHpple hppleWithHTMLData:html];
    
    NSString *tName = ((TFHppleElement *)[parser searchWithXPathQuery:@"//div[@id='info_box']/h1"].firstObject).content;
    teamName(tName);
    
    NSArray <TFHppleElement *> *playerTables = @[[parser searchWithXPathQuery:@"//table[@id='team_batting']/tbody"].firstObject,
                                                 [parser searchWithXPathQuery:@"//table[@id='team_pitching']/tbody"].firstObject,
                                                 [parser searchWithXPathQuery:@"//table[@id='players_value_batting']/tbody"].firstObject];
    
    NSMutableDictionary *dwarDict = [[NSMutableDictionary alloc] init];
    TFHppleElement *dwarTable = playerTables[2];
    NSArray *playersd = dwarTable.children;
    for (int i = 1; i < playersd.count; i += 2) {
        TFHppleElement *playerElement = playersd[i];
        NSArray <TFHppleElement *> *elements = playerElement.children;
        NSString *fullName = [self findContentForTFHppleElement:elements[0*2+1]];
        NSNumber *dwar = [NSNumber numberWithFloat: [elements[17*2+1].firstChild.content floatValue]];
        [dwarDict setValue:dwar forKey:[NSString stringWithFormat:@"%@ %@ %@ %@",[fullName substringToIndex:2],[fullName substringFromIndex:fullName.length-2],elements[3].firstChild.content,elements[5].firstChild.content]];
    }
    
    TFHppleElement *batterTable = playerTables[0];
    NSArray *playersb = batterTable.children;
    for (int i = 1; i < MIN(20*2, playersb.count); i += 2) {
        TFHppleElement *playerElement = playersb[i];
        NSArray <TFHppleElement *> *elements = playerElement.children;
        if (elements[5*2+1].firstChild.content.intValue > 130) { //PA > 130
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
            float RbiPa = [elements[12*2+1].firstChild.content floatValue] / Pa;
            float dwar = [[dwarDict objectForKey:[NSString stringWithFormat:@"%@ %@ %@ %@",[fullName substringToIndex:2],[fullName substringFromIndex:fullName.length-2],elements[7].firstChild.content,elements[9].firstChild.content]] floatValue];
            //Low: bottom 10 in league (130 PA), high: top 20 in league (qualified), max: top 25 SEASONS (qual, beyond 1901)
            batter.contact = [self ratingForStat:Avg minRating:64 low:.190 high:.305 max:.390];
            batter.power = [self ratingForStat:Slg minRating:64 low:.280 high:.540 max:.720];
            batter.speed = [self ratingForStat:SbG minRating:64 low:0.0/150 high:15.0/150 max:78.0/150];
            batter.vision = [self ratingForStat:BbPa minRating:64 low:.022 high:.120 max:.215];
            batter.clutch = [self ratingForStat:RbiPa minRating:64 low:30.0/450 high:80.0/520 max:165.0/660];//.08 .15 .25
            batter.fielding = [self ratingForStat:dwar minRating:64 low:-1.0 high:1.0 max:4.2];
            [batter calculateOverall];
            batter.team = self;
            [self addBattersObject:batter];
        }
    }
    
    TFHppleElement *pitcherTable = playerTables[1];
    NSArray *pitchers = pitcherTable.children;
    for (int i = 1; i < MIN(15*2+1, pitchers.count); i += 2) {
        TFHppleElement *playerElement = pitchers[i];
        NSArray <TFHppleElement *> *elements = playerElement.children;
        if ([self findContentForTFHppleElement:elements[1*2+1]] != nil &&
            (elements[8*2+1].firstChild.content.intValue > 18 && elements[14*2+1].firstChild.content.floatValue > 40)) {
            BGPitcher *pitcher = [NSEntityDescription insertNewObjectForEntityForName:@"BGPitcher" inManagedObjectContext:context];
            NSString *fullName = [self findContentForTFHppleElement:elements[2*2+1]];
            NSArray *nameArray = [fullName componentsSeparatedByString:@" "];
            pitcher.firstName = nameArray[0];
            pitcher.lastName = [fullName substringFromIndex:pitcher.firstName.length];
            pitcher.position = [self findContentForTFHppleElement:elements[1*2+1]];
            int G = [elements[8*2+1].firstChild.content intValue];
            float Ip = [elements[14*2+1].firstChild.content floatValue];
            int H = [elements[15*2+1].firstChild.content intValue];
            float Baa = (float)H / (Ip * 3 + H + elements[19*2+1].firstChild.content.intValue)  + .017; //need to fix
            //float Baa = [elements[27*2+1].firstChild.content floatValue];
            float So9 = [elements[32*2+1].firstChild.content floatValue];
            float Bb9 = [elements[31*2+1].firstChild.content floatValue];
            float SoBb = [elements[33*2+1].firstChild.content floatValue];
            float HbpIp = [elements[17*2+1].firstChild.content floatValue] / Ip;
            //float BAbip = [elements[29*2+1].firstChild.content floatValue];
            float Hr9 = [elements[30*2+1].firstChild.content floatValue];
            float IpG = Ip / G;
            float Era = [elements[7*2+1].firstChild.firstChild.content floatValue];
            float WL = [elements[6*2+1].firstChild.content floatValue];
            if ([pitcher.position isEqualToString:@"SP"]) { //pitcher is starter
                //qualification == (40 Ip, 18 starts (110 IP) for starters), beyond 1901
                //Low: bottom 15 in league, high: top 15 in league, max: top 15 indiv SEASONS all time
                pitcher.unhittable = [self ratingForStat:Baa minRating:64 low:.273 high:.220 max:.180];
                pitcher.deception = [self ratingForStat:Hr9 minRating:64 low:1.44 high:0.67 max:0.00];
                pitcher.composure = [self ratingForStat:Era minRating:64 low:4.8 high:2.6 max:1.25];
                pitcher.velocity = [self ratingForStat:So9 minRating:64 low:6.0 high:9.4 max:11.5];
                pitcher.accuracy = [self ratingForStat:Bb9 minRating:64 low:3.25 high:1.80 max:0.76];
            }
            else { //pitcher is RP or CL
                pitcher.unhittable = [self ratingForStat:Baa minRating:64 low:.275 high:.180 max:.140];
                pitcher.deception = [self ratingForStat:Hr9 minRating:64 low:1.35 high:0.34 max:0.00];
                pitcher.composure = [self ratingForStat:Era minRating:64 low:4.42 high:1.85 max:0.98];
                pitcher.velocity = [self ratingForStat:So9 minRating:64 low:6.0 high:11.32 max:14.7];
                pitcher.accuracy = [self ratingForStat:Bb9 minRating:64 low:4.25 high:1.7 max:0.85];
            }
            pitcher.endurance = [self ratingForStat:IpG minRating:18 low:0.8 high:6.3 max:8.3];
            [pitcher calculateOverall];
            pitcher.team = self;
            [self addPitchersObject:pitcher];
        }
    }
    [self calculateOveralls];
    
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

- (void)calculateOveralls {
    float batting = 0;
    float pitching = 0;
    for (BGBatter *b in self.batters) batting += b.overall.floatValue;
    for (BGPitcher *p in self.pitchers) pitching += p.overall.floatValue;
    self.info.battingOverall = [NSNumber numberWithInt:(batting / self.batters.count)];
    self.info.pitchingOverall = [NSNumber numberWithInt:(pitching / self.pitchers.count)];
    self.info.overall = [NSNumber numberWithInt: (batting + pitching) / (self.batters.count + self.pitchers.count)];
}

@end
