//
//  CreateItemViewController.m
//  FleaMarket
//
//  Created by RoryZhuang on 7/30/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import "CreateItemViewController.h"
#import "FleaMarket-Swift.h"
#import <Firebase/Firebase.h>
#define kShowManagedMyPostSegue  @"ShowManagedMyPostSegue"

//#import "CoreDataUtils.h"

@interface CreateItemViewController ()

@end

@implementation CreateItemViewController

NSString* itemString;
//NSString* type;



- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //self.itemTitle.delegate = self;
    
    if(self.item !=nil){
        itemString = self.item.itemTitle;
        self.itemTitle.text = self.item.itemTitle;
        self.itemDescription.text = self.item.itemDes;
        
        
    }
    [self.itemTitle becomeFirstResponder];
    [self.itemTitle addTarget:self action:@selector(editingTitleChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void) viewWillAppear:(BOOL)animated {
   // itemString = nil;
    [super viewWillAppear:animated];

    
    
    
}

-(void) editingTitleChanged:(id) sender {
    //itemString = nil;
    
    
    itemString = self.itemTitle.text;
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)pressedAddPhotos:(id)sender {
    NSLog(@"Why");
    [self.navigationController popViewControllerAnimated:YES];
    //[[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
    //[Controller dismissViewControllerAnimated: YES completion: nil];
}

- (IBAction)pressedDone:(id)sender {
    
//    if(self.item !=nil) {
//        
//        NSString* key = self.item.key;
//        NSLog(@"%@",key);
//        NSLog(@"why");
//        [self removeItem:key];
//    }
//    
    //Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://intense-inferno-6787.firebaseio.com/items"];
    
    
    if(itemString.length == 0)
    {
        UIAlertController* ac = [UIAlertController alertControllerWithTitle: @"Need a title for your item?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler: nil];
        [ac addAction:okAction];
        [self presentViewController:ac animated:YES completion:nil];
        
        
        
    }  else  {
        
        //    self.item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:[CoreDataUtils managedObjectContext]];
        //    self.item.title = self.itemTitle.text;
        //    //self.itemDescription.editable = YES;
        //    self.item.des = self.itemDescription.text;
        //    self.item.user = @"zhuangr";
        //
        //    NSDate* now = [NSDate date];
        //    self.item.date = now;
        
        //    [CoreDataUtils saveContext];
        
        //        id<CreateItemViewControllerDelegate> strongDelegate = self.delegate;
        //        //if ([strongDelegate respondsToSelector:@selector(createItemViewController:)]) {
        //            [strongDelegate createItemViewController];
        //       // }
        //[self.createFirebaseRef setValue:kFirebaseServerValueTimestamp];
        
        UIAlertController* acType = [UIAlertController alertControllerWithTitle: @"Which category does your item belong to?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [acType dismissViewControllerAnimated:YES completion:nil];
        }];

        UIAlertAction* applianceAction = [UIAlertAction actionWithTitle:@"Appliances" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self addItemWithType:@"appliance"];
        }];
        
        UIAlertAction* bookAction = [UIAlertAction actionWithTitle:@"Books" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self addItemWithType:@"book"];
        }];

        UIAlertAction* electronicAction = [UIAlertAction actionWithTitle:@"Electronics" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self addItemWithType:@"electronic"];
        }];
        
        UIAlertAction* rideAction = [UIAlertAction actionWithTitle:@"Rides" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self addItemWithType:@"ride"];
        }];
        UIAlertAction* vehicleAction = [UIAlertAction actionWithTitle:@"Vehicles" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self addItemWithType:@"vehicle"];
        }];
        UIAlertAction* otherAction = [UIAlertAction actionWithTitle:@"Others" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self addItemWithType:@"others"];
        }];
        
        [acType addAction:applianceAction];

        [acType addAction:bookAction];
        [acType addAction:electronicAction];
        [acType addAction:rideAction];
        [acType addAction:vehicleAction];
        [acType addAction:otherAction];
        [acType addAction: cancelAction];

        [self presentViewController:acType animated:YES completion:nil];
    }
    
    
    //        NSDictionary* newItem = @{@"itemTitle" : self.itemTitle.text, @"itemDes" : self.itemDescription.text,@"itemDate" : kFirebaseServerValueTimestamp,@"itemType" : type};
    //        //[myRootRef.childByAutoId setValue:newItem];
    //        [self.createFirebaseRef.childByAutoId setValue:newItem];
    
    
    //[self.navigationController popViewControllerAnimated:YES];
    
    
    
    
}

- (void) addItemWithType :(NSString*) type {
    
    if(self.item !=nil) {
        NSString* key = self.item.key;
        //Firebase* itemPosition = [[self.createFirebaseRef childByAppendingPath:@"items"] childByAppendingPath:key];

        NSLog(@"%@",key);
        NSLog(@"why");
        [self removeItem:key];

    }
    
    
    [[[self.createFirebaseRef childByAppendingPath:@"users"] childByAppendingPath:[self.createFirebaseRef authData].uid ]observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {

        
            NSDictionary* newItem = @{@"itemTitle" : self.itemTitle.text, @"itemDes" : self.itemDescription.text,@"itemDate" : kFirebaseServerValueTimestamp,@"itemType" : type, @"itemOwner" : snapshot.value[@"kerberosID"]};
        
            [[self.createFirebaseRef childByAppendingPath:@"items" ].childByAutoId setValue:newItem];
        
    }];
    
    if(self.item!=nil){
        [self performSegueWithIdentifier:kShowManagedMyPostSegue sender:nil];
    }
    else{
    [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
- (void) removeItem : (NSString*) key {
    
    [[[self.createFirebaseRef childByAppendingPath:@"items"] childByAppendingPath:key] removeValue];

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField*) textField {
    [textField resignFirstResponder];
    return YES;
}


@end
