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
	self.selectedIndex = [[resurrector objectForKey:@"selectedIndex"] integerValue];
	
	UIViewController *mvc = [resurrector objectForKey:@"modalViewController"];
	if (mvc) [resurrector viewController:self.selectedViewController unpackedModalViewController:mvc];
	
	return self;
}

- (void)encodeToResurrector:(DTResurrector *)resurrector {
	[resurrector setObject:self.viewControllers forKey:@"viewControllers"];
	[resurrector setObject:[NSNumber numberWithInteger:self.selectedIndex] forKey:@"selectedIndex"];
	
	if (self.modalViewController) {
		if ([self isEqual:self.modalViewController.parentViewController])
			[resurrector setObject:self.modalViewController forKey:@"modalViewController"];
	}
}

- (UIViewController *)frontViewController {
	return self.selectedViewController;
}

@end
