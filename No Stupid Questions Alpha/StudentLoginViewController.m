//
//  StudentLoginViewController.m
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 2/24/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import "StudentLoginViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface StudentLoginViewController () <PFSignUpViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation StudentLoginViewController
- (IBAction)newAccount:(id)sender {
    
    PFSignUpViewController *signUpController = [[PFSignUpViewController alloc] init];
    signUpController.delegate = self;
    [self presentViewController:signUpController animated:YES completion:nil];
    
}
- (IBAction)logIn:(id)sender {
    
    [PFUser logInWithUsernameInBackground:self.userNameTextField.text
                                 password:self.passwordTextField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            
                                            [self performSegueWithIdentifier:@"studentLogIn" sender:self];
                                            
                                        } else {
                                            
                                            NSString *errorMessage = [NSString stringWithFormat:@"%@", error];
                                            
                                            UIAlertController * errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
                                            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) { }];
                                            [errorAlert addAction:cancelAction];
                                            [self presentViewController:errorAlert animated:YES completion:nil];
                                            // The login failed. Check error to see why.
                                        }
                                    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations {
    return 0;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
