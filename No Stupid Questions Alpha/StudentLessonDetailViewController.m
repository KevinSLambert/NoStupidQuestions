//
//  StudentLessonDetailViewController.m
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 3/12/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import "StudentLessonDetailViewController.h"

@interface StudentLessonDetailViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lessonName;
@property (weak, nonatomic) IBOutlet UITableView *objectivesTableView;


@end

@implementation StudentLessonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.objectivesTableView.dataSource = self;
    self.lessonName.text = self.currentLesson[@"Name"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
