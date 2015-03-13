//
//  StudentLessonDetailViewController.h
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 3/12/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface StudentLessonDetailViewController : UIViewController
@property (strong, nonatomic) PFObject *currentLesson;
@property (strong, nonatomic) NSArray *currentLessonObjectives;

@end
