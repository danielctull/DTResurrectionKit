//
//  UINavigationController+DTSpringBack.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "UINavigationController+DTSpringBack.h"


@implementation UINavigationController (DTSpringBack)

- (id)initWithResurrector:(DTSpringBackEncoder *)resurrector {
	
	NSArray *vcs = [resurrector objectForKey:@"viewControllers"];
	
	if (!(self = [self initWithRootViewController:[vcs objectAtIndex:0]])) return nil;
	
	for (NSInteger i = 1; i < [vcs count]; i++)	
		[self pushViewController:[vcs objectAtIndex:1] animated:NO];
	
	return self;
}

- (void)encodeToResurrector:(DTSpringBackEncoder *)resurrector {
	[resurrector setObject:self.viewControllers forKey:@"viewControllers"];
}

@end
