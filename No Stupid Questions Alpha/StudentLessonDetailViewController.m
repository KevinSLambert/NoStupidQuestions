//
//  StudentLessonDetailViewController.m
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 3/12/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import "StudentLessonDetailViewController.h"
#import "StudentObjectiveDetailViewController.h"
#import "NetworkController.h"

@interface StudentLessonDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *objectivesTableView;
@property (nonatomic, strong) PFObject *selectedObjective;


@end

@implementation StudentLessonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.objectivesTableView.dataSource = self;
    self.objectivesTableView.delegate = self;
    self.title = self.currentLesson[@"Name"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.currentLessonObjectives.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.objectivesTableView dequeueReusableCellWithIdentifier:@"Cell"];
    PFObject *objective = [self.currentLessonObjectives objectAtIndex:indexPath.row];
    cell.textLabel.text = objective[@"Name"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PFObject *objective = [self.currentLessonObjectives objectAtIndex:indexPath.row];
    self.selectedObjective = objective;
    [self performSegueWithIdentifier:@"objectiveDetail" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"objectiveDetail"]) {
        StudentObjectiveDetailViewController *detailViewController = [segue destinationViewController];
        [detailViewController setCurrentObjective:self.selectedObjective];
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
