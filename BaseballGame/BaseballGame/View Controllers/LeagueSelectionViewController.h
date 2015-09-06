//
//  LeagueSelectionViewController.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/5/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"
#import "MGSwipeButton.h"
#import <DownloadButton/PKDownloadButton.h>

@class BGLeagueInfo, BGLeagueController;

@protocol LeagueSelectionViewControllerDelegate <NSObject>
@required
- (void) leagueSelectionVCWillDismissWithSelectedLeague: (BGLeagueInfo *) league;
@end

@interface LeagueSelectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate, PKDownloadButtonDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,weak) id<LeagueSelectionViewControllerDelegate> delegate;

@property (nonatomic,strong) BGLeagueController *leagueController;

@property NSNumber *selectedYear;

@end
