//
//  Lesson.h
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 2/25/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Lesson : NSObject
@property (nonatomic, strong) User * user;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSArray * objectives;

@end
