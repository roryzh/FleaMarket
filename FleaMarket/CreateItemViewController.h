//
//  CreateItemViewController.h
//  FleaMarket
//
//  Created by RoryZhuang on 7/30/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@class Item;

@protocol CreateItemViewControllerDelegate;

@interface CreateItemViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) Item* item;
@property (weak, nonatomic) IBOutlet UITextField *itemTitle;
@property (weak, nonatomic) IBOutlet UITextView *itemDescription;

//@property (nonatomic, weak) id<CreateItemViewControllerDelegate> delegate;
@property (weak, nonatomic) Firebase* createFirebaseRef;

- (IBAction)pressedAddPhotos:(id)sender;

- (IBAction)pressedDone:(id)sender;

@end


//@protocol CreateItemViewControllerDelegate <NSObject>
//
//- (void)createItemViewController;

//@end
