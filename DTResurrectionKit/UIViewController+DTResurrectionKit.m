//
//  UIViewController+DTResurrectionKit.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "UIViewController+DTResurrectionKit.h"

@implementation UIViewController (DTResurrectionKit)

- (DTResurrectionController *)resurrectionController {
	UIResponder *nextResponder = self;
	
	while (nextResponder = [nextResponder nextResponder])
		if ([nextResponder isKindOfClass:[DTResurrectionController class]])
			return (DTResurrectionController *)nextResponder;
	
	return nil;
}

- (UIViewController *)newResurrectableViewControllerWithClass:(Class)aClass selector:(SEL)aSelector objects:(NSArray *)someObjects {	
	if (![aClass isKindOfClass:[UIViewController class]])
		return nil;
	
	id theViewController = [aClass alloc];
	
	NSInvocation *invocation = [[NSInvocation alloc] init];
	[invocation setTarget:theViewController];
	[invocation setSelector:aSelector];
	
	for (NSInteger objectCount = 0; objectCount < [someObjects count]; objectCount++)
		[invocation setArgument:[someObjects objectAtIndex:objectCount] atIndex:objectCount+2];
	
	[invocation invoke];
	[invocation getReturnValue:&theViewController];
	
	[[self resurrectionController] addResurrectableViewControllerWithCreatingViewController:self theClass:aClass selector:aSelector objects:someObjects];
	
	return theViewController;	
}


- (UIViewController *)resurrectableViewControllerWithClass:(Class)aClass selector:(SEL)aSelector objects:(NSArray *)someObjects {
	return [[self newResurrectableViewControllerWithClass:aClass selector:aSelector objects:someObjects] autorelease];
}

- (void)swizzledPresentModalViewController:(UIViewController *)aViewController animated:(BOOL)animated {
	[self swizzledPresentModalViewController:aViewController animated:animated];
}


@end
