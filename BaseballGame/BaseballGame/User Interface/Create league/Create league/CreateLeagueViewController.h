//
//  CreateLeagueViewController.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/12/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGLeagueInfo.h"
#import "CreateTeamTableViewCell.h"

@protocol CreateLeagueViewControllerDelegate <NSObject>
@required
- (void) createLeagueViewControllerWillDismissWithResultLeague: (BGLeagueInfo *) league;
@end

@interface CreateLeagueViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property id <CreateLeagueViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITableView *teamsTableView;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property BGLeagueInfo *customLeague;

@end
