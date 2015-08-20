//
//  ManageViewController.m
//  FleaMarket
//
//  Created by RoryZhuang on 8/17/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import "ManageViewController.h"
#import "SWRevealViewController.h"
#import "ItemCell.h"
#import <Firebase/Firebase.h>
#import "FleaMarket-Swift.h"
#define kshowCreateItemSegue @"showCreateItemSegue"
#define kShowDetailSegue @"ShowDetailSegue"
#define kShowSearchResultSegue @"ShowSearchResultSegue"
#import "BuyDetailViewController.h"
#import "CreateItemViewController.h"
#import "SearchViewController.h"




@interface ManageViewController ()
@property (nonatomic, strong) NSMutableArray* myManagedItems;
@property (nonatomic, strong) NSMutableArray* mySearchManagedItems;



@end

@implementation ManageViewController
Item* myManagedItem;
NSString* searchWordManagedItems;

Firebase *myManageRef;


- (void)viewDidLoad {
    myManageRef = [[Firebase alloc] initWithUrl:@"https://intense-inferno-6787.firebaseio.com"];
    
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if (revealViewController)
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.myManagedItems = [[NSMutableArray alloc] init];
    [[myManageRef childByAppendingPath:@"items"] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        
        
        
        NSString *key = snapshot.key;
        
        NSString *itemTitle = snapshot.value[@"itemTitle"];
        NSString *itemDes = snapshot.value[@"itemDes"];
        //NSDate* now = [NSDate date];
        NSString *itemType = snapshot.value[@"itemType"];
        
        
        NSNumber* number = snapshot.value[@"itemDate"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:number.longValue/1000];
        
        NSString* itemOwner = snapshot.value[@"itemOwner"];
        //        NSDateFormatter* outputFormatter = [[NSDateFormatter alloc] init];
        //        [outputFormatter setDateFormat:@"MMM d, HH:mm"];
        //        NSString* newDateString = [outputFormatter stringFromDate:date];
        //        NSLog(@"%@",newDateString);
        
        //        __block NSString *itemOwner;
        //        [[[myRootRef childByAppendingPath:@"users"] childByAppendingPath:[myRootRef authData].uid] observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        //            itemOwner = snapshot.value[@"kerberosID"];
        //
        //        }];
        
        
        
        
        [[[myManageRef childByAppendingPath:@"users"] childByAppendingPath:[myManageRef authData].uid ]observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            
            //        NSLog(@"%@",[self.createFirebaseRef authData].uid);
            NSString* itemAuthOwner = snapshot.value[@"kerberosID"];
            
            NSLog(@"itemAuthOwner is %@",itemAuthOwner);
            NSLog(@"itemOwner is %@",itemOwner);
            //            NSDictionary* newItem = @{@"itemTitle" : self.itemTitle.text, @"itemDes" : self.itemDescription.text,@"itemDate" : kFirebaseServerValueTimestamp,@"itemType" : type, @"itemOwner" : snapshot.value[@"kerberosID"]};
            
            //[myRootRef.childByAutoId setValue:newItem];
            if([itemAuthOwner isEqualToString:itemOwner]){
                Item* newItem = [[Item alloc] initWithKey:key itemTitle:itemTitle itemDes:itemDes itemDate:date itemOwner:itemOwner itemType: itemType ];
                NSLog(@"Test");
                
                
                if(self.myManagedItems.count < 1000){
                [self.myManagedItems addObject:newItem];
                }
                [self.myManagedItems sortUsingFunction:compareManagedDate2 context:nil];
            }
            [self.tableView reloadData];
            
            
        }];
        
        
        [self.tableView reloadData];
        
        
    }];
    
    //
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView reloadData];
    
}
NSComparisonResult compareManagedDate2(id num1, id num2, void* context){
    
    Item* item1 = num1;
    Item* item2 = num2;
    
    return [item2.itemDate compare:item1.itemDate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.myManagedItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ItemCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    Item* itemForRow = self.myManagedItems[indexPath.row];
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSString* key = [self.myManagedItems[indexPath.row] key];
        NSLog(@"%@",key);
        //[_myManagedItems delete:_myManagedItems[indexPath.row]];

        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        //[[[myManageRef childByAppendingPath:@"items"] childByAppendingPath:key] removeValue];
        [self.myManagedItems removeObjectAtIndex:indexPath.row];
        //Item* a = self.myManagedItems[indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [[[myManageRef childByAppendingPath:@"items"] childByAppendingPath:key] removeValue];

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    Item* itemForRow = self.myManagedItems[indexPath.row];
    myManagedItem = itemForRow;
    
    if(itemForRow == nil) {
        NSLog(@"itemForRow is null");
    }
    
    [self performSegueWithIdentifier:kShowDetailSegue sender: itemForRow];
    
    
    
    
}


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
 // Pass the selected object to the new view controller.
     
     if([segue.identifier isEqualToString:kShowDetailSegue]) {
         BuyDetailViewController* bdvc = segue.destinationViewController;
         [bdvc setItem: myManagedItem];
         
     }
     if([segue.identifier isEqualToString:kshowCreateItemSegue]) {
         CreateItemViewController* civc = segue.destinationViewController;
         civc.createFirebaseRef = myManageRef;
         
         
     }
     if([segue.identifier isEqualToString:kShowSearchResultSegue]) {
         SearchViewController* svc = segue.destinationViewController;
         svc.searchItems = self.mySearchManagedItems;
         
     }
 }


- (IBAction)pressedAdd:(id)sender {
    [self performSegueWithIdentifier:kshowCreateItemSegue sender:nil];
}

- (IBAction)pressedSearchButton:(id)sender {
    
    UIAlertController* searchInfo = [UIAlertController alertControllerWithTitle:@"seach for?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [searchInfo addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Type in a word:";
    }];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField* textField = searchInfo.textFields.firstObject;
        searchWordManagedItems = textField.text;
        [self searchString:searchWordManagedItems];
        
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [searchInfo addAction: okAction];
    [searchInfo addAction: cancelAction];
    [self presentViewController:searchInfo animated:YES completion:nil];
}
- (void)searchString :(NSString*) myString {
    self.mySearchManagedItems = [[NSMutableArray alloc] init];
    
    for (Item* currentItem in self.myManagedItems) {
        if([currentItem.itemTitle rangeOfString:myString].location == NSNotFound ){
            NSLog(@"Specific item is not there");
            
        }
        else {
            NSLog(@"Found");
            [self.mySearchManagedItems addObject:currentItem];
        }
    }
    [self performSegueWithIdentifier:kShowSearchResultSegue sender:nil];
    
}
@end
