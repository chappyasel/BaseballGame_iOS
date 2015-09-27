//
//  CreatePlayerTableViewCell.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/26/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGBatter.h"
#import "BGPitcher.h"

@protocol CreatePlayerTableViewCellDelegate <NSObject>
@required
- (void) shouldBeginEditingCusomPlayer: (id) player;
@end

@interface CreatePlayerTableViewCell : UITableViewCell

@property id <CreatePlayerTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *overallLabel;
@property (weak, nonatomic) IBOutlet UILabel *statLabel1;
@property (weak, nonatomic) IBOutlet UILabel *statLabel2;
@property (weak, nonatomic) IBOutlet UILabel *statLabel3;
@property (weak, nonatomic) IBOutlet UILabel *statLabel4;
@property (weak, nonatomic) IBOutlet UILabel *statLabel5;
@property (weak, nonatomic) IBOutlet UILabel *statLabel6;

- (void)loadCustomPlayer: (id) player;

@property (weak, nonatomic) id customPlayer;

@end
