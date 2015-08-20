//
//  BuyDetailViewController.h
//  FleaMarket
//
//  Created by RoryZhuang on 7/30/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;

@interface BuyDetailViewController : UIViewController

@property (nonatomic, strong) Item* item;


@property (weak, nonatomic) IBOutlet UILabel *itemTitle;

@property (weak, nonatomic) IBOutlet UILabel *userdate;
@property (weak, nonatomic) IBOutlet UITextView *desDisplay;

- (IBAction)editButton:(id)sender;

@end
