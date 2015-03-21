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

- (void)retrieveQuestionsForObjective:(PFObject *)objective completion:(void (^)(NSError *, BOOL, NSArray *))completion {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Objectives"];
    [query includeKey:@"Questions"];
    [query getObjectInBackgroundWithId:objective.objectId block:^(PFObject *object, NSError *error) {
        
        if (!error) {
            NSArray *objectiveQuestions = object[@"Questions"];
            completion(nil, YES, objectiveQuestions);
        } else {
            completion(error, NO, nil);
        }
    }];
    
}

- (void)retrieveRatingsForObjective:(PFObject *)objective completion:(void (^)(NSError *, BOOL, NSArray *))completion {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Objectives"];
    [query includeKey:@"ObjectiveRating"];
    [query getObjectInBackgroundWithId:objective.objectId block:^(PFObject *object, NSError *error) {
        
        if (!error) {
            NSArray *objectiveRatings = object[@"ObjectiveRating"];
            completion(nil, YES, objectiveRatings);
        } else {
            completion(error, NO, nil);
        }
    }];
    
}

- (void)retrieveRatingForCurrentUserAndObjective:(PFObject *)objective completion:(void (^)(NSError *, BOOL, PFObject *))completion {
    
    PFQuery *query = [PFQuery queryWithClassName:@"ObjectiveRating"];
    [query whereKey:@"User" equalTo:[PFUser currentUser]];
//    PFObject *objectiveObject = [PFObject objectWithoutDataWithClassName:@"Objectives" objectId:objectId];
    [query whereKey:@"Objective" equalTo:objective];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            completion(nil, YES, objects.firstObject);
        } else {
            completion(error, NO, nil);
        }
    }];
     
    
//    - (instancetype)whereKey:(NSString *)key equalTo:(id)object;
    
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
