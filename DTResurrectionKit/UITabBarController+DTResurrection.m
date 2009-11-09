//
//  UITabBarController+DTResurrection.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 09.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "UITabBarController+DTResurrection.h"

@implementation UITabBarController (DTResurrection)
- (id)initWithResurrector:(DTResurrector *)resurrector {
	
	if (!(self = [self init])) return nil;
	
	self.viewControllers = [resurrector objectForKey:@"viewControllers"];
	
	return self;
}

- (void)encodeToResurrector:(DTResurrector *)resurrector {
	[resurrector setObject:self.viewControllers forKey:@"viewControllers"];
}
@end
