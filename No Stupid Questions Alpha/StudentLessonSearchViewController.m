//
//  StudentLessonSearchViewController.m
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 3/7/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import "StudentLessonSearchViewController.h"
#import <Parse/Parse.h>

@interface StudentLessonSearchViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *lessonSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *lessonTableView;
@property (nonatomic, strong) NSArray *retrievedLessons;


@end

@implementation StudentLessonSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lessonTableView.dataSource = self;
    PFQuery *query = [PFQuery queryWithClassName:@"Lesson"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.retrievedLessons = objects;
        [self.lessonTableView reloadData];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
