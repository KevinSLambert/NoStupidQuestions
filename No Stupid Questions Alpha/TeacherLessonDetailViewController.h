//
//  TeacherLessonDetailViewController.h
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 3/7/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface TeacherLessonDetailViewController : ViewController
@property (strong, nonatomic) PFObject *currentLesson;


@end
