//
//  StudentLessonSearchViewController.m
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 3/7/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import "StudentLessonSearchViewController.h"
#import <Parse/Parse.h>
#import "NetworkController.h"
#import "StudentLessonDetailViewController.h"

@interface StudentLessonSearchViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *lessonSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *lessonTableView;
@property (nonatomic, strong) NSArray *retrievedLessons;
@property (nonatomic, strong) PFObject *selectedObject;


@end

@implementation StudentLessonSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lessonTableView.dataSource = self;
    self.lessonTableView.delegate = self;
//    PFQuery *query = [PFQuery queryWithClassName:@"Lesson"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        self.retrievedLessons = objects;
//        [self.lessonTableView reloadData];
//    }];
    [[NetworkController sharedInstance] retrieveAllLessons:^(NSError *error, BOOL completed) {
        if (!error && completed) {
            self.retrievedLessons = [NetworkController sharedInstance].allLessons;
            [self.lessonTableView reloadData];
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
    
    UITableViewCell *cell = [self.lessonTableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *object = [self.retrievedLessons objectAtIndex:indexPath.row];
    cell.textLabel.text = object[@"Name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PFObject *object = [self.retrievedLessons objectAtIndex:indexPath.row];
    self.selectedObject = object;
    [self performSegueWithIdentifier:@"lessonDetail" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"lessonDetail"]) {
        StudentLessonDetailViewController *detailViewController = [segue destinationViewController];
        [detailViewController setCurrentLesson:self.selectedObject];
        [detailViewController setCurrentLessonObjectives:self.selectedObject[@"Objectives"]];
    }
    
}
- (IBAction)LogOut:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
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
