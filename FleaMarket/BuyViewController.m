//
//  BuyViewController.m
//  FleaMarket
//
//  Created by RoryZhuang on 7/22/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//
#import <Firebase/Firebase.h>
#import "BuyViewController.h"
#import "SWRevealViewController.h"
//#import "CoreDataUtils.h"
#import "ItemCell.h"
#define kCreateItemSegue @"CreateItemSegue"
#define kShowDetailSegue @"ShowDetailSegue"
#define kShowSeachResultSegue @"ShowSeachResultSegue"

#import "BuyDetailViewController.h"
#import "SearchViewController.h"


//#import "FleaMarket-Bridging-Header.h"
#import "FleaMarket-Swift.h"


@interface BuyViewController ()
@property (nonatomic, strong) NSMutableArray* items;
@property (nonatomic, strong) NSMutableArray* mySearchItems;


@end



@implementation BuyViewController

Firebase *myRootRef;
Item* myItem;
NSArray *sortedArray;
NSString* searchWord;


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
    myRootRef = [[Firebase alloc] initWithUrl:@"https://intense-inferno-6787.firebaseio.com"];
    
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
    
    
    self.items = [[NSMutableArray alloc] init];
    
    
    [[myRootRef childByAppendingPath:@"items"] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        
        
        
        NSString *key = snapshot.key;
        
        NSString *itemTitle = snapshot.value[@"itemTitle"];
        NSString *itemDes = snapshot.value[@"itemDes"];
        //NSDate* now = [NSDate date];
        NSString *itemType = snapshot.value[@"itemType"];
        
        
        NSNumber* number = snapshot.value[@"itemDate"];
        NSLog(@"%@",number);
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:number.longLongValue/1000];
        
        NSString* itemOwner = snapshot.value[@"itemOwner"];
        
                NSDateFormatter* outputFormatter = [[NSDateFormatter alloc] init];
                [outputFormatter setDateFormat:@"MMM d, HH:mm"];
                NSString* newDateString = [outputFormatter stringFromDate:date];
                NSLog(@"%@",newDateString);
        
        //        __block NSString *itemOwner;
        //        [[[myRootRef childByAppendingPath:@"users"] childByAppendingPath:[myRootRef authData].uid] observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        //            itemOwner = snapshot.value[@"kerberosID"];
        //
        //        }];
        
        
        Item* newItem = [[Item alloc] initWithKey:key itemTitle:itemTitle itemDes:itemDes itemDate:date itemOwner:itemOwner itemType: itemType ];
        
        
        if(self.items.count < 1000){
            [self.items addObject:newItem];
        }
        
        
        [self.items sortUsingFunction:compareDate context:nil];
        [self.tableView reloadData];
        
        
    }];
    [self.tableView reloadData];
    
    
    
}

NSComparisonResult compareDate(id num1, id num2, void* context){
    
    Item* item1 = num1;
    Item* item2 = num2;
    
    return [item2.itemDate compare:item1.itemDate];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    //NSLog(@"will appear");
    [self.tableView reloadData];
    
}

- (void) viewDidAppear:(BOOL)animated {
    //NSLog(@"did appear");
    [self.tableView reloadData];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
    //return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // return 1;
    //id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    //return [sectionInfo numberOfObjects];
    
    //    id  sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    //    return [sectionInfo numberOfObjects];
    //NSLog(@"%lu",(unsigned long)[self.items count]);
    return [self.items count];

    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    ItemCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    Item* itemForRow = self.items[indexPath.row];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    //Pass the selected object to the new view controller.

    if([segue.identifier isEqualToString:kShowDetailSegue]) {
        BuyDetailViewController* bdvc = segue.destinationViewController;
        [bdvc setItem: myItem];
        
    }
    if([segue.identifier isEqualToString:kCreateItemSegue]) {
        CreateItemViewController* civc = segue.destinationViewController;
        civc.createFirebaseRef = myRootRef;
        
        
    }
    if([segue.identifier isEqualToString:kShowSeachResultSegue]) {
        SearchViewController* svc = segue.destinationViewController;
        svc.searchItems = self.mySearchItems;
        
    }
}


//- (void) _configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//    Item* itemForRow = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    cell.textLabel.text = itemForRow.title;
////    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", (int)itemForRow.count];
//////    cell.accessoryType = (self.showRenameButtons ? UITableViewCellAccessoryDetailDisclosureButton : UITableViewCellAccessoryDisclosureIndicator);
//
//}

