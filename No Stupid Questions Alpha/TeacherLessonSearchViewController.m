//
//  TeacherLessonSearchViewController.m
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 3/4/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import "TeacherLessonSearchViewController.h"
#import "TeacherLessonDetailViewController.h"
#import <Parse/Parse.h>
#import "NetworkController.h"

@interface TeacherLessonSearchViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *lessonListTableView;
@property (nonatomic, strong) NSArray *retrievedLessons;
@property (nonatomic, strong) NSMutableArray *filteredLessons;
@property (nonatomic, strong) PFObject *selectedObject;

@end

@implementation TeacherLessonSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Lessons";
    self.lessonListTableView.dataSource = self;
    self.lessonListTableView.delegate = self;
//    PFQuery *query = [PFQuery queryWithClassName:@"Lesson"];
//    [query whereKey:@"User" equalTo:[PFUser currentUser]];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        self.retrievedLessons = objects;
//        [self.lessonListTableView reloadData];
//    }];
    [[NetworkController sharedInstance] retrieveLessonsForCurrentUserWithCompletion:^(NSError *error, BOOL completed) {
        if (!error && completed) {
            self.retrievedLessons = [NetworkController sharedInstance].retrievedTeachersLessons;
            [self.lessonListTableView reloadData];
        } else {
            NSLog(@"Error retrieving lessons: %@", error);
        }
    }];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.retrievedLessons.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.lessonListTableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *object = [self.retrievedLessons objectAtIndex:indexPath.row];
    cell.textLabel.text = object[@"Name"];
    
//    UITableViewCell *cell = [self.lessonListTableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    if (tableView == self.lessonListTableView) {
//        PFObject *object = [self.retrievedLessons objectAtIndex:indexPath.row];
//        cell.textLabel.text = object[@"Name"];
//    } else {
//        PFObject *object = [self.filteredLessons objectAtIndex:indexPath.row];
//        cell.textLabel.text = object[@"Name"];
//    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PFObject *object = [self.retrievedLessons objectAtIndex:indexPath.row];
    self.selectedObject = object;
    [self performSegueWithIdentifier:@"lessonDetail" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"lessonDetail"]) {
        TeacherLessonDetailViewController *detailViewController = [segue destinationViewController];
        [detailViewController setCurrentLesson:self.selectedObject];
        [detailViewController setCurrentLessonObjectives:self.selectedObject[@"Objectives"]];
    }
    
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
