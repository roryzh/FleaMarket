//
//  LoginViewController.m
//  FleaMarket
//
//  Created by RoryZhuang on 8/16/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import "LoginViewController.h"
#import <Firebase/Firebase.h>
#define kshowMainSegue @"showMainSegue"


@interface LoginViewController ()

@end

@implementation LoginViewController

Firebase *myRootLoginRef;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myRootLoginRef = [[Firebase alloc] initWithUrl:@"https://intense-inferno-6787.firebaseio.com"];
    if(myRootLoginRef.authData) {
        [myRootLoginRef unauth];
        
    }
    
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

- (IBAction)loginButton:(id)sender {
    
    UIAlertController* errorInvalidEmail = [UIAlertController alertControllerWithTitle:@"The specified Rose ID is not a valid Rose ID" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [errorInvalidEmail addAction:okAction];
    
    UIAlertController* errorWrongPassword = [UIAlertController alertControllerWithTitle:@"The specified user account password is incorrect" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [errorWrongPassword addAction:okAction];
    
    UIAlertController* errorNetwork = [UIAlertController alertControllerWithTitle:@"An error occurred while attempting to contact the authentication server" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [errorNetwork addAction:okAction];
    
    UIAlertController* errorAccount = [UIAlertController alertControllerWithTitle:@"This account does not exist" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [errorAccount addAction:okAction];
    
    UIAlertController* errorUnknown = [UIAlertController alertControllerWithTitle:@"An unknown error occurred. Please contact the adminstrator" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [errorUnknown addAction:okAction];
    
    NSString* emailText = [NSString stringWithFormat:@"%@@rose-hulman.edu",self.emailTextField.text];
    
    [myRootLoginRef authUser:emailText password:self.passwordTextField.text
         withCompletionBlock:^(NSError *error, FAuthData *authData) {
             if (error) {
                 switch(error.code) {
                     case FAuthenticationErrorInvalidEmail:
                         // Handle invalid email
                         [self presentViewController:errorInvalidEmail animated:YES completion:nil];
                         self.emailTextField.text = nil;
                         
                         break;
                     case FAuthenticationErrorInvalidPassword:
                         // Handle invalid password
                         [self presentViewController:errorWrongPassword animated:YES completion:nil];
                         
                         break;
                     case FAuthenticationErrorNetworkError:
                         // Handle network error
                         [self presentViewController:errorNetwork animated:YES completion:nil];
                         
                         break;
                     case FAuthenticationErrorUserDoesNotExist:
                         // Handle account not exist
                         [self presentViewController:errorAccount animated:YES completion:nil];
                         self.emailTextField.text = nil;
                         
                         
                         break;
                     case FAuthenticationErrorUnknown:
                         // Handle network error
                         [self presentViewController:errorUnknown animated:YES completion:nil];
                         
                         break;
                     default:
                         break;
                 }
             } else {
                 // We are now logged in
                 //NSLog(@"We are now logged in: %@",authData.uid);
                 
                 
                 [[[myRootLoginRef childByAppendingPath:@"users"] childByAppendingPath:authData.uid] observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
                     
                     
                     
                     
                     
                     NSDictionary *newUser = @{
                                               @"kerberosID" : self.emailTextField.text
                                               };
                     [[[myRootLoginRef childByAppendingPath:@"users"]childByAppendingPath:authData.uid] setValue: newUser];
                     
                     [self performSegueWithIdentifier:kshowMainSegue sender:nil];
                     
                     
                     
                     
                     
                     
                     
                 }];
                 
                 
                 
             }
         }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)registerButton:(id)sender {
    
    
    UIAlertController* errorEmailTaken = [UIAlertController alertControllerWithTitle:@"This ID is taken. Please contact the administrator" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [errorEmailTaken addAction:okAction];
    
    UIAlertController* errorCheck = [UIAlertController alertControllerWithTitle:@"Please check the information typed in." message:nil preferredStyle:UIAlertControllerStyleAlert];
    [errorCheck addAction:okAction];
    
    UIAlertController* errorInvalidEmail = [UIAlertController alertControllerWithTitle:@"Please enter a correct Rose ID" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [errorInvalidEmail addAction:okAction];
    UIAlertController* errorNetwork = [UIAlertController alertControllerWithTitle:@"An error occurred while attempting to contact the authentication server" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [errorNetwork addAction:okAction];
    UIAlertController* errorUnknown = [UIAlertController alertControllerWithTitle:@"An unknown error occurred. Please contact the adminstrator" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [errorUnknown addAction:okAction];
    
    UIAlertController* registerSuccess = [UIAlertController alertControllerWithTitle:@"Your registration is success. You can now login the flea market." message:nil preferredStyle:UIAlertControllerStyleAlert];
    [registerSuccess addAction:okAction];
    
    
    UIAlertController* regisLogin = [UIAlertController alertControllerWithTitle:@"Your registration is successful. You can now login to the flea market." message:nil preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* okAndLoginAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self loginButton:nil];
        
    }];
    UIAlertAction* okAndCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler: nil];
    [regisLogin addAction:okAndCancel];
    [regisLogin addAction:okAndLoginAction];
    
    NSString* emailText = [NSString stringWithFormat:@"%@@rose-hulman.edu",self.emailTextField.text];
    
    [myRootLoginRef createUser:emailText password:self.passwordTextField.text withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
        
        if (error != nil) {
            // an error occurred while attempting login
            switch(error.code) {
                case FAuthenticationErrorEmailTaken:
                    // Handle account already exist
                    [self presentViewController:errorEmailTaken animated:YES completion:nil];
                    self.emailTextField.text = nil;
                    
                    break;
                case FAuthenticationErrorInvalidEmail:
                    // Handle invalid email
                    [self presentViewController:errorInvalidEmail animated:YES completion:nil];
                    self.emailTextField.text = nil;
                    
                    
                    break;
                case FAuthenticationErrorNetworkError:
                    // Handle network error
                    [self presentViewController:errorNetwork animated:YES completion:nil];
                    
                    break;
                case FAuthenticationErrorUnknown:
                    // Handle network error
                    [self presentViewController:errorUnknown animated:YES completion:nil];
                    
                    break;
                default:
                    [self presentViewController:errorCheck animated:YES completion:nil];

                    break;
            }
        } else {
            NSString *uid = [result objectForKey:@"uid"];
            NSLog(@"Successfully created user account with uid: %@", uid);
            [self presentViewController:regisLogin animated:YES completion:nil];
            
            
            
            
        }
    }];
    
    
}

- (IBAction)forgotButton:(id)sender {
    NSString* emailText = [NSString stringWithFormat:@"%@@rose-hulman.edu",self.emailTextField.text];

    [myRootLoginRef resetPasswordForUser:emailText withCompletionBlock:^(NSError *error) {
        if(error !=nil ){
            if(error.code == FAuthenticationErrorUserDoesNotExist) {
                NSLog(@"user not exist");
            }
        }
        else {
            NSLog(@"Email sent success");
        }
        
    }];
    
    
}


@end
