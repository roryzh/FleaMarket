//
//  ManageViewController.h
//  FleaMarket
//
//  Created by RoryZhuang on 8/17/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
- (IBAction)pressedAdd:(id)sender;

- (IBAction)pressedSearchButton:(id)sender;


@end
