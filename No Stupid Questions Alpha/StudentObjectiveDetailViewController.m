//
//  StudentObjectiveDetailViewController.m
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 3/14/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import "StudentObjectiveDetailViewController.h"

@interface StudentObjectiveDetailViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *rating;
@property (nonatomic, strong) NSMutableArray *mutableObjectiveQuestions;

@end

@implementation StudentObjectiveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.currentObjective[@"Name"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitQuestion:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ask A Question" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    UIAlertAction *submitAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Submit", @"Submit action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       if (alertController.textFields != nil) {
                                       
                                           self.mutableObjectiveQuestions = [NSMutableArray arrayWithArray:self.currentObjectiveQuestions];
                                           PFObject *question = [PFObject objectWithClassName:@"Questions"];
                                           UITextField *questionField = alertController.textFields.firstObject;
                                           question[@"Name"] = questionField.text;
                                           question[@"User"] = [PFUser currentUser];
                                           [self.mutableObjectiveQuestions addObject:question];
                                           self.currentObjectiveQuestions = self.mutableObjectiveQuestions;
                                           [self.currentObjective setObject:self.currentObjectiveQuestions forKey:@"Questions"];
                                           [self.currentObjective saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                               if (succeeded) {
                                                   NSLog(@"Success");
                                               } else {
                                                   NSLog(@"There was a problem: %@", error);
                                               }
                                           }];

                                       } else {
                                           
                                           NSLog(@"Submit action with no text");
                                           
                                       }
                                   
                                   }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:submitAction];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Ask Question Here";
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
