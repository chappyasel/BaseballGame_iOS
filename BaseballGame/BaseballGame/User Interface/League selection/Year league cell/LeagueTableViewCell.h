//
//  LeagueTableViewCell.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/6/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKDownloadButton.h"

@class BGLeagueController;

@interface LeagueTableViewCell : UITableViewCell <PKDownloadButtonDelegate>

@property (weak, nonatomic) BGLeagueController *leagueController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property NSNumber *year;
@property BOOL isDownloaded;

@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@property (weak, nonatomic) IBOutlet UILabel *textView;
@property (weak, nonatomic) IBOutlet PKDownloadButton *downloadButton;

- (void)updateDownloaded;

@end
