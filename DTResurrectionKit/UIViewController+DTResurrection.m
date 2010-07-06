//
//  UIViewController+DTResurrection.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "UIViewController+DTResurrection.h"
#import "DTResurrector.h"

@implementation UIViewController (DTResurrection)

- (DTResurrectionController *)resurrectionController {
	
	UIResponder *nextResponder = self;
	
	while (nextResponder = [nextResponder nextResponder])
		if ([nextResponder isKindOfClass:[DTResurrectionController class]])
			return (DTResurrectionController *)nextResponder;
	
	nextResponder = self.parentViewController;
	
	if ([nextResponder isKindOfClass:[DTResurrectionController class]])
		return (DTResurrectionController *)nextResponder;
	
	while (nextResponder = [nextResponder nextResponder])
		if ([nextResponder isKindOfClass:[DTResurrectionController class]])
			return (DTResurrectionController *)nextResponder;
	
	NSLog(@"%@:%s resurrectionController Not Found", self, _cmd);
	
	return nil;
}

- (id)initWithResurrector:(DTResurrector *)resurrector {
	
	if (!(self = [self init])) return nil;
	
	self.title = [resurrector objectForKey:@"title"];
	
	UIViewController *mvc = [resurrector objectForKey:@"modalViewController"];
	if (mvc)
		[resurrector viewController:self unpackedModalViewController:mvc];
	
	return self;
}

- (void)encodeToResurrector:(DTResurrector *)resurrector {
	[resurrector setObject:self.title forKey:@"title"];
	
	if (self.modalViewController) {
		if ([self isEqual:self.modalViewController.parentViewController])
			[resurrector setObject:self.modalViewController forKey:@"modalViewController"];
	}
}

- (BOOL)isFrontViewController {
	return [self isEqual:self.frontViewController];
}

- (UIViewController *)frontViewController {
	return self;
}

// USED ONLY IN DEBUG MODE
- (void)swizzledPresentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated {
	DTResurrectionController *sbc = self.resurrectionController;
	[self swizzledPresentModalViewController:modalViewController animated:animated];	
	modalViewController.view.frame = sbc.contentView.bounds;
	[modalViewController.view addObserver:sbc forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:NULL];	
}

- (void)swizzledDismissModalViewControllerAnimated:(BOOL)animated {
	[self.view removeObserver:self.resurrectionController forKeyPath:@"frame"];
	[self swizzledDismissModalViewControllerAnimated:animated];
}

@end
