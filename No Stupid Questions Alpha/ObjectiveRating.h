//
//  ObjectiveRating.h
//  No Stupid Questions Alpha
//
//  Created by Kevin Lambert on 2/25/15.
//  Copyright (c) 2015 KSL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Objectives.h"
#import "User.h"

@interface ObjectiveRating : NSObject
@property (nonatomic, strong) Objectives * objective;
@property (nonatomic, strong) User * user;

@end
