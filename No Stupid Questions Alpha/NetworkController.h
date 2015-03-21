//
//  NetworkController.h
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 3/7/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>


@interface NetworkController : NSObject

@property (nonatomic, strong) NSArray *retrievedTeachersLessons;
@property (nonatomic, strong) NSArray *allLessons;

+ (NetworkController *)sharedInstance;

- (void)retrieveLessonsForCurrentUserWithCompletion:(void (^)(NSError *error, BOOL completed))completion;
- (void)retrieveAllLessons:(void (^)(NSError *error, BOOL completed))completion;
- (void)retrieveQuestionsForObjective:(PFObject *)objective completion:(void (^)(NSError *error, BOOL completed, NSArray *questions))completion;
- (void)retrieveRatingForCurrentUserAndObjective:(PFObject *)objective completion:(void (^)(NSError *error, BOOL completed, PFObject *objectiveRating))completion;
- (void)retrieveRatingsForObjective:(PFObject *)objective completion:(void (^)(NSError *error, BOOL completed, NSArray *ratings))completion;

@end
