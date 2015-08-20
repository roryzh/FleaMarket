//
//  ApplianceViewController.m
//  FleaMarket
//
//  Created by RoryZhuang on 8/18/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import "ApplianceViewController.h"
#import "SWRevealViewController.h"
#import "ItemCell.h"
#import "FleaMarket-Swift.h"
#import <Firebase/Firebase.h>
#import "BuyDetailViewController.h"

#define kShowDetailSegue @"ShowDetailSegue"

@interface ApplianceViewController ()
@property (nonatomic, strong) NSMutableArray* applianceItems;


@end

@implementation ApplianceViewController

Firebase *myApplianceRef;
Item* myApplianceItem;



- (void)viewDidLoad {
    myApplianceRef = [[Firebase alloc] initWithUrl:@"https://intense-inferno-6787.firebaseio.com/items"];

    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.applianceItems = [[NSMutableArray alloc] init];
    [myApplianceRef observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        
        
        
        NSString *key = snapshot.key;
        
        NSString *itemTitle = snapshot.value[@"itemTitle"];
        NSString *itemDes = snapshot.value[@"itemDes"];
        //NSDate* now = [NSDate date];
        NSNumber* number = snapshot.value[@"itemDate"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:number.longLongValue/1000];
        NSString* itemOwner = snapshot.value[@"itemOwner"];

                NSDateFormatter* outputFormatter = [[NSDateFormatter alloc] init];
                [outputFormatter setDateFormat:@"MMM d, HH:mm"];
                NSString* newDateString = [outputFormatter stringFromDate:date];
                NSLog(@"%@",newDateString);
        
        
        NSString *itemType = snapshot.value[@"itemType"];
        NSLog(@"%@",itemType);
        Item* newItem = [[Item alloc] initWithKey:key itemTitle:itemTitle itemDes:itemDes itemDate:date itemOwner:itemOwner itemType: itemType];
        
        // [myRootRef.ser];
        //NSLog(@"%d",FirebaseServerValue.kFirebaseServerValueTimestamp);
        //int* abc = FirebaseServerValue.kFirebaseServerValueTimestamp;
        
        //        NSLog(@"%@", key);
        //        NSLog(@"%@", itemTitle);
        //        NSLog(@"%@", itemDes);
        
        //newItem.user = @"zhuangr";
        
        if([itemType  isEqual: @"appliance"]){
            
            if(self.applianceItems.count < 1000){
            [self.applianceItems addObject:newItem];
            }
            [self.applianceItems sortUsingFunction:compareDateAppliance context:nil];
        }
        [self.tableView reloadData];
        
        // NSLog(@"%@",number);
        
    
    }];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
NSComparisonResult compareDateAppliance(id num1, id num2, void* context){
    
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
    return [self.applianceItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    
    ItemCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    Item* itemForRow = self.applianceItems[indexPath.row];
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
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //    Item* itemForRow = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //    myItem = itemForRow;
    //    if(itemForRow == nil) {
    //        NSLog(@"itemForRow is null");
    //    }
    
    Item* itemForRow = self.applianceItems[indexPath.row];
    myApplianceItem = itemForRow;
    
    if(itemForRow == nil) {
        NSLog(@"itemForRow is null");
    }
    
    [self performSegueWithIdentifier:kShowDetailSegue sender: itemForRow];
    
    
    
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:kShowDetailSegue]) {
        BuyDetailViewController* bdvc = segue.destinationViewController;
        [bdvc setItem: myApplianceItem];
        
    }
}


@end
