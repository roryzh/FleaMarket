//
//  CreateItemViewController.h
//  FleaMarket
//
//  Created by RoryZhuang on 7/30/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;

@interface CreateItemViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) Item* item;
@property (weak, nonatomic) IBOutlet UITextField *itemTitle;
@property (weak, nonatomic) IBOutlet UITextView *itemDescription;
- (IBAction)pressedAddPhotos:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *pressedDone;

@end