//#pragma mark - Fetched results controller
//
//- (NSFetchedResultsController *)fetchedResultsController
//{
//    if (_fetchedResultsController != nil) {
//        return _fetchedResultsController;
//    }
//
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    // Edit the entity name as appropriate.
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Item" inManagedObjectContext:[CoreDataUtils managedObjectContext]];
//
//    [fetchRequest setEntity:entity];
//
//    // Set the batch size to a suitable number.
//    [fetchRequest setFetchBatchSize:20];
//
//    // Edit the sort key as appropriate.
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:NO];
//    NSArray *sortDescriptors = @[sortDescriptor];
//
//    [fetchRequest setSortDescriptors:sortDescriptors];
//
//    // Edit the section name key path and cache name if appropriate.
//    // nil for section name key path means "no sections".
//    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[CoreDataUtils managedObjectContext] sectionNameKeyPath:nil cacheName:@"Items"];
//    aFetchedResultsController.delegate = self;
//    self.fetchedResultsController = aFetchedResultsController;
//
//    NSError *error = nil;
//    if (![self.fetchedResultsController performFetch:&error]) {
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }
//
//    return _fetchedResultsController;
//}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //    Item* itemForRow = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //    myItem = itemForRow;
    //    if(itemForRow == nil) {
    //        NSLog(@"itemForRow is null");
    //    }
    
    Item* itemForRow = self.items[indexPath.row];
    myItem = itemForRow;
    
    if(itemForRow == nil) {
        NSLog(@"itemForRow is null");
    }
    
    [self performSegueWithIdentifier:kShowDetailSegue sender: itemForRow];
    
    
    
    
}

- (IBAction)pressedAddItem:(id)sender {
    
    // delegate
    //    CreateItemViewController *createViewController = [[CreateItemViewController alloc] init];
    //    // Assign self as the delegate for the child view controller
    //    createViewController.delegate = self;
    
    
    
    
    [self performSegueWithIdentifier:kCreateItemSegue sender:nil];
    //[self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (IBAction)pressedSearch:(id)sender {
    UIAlertController* searchInfo = [UIAlertController alertControllerWithTitle:@"seach for?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [searchInfo addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Type in a word:";
    }];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //[self addItemWithType:@"electronic"];
        UITextField* textField = searchInfo.textFields.firstObject;
        searchWord = textField.text;
        [self searchString:searchWord];

    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [searchInfo addAction: okAction];
    [searchInfo addAction: cancelAction];
    [self presentViewController:searchInfo animated:YES completion:nil];

    
    
    
}

- (void)searchString :(NSString*) myString {
    self.mySearchItems = [[NSMutableArray alloc] init];
    
    for (Item* currentItem in self.items) {
        if([currentItem.itemTitle rangeOfString:myString].location == NSNotFound ){
            NSLog(@"Specific item is not there");
            
        }
        else {
            NSLog(@"Found");
            [self.mySearchItems addObject:currentItem];
        }
    }
    [self performSegueWithIdentifier:kShowSeachResultSegue sender:nil];

}

//try delegate
//- (void)createItemViewController {
//
//    // Do something with value...
//
//    NSLog(@"ABC");
//   // [self.tableView reloadData];
//    // ...then dismiss the child view controller
//   // [self.navigationController popViewControllerAnimated:YES];
//}
//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
//    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
//    [self.tableView beginUpdates];
//}


//- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
//
//    UITableView *tableView = self.tableView;
//
//    switch(type) {
//
//        case NSFetchedResultsChangeInsert:
//            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//
//        case NSFetchedResultsChangeDelete:
//            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//
//        case NSFetchedResultsChangeUpdate:
//            //[self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
//            [tableView cellForRowAtIndexPath:indexPath];
//            break;
//
//        case NSFetchedResultsChangeMove:
//            [tableView deleteRowsAtIndexPaths:[NSArray
//                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            [tableView insertRowsAtIndexPaths:[NSArray
//                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//    }
//}


//- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
//
//    switch(type) {
//
//        case NSFetchedResultsChangeInsert:
//            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//
//        case NSFetchedResultsChangeDelete:
//            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//    }
//}


//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
//    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
//    [self.tableView endUpdates];
//}



@end
