//
//  CustomLeagueTableViewCell.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/10/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGLeagueInfo.h"

@protocol CustomLeagueTableViewCellDelegate <NSObject>
@required
- (void) shouldBeginEditingCusomLeague: (BGLeagueInfo *) league;
- (void) shouldDeleteCustomLeague: (BGLeagueInfo *) league;
@end

@interface CustomLeagueTableViewCell : UITableViewCell

@property BGLeagueInfo *customLeague;

@property (nonatomic,weak) id<CustomLeagueTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@property (weak, nonatomic) IBOutlet UILabel *textView;

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;

- (void)updateView;

@end
