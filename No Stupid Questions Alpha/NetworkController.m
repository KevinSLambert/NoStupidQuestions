//
//  NetworkController.m
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 3/7/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import "NetworkController.h"
#import <Parse/Parse.h> 

@interface NetworkController()
@property (nonatomic, strong) NSArray *retrievedLessons;
@end

@implementation NetworkController



- (NSArray*)retrieveLessonsForCurrentUser {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Lesson"];
    [query whereKey:@"User" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.retrievedLessons = objects;
    }];
    
    return self.retrievedLessons;
}
    
//
//    
//    
////    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
////        if (!error) {
////            return objects;
////        } else {
////            NSLog(@"%@", error);
////        }
////        
////
////    }];
// 
//    
//}

@end
