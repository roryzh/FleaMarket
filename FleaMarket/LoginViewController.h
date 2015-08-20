//
//  LoginViewController.h
//  FleaMarket
//
//  Created by RoryZhuang on 8/16/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>


@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginButton:(id)sender;

- (IBAction)registerButton:(id)sender;
- (IBAction)forgotButton:(id)sender;

@end
