//
//  BuyViewController.h
//  FleaMarket
//
//  Created by RoryZhuang on 7/22/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <CoreData/CoreData.h>
#import "CreateItemViewController.h"
#import <Firebase/Firebase.h>

@interface BuyViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

//@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
- (IBAction)pressedAddItem:(id)sender;
- (IBAction)pressedSearch:(id)sender;



@end
