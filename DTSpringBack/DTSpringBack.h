//
//  DTSpringBack.h
//  DTSpringBack
//
//  Created by Daniel Tull on 09.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

@class DTSpringBackEncoder;

@protocol DTSpringBack
- (id)initWithResurrector:(DTSpringBackEncoder *)resurrector;
- (void)encodeToResurrector:(DTSpringBackEncoder *)resurrector;
@end

#import "DTSpringBackEncoder.h"
#import "DTSpringBackController.h"

#import "UITabBarController+DTSpringBack.h"
#import "UIViewController+DTSpringBack.h"
#import "UINavigationController+DTSpringBack.h"
#import "NSArray+DTSpringBack.h"
#import "NSDictionary+DTSpringBack.h"
#import "NSDate+DTSpringBack.h"