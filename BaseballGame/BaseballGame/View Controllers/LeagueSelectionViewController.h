//
//  LeagueSelectionViewController.h
//  BaseballGame
//
//  Created by Chappy Asel on 9/5/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeagueSelectionViewControllerDelegate <NSObject>
@required
- (void) leagueSelectionVCWillDismissWithSelectedLeague: (int) year;
@end

@interface LeagueSelectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,weak) id<LeagueSelectionViewControllerDelegate> delegate;

@end
