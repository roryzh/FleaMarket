//
//  BuyViewController.h
//  FleaMarket
//
//  Created by RoryZhuang on 7/22/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface BuyViewController : UITableViewController <NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
- (IBAction)pressedAddItem:(id)sender;



@end
