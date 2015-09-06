//
//  PlayerTableViewCell.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/6/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGBatter.h"
#import "BGPitcher.h"
#import "MGSwipeTableCell.h"
#import "MGSwipeButton.h"

@interface PlayerTableViewCell : MGSwipeTableCell

@property (weak, nonatomic) IBOutlet UIImageView *playerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *overallLabel;
@property (weak, nonatomic) IBOutlet UILabel *statLabel1;
@property (weak, nonatomic) IBOutlet UILabel *statLabel2;
@property (weak, nonatomic) IBOutlet UILabel *statLabel3;
@property (weak, nonatomic) IBOutlet UILabel *statLabel4;
@property (weak, nonatomic) IBOutlet UILabel *statLabel5;
@property (weak, nonatomic) IBOutlet UILabel *statLabel6;

- (void)loadPlayer: (id) player;

@end
