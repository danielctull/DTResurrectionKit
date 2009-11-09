//
//  UINavigationController+DTResurrectionKit.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "UINavigationController+DTResurrectionKit.h"


@implementation UINavigationController (DTResurrectionKit)

- (id)initWithResurrector:(DTResurrector *)resurrector {
	
	NSArray *vcs = [resurrector objectForKey:@"viewControllers"];
	
	if (!(self = [self initWithRootViewController:[vcs objectAtIndex:0]])) return nil;
	
	for (NSInteger i = 1; i < [vcs count]; i++)	
		[self pushViewController:[vcs objectAtIndex:1] animated:NO];
	
	return self;
}

- (void)encodeToResurrector:(DTResurrector *)resurrector {
	[resurrector setObject:self.viewControllers forKey:@"viewControllers"];
}

@end
