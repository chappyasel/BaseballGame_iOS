//
//  CreateTeamViewController.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/26/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGTeamInfo.h"

@protocol CreateTeamViewControllerDelegate <NSObject>
@required
- (void) createTeamViewControllerWillDismissWithResultTeam: (BGTeamInfo *) team;
@end

@interface CreateTeamViewController : UIViewController

@property id <CreateTeamViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UISwitch *loadExistingSwitch;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property BGTeamInfo *customTeam;

@end
