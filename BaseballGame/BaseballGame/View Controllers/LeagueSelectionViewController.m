//
//  LeagueSelectionViewController.m
//  BaseballGame
//
//  Created by Chappy Asel on 9/5/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "LeagueSelectionViewController.h"

@interface LeagueSelectionViewController ()

@end

@implementation LeagueSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillDisappear:(BOOL)animated {
    [self.delegate leagueSelectionVCWillDismissWithSelectedLeague:2000];
}

#pragma mark - tableView dataSource

@end
