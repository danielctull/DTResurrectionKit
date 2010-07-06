//
//  UINavigationController+DTSpringBack.m
//  DTSpringBack
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "UINavigationController+DTSpringBack.h"


@implementation UINavigationController (DTSpringBack)

- (id)initWithResurrector:(DTResurrector *)resurrector {
	
	NSArray *vcs = [resurrector objectForKey:@"viewControllers"];
	
	if (!(self = [self initWithRootViewController:[vcs objectAtIndex:0]])) return nil;
	
	for (NSInteger i = 1; i < [vcs count]; i++)
		[self pushViewController:[vcs objectAtIndex:i] animated:NO];
	
	UIViewController *mvc = [resurrector objectForKey:@"modalViewController"];
	if (mvc) [resurrector viewController:self.topViewController unpackedModalViewController:mvc];
	
	return self;
}

- (void)encodeToResurrector:(DTResurrector *)resurrector {
	[resurrector setObject:self.viewControllers forKey:@"viewControllers"];
	
	if (self.modalViewController) {
		if ([self isEqual:self.modalViewController.parentViewController])
			[resurrector setObject:self.modalViewController forKey:@"modalViewController"];
	}
}

- (UIViewController *)frontViewController {
	return self.topViewController;
}

/*
- (void)logStructure {
	
	
	NSString *stringToLog = [NSString stringWithFormat:@"%@ (", self];
	
	for (UIViewController *vc in self.viewControllers)
		stringToLog = [stringToLog stringByAppendingFormat:@"%@:%@", vc, vc.title];
	
	
	stringToLog = [stringToLog stringByAppendingString:@")"];
	
	
	NSLog(stringToLog);
	
}*/

@end
