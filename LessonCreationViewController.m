//
//  LessonCreationViewController.m
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 2/28/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import "LessonCreationViewController.h"
#import <Parse/Parse.h>
#import "Lesson.h"
#import "Objectives.h"

@interface LessonCreationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *lessonName;
@property (weak, nonatomic) IBOutlet UITextField *lessonObjectiveOne;
@property (weak, nonatomic) IBOutlet UITextField *lessonObjectiveTwo;
@property (weak, nonatomic) IBOutlet UITextField *lessonObjectiveThree;

@end

@implementation LessonCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Create New Lesson";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveLesson:(id)sender {
    PFObject *parseLesson = [PFObject objectWithClassName:@"Lesson"];
    if (self.lessonName.text.length > 0) {
        parseLesson[@"Name"] = self.lessonName.text;
    } else {
        return;
    }
    parseLesson[@"User"] = [PFUser currentUser];
    [parseLesson saveInBackground];
    
    PFRelation *relation = [parseLesson relationForKey:@"Objectives"];
    
    if (self.lessonObjectiveOne.text.length > 0) {
        PFObject *objectiveOne = [PFObject objectWithClassName:@"Objectives"];
        objectiveOne[@"Name"] = self.lessonObjectiveOne.text;
        [objectiveOne saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded){
                [relation addObject:objectiveOne];
            } else {
                NSLog(@"%@",error);
            }
            
        }];
    }
    if (self.lessonObjectiveTwo.text.length > 0) {
        PFObject *objectiveTwo = [PFObject objectWithClassName:@"Objectives"];
        objectiveTwo[@"Name"] = self.lessonObjectiveOne.text;
        [objectiveTwo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded){
                [relation addObject:objectiveTwo];
            } else {
                NSLog(@"%@",error);
            }
            
        }];
    }
    if (self.lessonObjectiveThree.text.length > 0) {
        PFObject *objectiveThree = [PFObject objectWithClassName:@"Objectives"];
        objectiveThree[@"Name"] = self.lessonObjectiveOne.text;
        [objectiveThree saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded){
                [relation addObject:objectiveThree];
            } else {
                NSLog(@"%@",error);
            }
            
        }];

    }
    
    
//    parseLesson[@"Objectives"] = lesson.objectives;
    [parseLesson saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
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
