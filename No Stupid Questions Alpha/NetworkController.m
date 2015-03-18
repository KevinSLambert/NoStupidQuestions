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

@end

@implementation NetworkController

+ (NetworkController *)sharedInstance {
    static NetworkController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkController alloc] init];
    });
    return sharedInstance;
}



- (void)retrieveLessonsForCurrentUserWithCompletion:(void (^)(NSError *, BOOL))completion {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Lesson"];
    [query whereKey:@"User" equalTo:[PFUser currentUser]];
    [query includeKey:@"Objectives"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.retrievedTeachersLessons = objects;
            completion(nil, YES);
        } else {
            completion(error, NO);
        }
    }];
}

- (void)retrieveAllLessons:(void (^)(NSError *, BOOL))completion {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Lesson"];
    [query includeKey:@"Objectives"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.allLessons = objects;
            completion(nil, YES);
        } else {
            completion(error, NO);
        }
    }];
}

- (void)retrieveQuestionsForObjectiveWithObjectId:(NSString *)objectId completion:(void (^)(NSError *, BOOL))completion {
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Objectives"];
    [query includeKey:@"Questions"];
    [query getObjectInBackgroundWithId:objectId block:^(PFObject *object, NSError *error) {
        
        if (!error) {
            self.objectiveQuestions = object[@"Questions"];
            completion(nil, YES);
        } else {
            completion(error, NO);
        }
    }];
    
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
