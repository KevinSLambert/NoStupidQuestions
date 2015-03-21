//
//  TeacherObjectiveDetailViewController.m
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 3/14/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import "TeacherObjectiveDetailViewController.h"
#import "NetworkController.h"

@interface TeacherObjectiveDetailViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *questionsTableview;
@property (weak, nonatomic) IBOutlet UILabel *ratingAverage;

@end

@implementation TeacherObjectiveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.currentObjective[@"Name"];
    self.questionsTableview.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [[NetworkController sharedInstance] retrieveQuestionsForObjective:self.currentObjective completion:^(NSError *error, BOOL completed, NSArray *questions) {
        if (!error && completed) {
            self.currentObjectiveQuestions = questions;
            [self.questionsTableview reloadData];
        } else {
            NSLog(@"Error retrieving Questions: %@", error);
        }
    }];
    
    [[NetworkController sharedInstance] retrieveRatingsForObjective:self.currentObjective completion:^(NSError *error, BOOL completed, NSArray *ratings) {
        
        if (!error && completed) {
            
            NSArray *numbers = @[@(35), @(55), @(65)];
            NSNumber *average = [numbers valueForKeyPath:@"@avg.self"];
            self.ratingAverage.text =  average.stringValue;
            
        } else {
            NSLog(@"Error retrieving Questions: %@", error);
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.currentObjectiveQuestions.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.questionsTableview dequeueReusableCellWithIdentifier:@"MyCell"];
    PFObject *question = [self.currentObjectiveQuestions objectAtIndex:indexPath.row];
    
    UILabel *questionLabel = (UILabel *)[cell.contentView viewWithTag:101];
    questionLabel.text = question[@"Name"];
    
    UILabel *userLabel = (UILabel *)[cell.contentView viewWithTag:102];
    userLabel.text = @"Test User Name";
    
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
