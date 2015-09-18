//
//  CreateTeamTableViewCell.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/17/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGTeamInfo.h"

@interface CreateTeamTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *abbrevLabel;

@property (weak, nonatomic) IBOutlet UILabel *pitchingLabel;
@property (weak, nonatomic) IBOutlet UILabel *battingLabel;

@property (weak, nonatomic) IBOutlet UILabel *overallLabel;

@end
