//
//  TeacherObjectiveDetailViewController.m
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 3/14/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import "TeacherObjectiveDetailViewController.h"

@interface TeacherObjectiveDetailViewController ()

@end

@implementation TeacherObjectiveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.currentObjective[@"Name"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
