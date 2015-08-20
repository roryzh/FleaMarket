//
//  ResetViewController.m
//  FleaMarket
//
//  Created by RoryZhuang on 8/18/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import "ResetViewController.h"
#import "SWRevealViewController.h"

#import <Firebase/Firebase.h>

@interface ResetViewController ()

@end

@implementation ResetViewController
Firebase *myResetRef;


- (void)viewDidLoad {
    myResetRef = [[Firebase alloc] initWithUrl:@"https://intense-inferno-6787.firebaseio.com/"];

    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pressedReset:(id)sender {
    
    UIAlertController* errorTwoNotEqual = [UIAlertController alertControllerWithTitle:@"Please check that your passwords match and try again" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [errorTwoNotEqual addAction:okAction];
    
    UIAlertController* resetSuccess = [UIAlertController alertControllerWithTitle:@"Your password has been changed successfully" message:nil preferredStyle:UIAlertControllerStyleAlert];

    
    
    if([self.nPass.text isEqual:self.nSecondPass.text]){
        NSString* userName = [NSString stringWithFormat:@"%@@rose-hulman.edu", self.userName.text];
        [myResetRef changePasswordForUser:userName fromOld:self.oldPassword.text
                                    toNew:self.nSecondPass.text withCompletionBlock:^(NSError *error) {
                                        if (error) {
                                            
                                        } else {
                                            // Password changed successfully
                                            [self presentViewController:resetSuccess animated:YES completion:nil];
                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                
                                                
                                                [resetSuccess dismissViewControllerAnimated:YES completion:nil];
                                                
                                            });
                                            
                                        }
                                    }];
    
    } else {
        [self presentViewController:errorTwoNotEqual animated:YES completion:nil];

    
    }
    

}
@end
