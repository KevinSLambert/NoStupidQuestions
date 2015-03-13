//
//  NetworkController.h
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 3/7/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkController : NSObject

@property (nonatomic, strong) NSArray *retrievedTeachersLessons;
@property (nonatomic, strong) NSArray *allLessons;

+ (NetworkController *)sharedInstance;

- (void)retrieveLessonsForCurrentUserWithCompletion:(void (^)(NSError *error, BOOL completed))completion;
- (void)retrieveAllLessons:(void (^)(NSError *, BOOL))completion;

@end
