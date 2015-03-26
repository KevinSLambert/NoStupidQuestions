//
//  TeacherLoginViewController.m
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 2/24/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import "TeacherLoginViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface TeacherLoginViewController () <PFSignUpViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation TeacherLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)newAccount:(id)sender {
    
    PFSignUpViewController *signUpController = [[PFSignUpViewController alloc] init];
    signUpController.delegate = self;
    [self presentViewController:signUpController animated:YES completion:nil];
    
}
- (IBAction)logIn:(id)sender {
    
    [PFUser logInWithUsernameInBackground:self.userName.text
                                 password:self.password.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            
                                            [self performSegueWithIdentifier:@"TeacherLogin" sender:self];
                                            
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
