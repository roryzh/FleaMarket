//
//  ResetViewController.h
//  FleaMarket
//
//  Created by RoryZhuang on 8/18/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;

@property (weak, nonatomic) IBOutlet UITextField *nPass;
@property (weak, nonatomic) IBOutlet UITextField *nSecondPass;
- (IBAction)pressedReset:(id)sender;


@end
