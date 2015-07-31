//
//  ItemCell.h
//  FleaMarket
//
//  Created by RoryZhuang on 7/30/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;

@interface ItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *owner;
@property (weak, nonatomic) IBOutlet UILabel *date;

- (void) _configureCellForItem:(Item*) item;

@end
