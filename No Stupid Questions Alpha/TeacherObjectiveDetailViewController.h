//
//  TeacherObjectiveDetailViewController.h
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 3/14/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface TeacherObjectiveDetailViewController : UIViewController
@property (nonatomic, strong) PFObject *currentObjective;
@property (nonatomic, strong) NSArray *currentObjectiveQuestions;

@end
