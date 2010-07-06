//
//  UIViewController+DTSpringBack.m
//  DTSpringBack
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "UIViewController+DTSpringBack.h"
#import "DTResurrector.h"

@implementation UIViewController (DTSpringBack)

- (DTResurrectionController *)springBackController {
	
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
	
	NSLog(@"%@:%s springBackController Not Found", self, _cmd);
	
	return nil;
}

- (id)initWithArchiver:(DTResurrector *)archiver {
	
	if (!(self = [self init])) return nil;
	
	self.title = [archiver objectForKey:@"title"];
	
	UIViewController *mvc = [archiver objectForKey:@"modalViewController"];
	if (mvc)
		[archiver viewController:self unpackedModalViewController:mvc];
	
	return self;
}

- (void)encodeToArchiver:(DTResurrector *)archiver {
	[archiver setObject:self.title forKey:@"title"];
	
	if (self.modalViewController) {
		if ([self isEqual:self.modalViewController.parentViewController])
			[archiver setObject:self.modalViewController forKey:@"modalViewController"];
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
	DTResurrectionController *sbc = self.springBackController;
	[self swizzledPresentModalViewController:modalViewController animated:animated];	
	modalViewController.view.frame = sbc.contentView.bounds;
	[modalViewController.view addObserver:sbc forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:NULL];	
}

- (void)swizzledDismissModalViewControllerAnimated:(BOOL)animated {
	[self.view removeObserver:self.springBackController forKeyPath:@"frame"];
	[self swizzledDismissModalViewControllerAnimated:animated];
}

@end
