//
//  CreateItemViewController.m
//  FleaMarket
//
//  Created by RoryZhuang on 7/30/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import "CreateItemViewController.h"
#import "Item.h"

@interface CreateItemViewController ()

@end

@implementation CreateItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.itemTitle.delegate = self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.itemTitle becomeFirstResponder];
    

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
}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField*) textField {
    [textField resignFirstResponder];
    return YES;
}


@end
