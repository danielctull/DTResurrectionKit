//
//  UITabBarController+DTSpringBack.m
//  DTSpringBack
//
//  Created by Daniel Tull on 09.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "UITabBarController+DTSpringBack.h"
#import "DTSpringBackArchiver.h"

@implementation UITabBarController (DTSpringBack)
- (id)initWithArchiver:(DTSpringBackArchiver *)archiver {
	
	if (!(self = [self init])) return nil;
	
	self.viewControllers = [archiver objectForKey:@"viewControllers"];
	self.selectedIndex = [[archiver objectForKey:@"selectedIndex"] integerValue];
	
	UIViewController *mvc = [archiver objectForKey:@"modalViewController"];
	if (mvc) [archiver viewController:self.selectedViewController unpackedModalViewController:mvc];
	
	return self;
}

- (void)encodeToArchiver:(DTSpringBackArchiver *)archiver {
	[archiver setObject:self.viewControllers forKey:@"viewControllers"];
	[archiver setObject:[NSNumber numberWithInteger:self.selectedIndex] forKey:@"selectedIndex"];
	
	if (self.modalViewController) {
		if ([self isEqual:self.modalViewController.parentViewController])
			[archiver setObject:self.modalViewController forKey:@"modalViewController"];
	}
}

- (UIViewController *)frontViewController {
	return self.selectedViewController;
}

@end
