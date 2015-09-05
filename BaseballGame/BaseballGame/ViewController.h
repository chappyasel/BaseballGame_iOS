//
//  ViewController.h
//  BaseballGame
//
//  Created by Chappy Asel on 8/14/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"
#import "MGSwipeButton.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, MGSwipeTableCellDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property UITableView *tableView;
@property UISearchController *searchController;
@end

