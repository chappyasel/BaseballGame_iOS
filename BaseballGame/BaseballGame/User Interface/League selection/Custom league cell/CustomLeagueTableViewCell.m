//
//  CustomLeagueTableViewCell.m
//  BaseballGame
//
//  Created by Chappy Asel on 9/10/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "CustomLeagueTableViewCell.h"

@protocol CustomLeagueTableViewCellDelegate <NSObject>
@required
- (void) leagueSelectionVCDidChangeSelectedLeague: (BGLeagueInfo *) league;
@end

@implementation CustomLeagueTableViewCell

- (void)awakeFromNib {
    
}

- (void)updateView {
    self.editButton.layer.borderWidth = 1.0;
    self.editButton.layer.borderColor = [[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] CGColor];
    self.editButton.layer.cornerRadius = 5.0;
    self.removeButton.layer.borderWidth = 1.0;
    self.removeButton.layer.borderColor = [[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] CGColor];
    self.removeButton.layer.cornerRadius = 5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
    if (selected) {
        self.checkImageView.image = [UIImage imageNamed:@"check.png"];
    }
    else {
        self.checkImageView.image = [UIImage imageNamed:@"select_empty.png"];
    }
}

- (IBAction)editButtonPressed:(UIButton *)sender {
    [self.delegate shouldBeginEditingCusomLeague:self.customLeague];
}

- (IBAction)removeButtonPressed:(UIButton *)sender {
    [self.delegate shouldDeleteCustomLeague:self.customLeague];
}

@end
