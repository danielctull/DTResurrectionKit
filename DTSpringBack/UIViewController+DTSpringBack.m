//
//  UIViewController+DTSpringBack.m
//  DTSpringBack
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "UIViewController+DTSpringBack.h"
#import "DTSpringBackArchiver.h"

@implementation UIViewController (DTSpringBack)

- (DTSpringBackController *)springBackController {
	
	UIResponder *nextResponder = self;
	
	while (nextResponder = [nextResponder nextResponder])
		if ([nextResponder isKindOfClass:[DTSpringBackController class]])
			return (DTSpringBackController *)nextResponder;
	
	nextResponder = self.parentViewController;
	
	if ([nextResponder isKindOfClass:[DTSpringBackController class]])
		return (DTSpringBackController *)nextResponder;
	
	while (nextResponder = [nextResponder nextResponder])
		if ([nextResponder isKindOfClass:[DTSpringBackController class]])
			return (DTSpringBackController *)nextResponder;
	
	NSLog(@"%@:%s springBackController Not Found", self, _cmd);
	
	return nil;
}

- (id)initWithArchiver:(DTSpringBackArchiver *)archiver {
	
	if (!(self = [self init])) return nil;
	
	self.title = [archiver objectForKey:@"title"];
	
	UIViewController *mvc = [archiver objectForKey:@"modalViewController"];
	if (mvc)
		[archiver viewController:self unpackedModalViewController:mvc];
	
	return self;
}

- (void)encodeToArchiver:(DTSpringBackArchiver *)archiver {
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
	DTSpringBackController *sbc = self.springBackController;
	[self swizzledPresentModalViewController:modalViewController animated:animated];	
	modalViewController.view.frame = sbc.contentView.bounds;
	[modalViewController.view addObserver:sbc forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:NULL];	
}

- (void)swizzledDismissModalViewControllerAnimated:(BOOL)animated {
	[self.view removeObserver:self.springBackController forKeyPath:@"frame"];
	[self swizzledDismissModalViewControllerAnimated:animated];
}

@end
