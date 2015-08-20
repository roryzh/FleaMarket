//
//  RequestViewController.m
//  FleaMarket
//
//  Created by RoryZhuang on 7/22/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import "BookViewController.h"
#import "SWRevealViewController.h"
#import "ItemCell.h"
#import "FleaMarket-Swift.h"
#import "BuyDetailViewController.h"

#import <Firebase/Firebase.h>

#define kShowDetailSegue @"ShowDetailSegue"


@interface BookViewController ()
@property (nonatomic, strong) NSMutableArray* myItems;


@end

@implementation BookViewController

Firebase *myRootRefff;
Item* bookItem;



- (void)viewDidLoad {
    myRootRefff = [[Firebase alloc] initWithUrl:@"https://intense-inferno-6787.firebaseio.com/items"];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.myItems = [[NSMutableArray alloc] init];
    
    
    
    [myRootRefff observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        
        
        
        NSString *key = snapshot.key;
        
        NSString *itemTitle = snapshot.value[@"itemTitle"];
        NSString *itemDes = snapshot.value[@"itemDes"];
        NSString* itemOwner = snapshot.value[@"itemOwner"];

        //NSDate* now = [NSDate date];
        NSNumber* number = snapshot.value[@"itemDate"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:number.longLongValue/1000];
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
        
        if([itemType  isEqual: @"book"]){
        
        [self.myItems addObject:newItem];
        [self.myItems sortUsingFunction:compareDate2 context:nil];
        }
        [self.tableView reloadData];
        
        // NSLog(@"%@",number);
        
        
    }];
    //  NSLog(@"Test");
    //    NSSortDescriptor *sortDescriptor;
    //    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"itemDate"
    //                                                 ascending:NO];
    //    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    //    sortedArray = [self.items sortedArrayUsingDescriptors:sortDescriptors];
    
    
    
    [self.tableView reloadData];
    
}
NSComparisonResult compareDate2(id num1, id num2, void* context){
    
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
    return [self.myItems count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    //    [self _configureCell:cell atIndexPath : indexPath];
    
    // Configure the cell...
    
    //[itemCell _configureCellForItem:cell atIndexPath : indexPath.row];
    
    //    ItemCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    //    Item* itemForRow = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //    [itemCell _configureCellForItem:itemForRow];
    //
    //    return itemCell;
    
    ItemCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    Item* itemForRow = self.myItems[indexPath.row];
    [itemCell _configureCellForItem:itemForRow];
    
    return itemCell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //    Item* itemForRow = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //    myItem = itemForRow;
    //    if(itemForRow == nil) {
    //        NSLog(@"itemForRow is null");
    //    }

    
    Item* itemForRow = self.myItems[indexPath.row];
    bookItem = itemForRow;
    
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
        [bdvc setItem: bookItem];
        
    }
}


@end
