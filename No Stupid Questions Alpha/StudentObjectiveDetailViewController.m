//
//  StudentObjectiveDetailViewController.m
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 3/14/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import "StudentObjectiveDetailViewController.h"
#import "NetworkController.h"

@interface StudentObjectiveDetailViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *rating;
@property (nonatomic, strong) NSMutableArray *mutableObjectiveQuestions;

@end

@implementation StudentObjectiveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.currentObjective[@"Name"];
    [self.rating addTarget:self action:@selector(saveObjectiveRating) forControlEvents: UIControlEventValueChanged];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [[NetworkController sharedInstance] retrieveQuestionsForObjective:self.currentObjective completion:^(NSError *error, BOOL completed, NSArray *questions) {
        if (!error && completed) {
            self.currentObjectiveQuestions = questions;
            // TODO: On teacher screen, reload the table of the questions, e.g. [questionsTable reloadData];
        } else {
            NSLog(@"Error retrieving Questions: %@", error);
        }
    }];
    [[NetworkController sharedInstance] retrieveRatingForCurrentUserAndObjective:self.currentObjective completion:^(NSError *error, BOOL completed, PFObject *objectiveRating) {
        if (!error && completed) {
            self.currentRatingForCurrentObjective = objectiveRating;
            // TODO: Set the selected index for the segmented control based on the rating
            NSNumber *ratingNumber = objectiveRating[@"Rating"];
            if (ratingNumber) {
                NSInteger selectedIndex = ratingNumber.integerValue;
                [self.rating setSelectedSegmentIndex:selectedIndex];
            } else {
                [self clearAllRatings];
            }
        } else {
            NSLog(@"Error retrieving Rating: %@", error);
            [self clearAllRatings];
        }
    }];
}

- (void)clearAllRatings {
    [self.rating setSelectedSegmentIndex:UISegmentedControlNoSegment];
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

- (void)saveObjectiveRating {
    
    if (!self.currentRatingForCurrentObjective) {
        
        PFObject *objectiveRating = [PFObject objectWithClassName:@"ObjectiveRating"];
        self.currentRatingForCurrentObjective = objectiveRating;
        
    }
    NSInteger number = self.rating.selectedSegmentIndex;
    self.currentRatingForCurrentObjective[@"Rating"] = @(number);
    self.currentRatingForCurrentObjective[@"User"] = [PFUser currentUser];
    self.currentRatingForCurrentObjective[@"Objective"] = self.currentObjective;
    [self.currentObjective setObject:self.currentRatingForCurrentObjective forKey:@"ObjectiveRating"];
    [self.currentObjective saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Success");
        } else {
            NSLog(@"There was a problem: %@", error);
        }
    }];
    
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
