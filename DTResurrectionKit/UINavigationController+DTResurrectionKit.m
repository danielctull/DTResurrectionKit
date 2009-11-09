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
	
	
	
	if (!(self = [self initWithRootViewController:nil])) return nil;
	
	self.viewControllers = [resurrector objectForKey:@"viewControllers"];
	
	return self;
}

- (void)encodeToResurrector:(DTResurrector *)resurrector {
	
	
	[resurrector setObject:self.viewControllers forKey:@"viewControllers"];
}

@end
