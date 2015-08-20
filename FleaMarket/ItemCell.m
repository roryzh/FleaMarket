//
//  ItemCell.m
//  FleaMarket
//
//  Created by RoryZhuang on 7/28/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import "ItemCell.h"
#import "FleaMarket-Swift.h"


@implementation ItemCell

//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

- (void) _configureCellForItem:(Item*) item {

    
    self.itemTitle.text = item.itemTitle;
    self.owner.text = item.itemOwner;
    //self.date.text = @"2015/7/31";
    NSDateFormatter* outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"MMM d, HH:mm"];
    NSString* newDateString = [outputFormatter stringFromDate:item.itemDate];
    self.date.text = newDateString;
    
}
//- (void) _configureCellForItem:(Item *)item atIndexPath:(NSIndexPath *)indexPath {
//       self.itemTitle.text = item.title;
//       self.owner.text = item.user;
//       self.date.text = @"2015/7/31";
//
//}


@end
