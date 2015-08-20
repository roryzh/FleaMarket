//
//  BuyDetailViewController.m
//  FleaMarket
//
//  Created by RoryZhuang on 7/30/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import "BuyDetailViewController.h"
#import "FleaMarket-Swift.h"
#import <Firebase/Firebase.h>
#import "CreateItemViewController.h"
#define kshowEditSegue @"showEditSegue"



@interface BuyDetailViewController ()

@end

@implementation BuyDetailViewController

Firebase *myEditRef;


- (void)viewDidLoad {
    myEditRef = [[Firebase alloc] initWithUrl:@"https://intense-inferno-6787.firebaseio.com"];

    [super viewDidLoad];


    // Do any additional setup after loading the view.
    
    
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.itemTitle.text = self.item.itemTitle;
    
    NSDateFormatter* outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"MMM d, HH:mm:ss"];
    NSString* newDateString = [outputFormatter stringFromDate:self.item.itemDate];
    self.userdate.text = [NSString stringWithFormat: @"%@%@%@",self.item.itemOwner,@" at ",newDateString];
    self.desDisplay.text = self.item.itemDes;
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:kshowEditSegue]) {
        CreateItemViewController* civc = segue.destinationViewController;
        civc.item = self.item;
        civc.createFirebaseRef = myEditRef;
    }
    
}



- (IBAction)editButton:(id)sender {
    UIAlertController* errorEdit = [UIAlertController alertControllerWithTitle:@"Sorry, you cannot edit this post" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//    [errorEdit addAction:okAction];
    
    [[[myEditRef childByAppendingPath:@"users"] childByAppendingPath:[myEditRef authData].uid ]observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        //        NSLog(@"%@",[self.createFirebaseRef authData].uid);
        NSString* itemAuthOwner = snapshot.value[@"kerberosID"];
        NSString* itemOwner = self.item.itemOwner;
        NSLog(@"itemAuthOwner is %@",itemAuthOwner);
        NSLog(@"itemOwner is %@",itemOwner);
        //            NSDictionary* newItem = @{@"itemTitle" : self.itemTitle.text, @"itemDes" : self.itemDescription.text,@"itemDate" : kFirebaseServerValueTimestamp,@"itemType" : type, @"itemOwner" : snapshot.value[@"kerberosID"]};
        
        //[myRootRef.childByAutoId setValue:newItem];
        if([itemAuthOwner isEqualToString:itemOwner]){
//            Item* newItem = [[Item alloc] initWithKey:key itemTitle:itemTitle itemDes:itemDes itemDate:date itemOwner:itemOwner itemType: itemType ];
//            NSLog(@"Test");
//            
//            
//            
//            [self.myManagedItems addObject:newItem];
//            [self.myManagedItems sortUsingFunction:compareManagedDate2 context:nil];

            [self performSegueWithIdentifier:kshowEditSegue sender:nil];

        }
        else {
            [self presentViewController:errorEdit animated:YES completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                
                [errorEdit dismissViewControllerAnimated:YES completion:nil];
                
            });}
        //[self.tableView reloadData];
        
        
    }];
    
    
}
@end
