//
//  UITabBarController+DTSpringBack.m
//  DTSpringBack
//
//  Created by Daniel Tull on 09.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "UITabBarController+DTSpringBack.h"

@implementation UITabBarController (DTSpringBack)
- (id)initWithResurrector:(DTSpringBackEncoder *)resurrector {
	
	if (!(self = [self init])) return nil;
	
	self.viewControllers = [resurrector objectForKey:@"viewControllers"];
	self.selectedIndex = [[resurrector objectForKey:@"selectedIndex"] integerValue];
	
	return self;
}

- (void)encodeToResurrector:(DTSpringBackEncoder *)resurrector {
	[resurrector setObject:self.viewControllers forKey:@"viewControllers"];
	[resurrector setObject:[NSNumber numberWithInteger:self.selectedIndex] forKey:@"selectedIndex"];
}
@end
