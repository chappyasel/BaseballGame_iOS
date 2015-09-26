//
//  CreateTeamTableViewCell.m
//  BaseballGame
//
//  Created by Chappy Asel on 9/17/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "CreateTeamTableViewCell.h"

@implementation CreateTeamTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)detailsButtonPressed:(UIButton *)sender {
    [self.delegate shouldBeginEditingCusomTeamAtIndex:self.cellIndex];
}

@end
