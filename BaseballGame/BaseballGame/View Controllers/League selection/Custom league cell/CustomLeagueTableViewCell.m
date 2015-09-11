//
//  CustomLeagueTableViewCell.m
//  BaseballGame
//
//  Created by Chappy Asel on 9/10/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "CustomLeagueTableViewCell.h"

@implementation CustomLeagueTableViewCell

- (void)awakeFromNib {
    self.editButton.layer.borderWidth = 2.0;
    self.editButton.layer.borderColor = (__bridge CGColorRef _Nullable)(self.editButton.tintColor);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)editButtonPressed:(UIButton *)sender {
    NSLog(@"EDIT");
}

@end
