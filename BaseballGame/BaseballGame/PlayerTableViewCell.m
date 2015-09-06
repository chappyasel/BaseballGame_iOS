//
//  PlayerTableViewCell.m
//  BaseballGame
//
//  Created by Chappy Asel on 9/6/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "PlayerTableViewCell.h"

@implementation PlayerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadPlayer:(id)player {
    int rating = 0;
    if ([player isKindOfClass:[BGBatter class]]) {
        BGBatter *batter = (BGBatter *)player;
        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",batter.firstName, batter.lastName];
        self.statLabel1.text = [NSString stringWithFormat:@"CNT: %@",batter.contact];
        self.statLabel2.text = [NSString stringWithFormat:@"PWR: %@",batter.power];
        self.statLabel3.text = [NSString stringWithFormat:@"SPD: %@",batter.speed];
        self.statLabel4.text = [NSString stringWithFormat:@"VSN: %@",batter.vision];
        self.statLabel5.text = [NSString stringWithFormat:@"CLH: %@",batter.clutch];
        self.statLabel6.text = [NSString stringWithFormat:@"FLD: %@",batter.fielding];
        rating = batter.overall.intValue;
    }
    else if ([player isKindOfClass:[BGPitcher class]]) {
        BGPitcher *pitcher = (BGPitcher *)player;
        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",pitcher.firstName, pitcher.lastName];
        self.statLabel1.text = [NSString stringWithFormat:@"UHT: %@",pitcher.unhittable];
        self.statLabel2.text = [NSString stringWithFormat:@"DCP: %@",pitcher.deception];
        self.statLabel3.text = [NSString stringWithFormat:@"CMP: %@",pitcher.composure];
        self.statLabel4.text = [NSString stringWithFormat:@"VEL: %@",pitcher.velocity];
        self.statLabel5.text = [NSString stringWithFormat:@"ACC: %@",pitcher.accuracy];
        self.statLabel6.text = [NSString stringWithFormat:@"EDC: %@",pitcher.endurance];
        rating = pitcher.overall.intValue;
    }
    else NSLog(@"Passed player object is not batter or pitcher class");
    
    if (rating <= 72) { //bronze
        self.ratingImageView.backgroundColor = [UIColor colorWithRed:182/255.0 green:111/255.0 blue:0/255.0 alpha:1.0];
    }
    else if (rating <= 80) { //silver
        self.ratingImageView.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0];
    }
    else if (rating <= 85) { //gold
        self.ratingImageView.backgroundColor = [UIColor colorWithRed:210/255.0 green:190/255.0 blue:0/255.0 alpha:1.0];
    }
    else if (rating <= 95) { //blue
        self.ratingImageView.backgroundColor = [UIColor colorWithRed:0/255.0 green:170/255.0 blue:255/255.0 alpha:1.0];
    }
    else { //red (legend)
        self.ratingImageView.backgroundColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    }
    self.overallLabel.text = [NSString stringWithFormat:@"%d",rating];
    
    MGSwipeExpansionSettings *settings = [[MGSwipeExpansionSettings alloc] init];
    settings.buttonIndex = 0;
    settings.threshold = 1.4;
    self.leftExpansion = settings;
    
    self.leftButtons = @[[MGSwipeButton buttonWithTitle:@"Player Details" icon:nil backgroundColor:self.ratingImageView.backgroundColor]];
    self.leftSwipeSettings.transition = MGSwipeTransitionClipCenter;
}

@end
