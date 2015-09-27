//
//  CreateTeamViewController.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/26/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGTeamInfo.h"
#import "CreatePlayerTableViewCell.h"

@protocol CreateTeamViewControllerDelegate <NSObject>
@required
- (void) createTeamViewControllerWillDismissWithResultTeam: (BGTeamInfo *) team;
@end

@interface CreateTeamViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CreatePlayerTableViewCellDelegate>

@property id <CreateTeamViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *abbrevTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property BGTeamInfo *customTeam;

@end
