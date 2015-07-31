//
//  BuyViewController.m
//  FleaMarket
//
//  Created by RoryZhuang on 7/22/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import "BuyViewController.h"
#import "SWRevealViewController.h"
#import "Item.h"
#import "CoreDataUtils.h"
#import "ItemCell.h"
#define kCreateItemSegue @"CreateItemSegue"

@interface BuyViewController ()

@end

@implementation BuyViewController



//- (void) viewDidAppear:(BOOL) animated {
//    
//    Item* item1 = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:[CoreDataUtils managedObjectContext]];
//    item1.title = @"iphone6 for $1";
//    item1.user = @"zhuangr";
//    
//    Item* item2 = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:[CoreDataUtils managedObjectContext]];
//    item2.title = @"Audi A7 for $100";
//    item2.user = @"Hulmanrose";
//    
//    [CoreDataUtils saveContext];
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    //return 1;
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
   // return 1;
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
//    [self _configureCell:cell atIndexPath : indexPath];

    // Configure the cell...
    ItemCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    Item* itemForRow = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //[itemCell _configureCellForItem:cell atIndexPath : indexPath.row];
    [itemCell _configureCellForItem:itemForRow];

    return itemCell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

//- (void) _configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//    Item* itemForRow = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    cell.textLabel.text = itemForRow.title;
////    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", (int)itemForRow.count];
//////    cell.accessoryType = (self.showRenameButtons ? UITableViewCellAccessoryDetailDisclosureButton : UITableViewCellAccessoryDisclosureIndicator);
//    
//}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Item" inManagedObjectContext:[CoreDataUtils managedObjectContext]];

    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[CoreDataUtils managedObjectContext] sectionNameKeyPath:nil cacheName:@"Items"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

- (IBAction)pressedAddItem:(id)sender {
    [self performSegueWithIdentifier:kCreateItemSegue sender:nil];
}



@end
