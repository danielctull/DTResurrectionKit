//
//  UIViewController+DTSpringBack.m
//  DTSpringBack
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "UIViewController+DTSpringBack.h"
#import "DTSpringBackEncoder.h"

@implementation UIViewController (DTSpringBack)

- (DTSpringBackController *)springBackController {
	UIResponder *nextResponder = self;
	
	while (nextResponder = [nextResponder nextResponder])
		if ([nextResponder isKindOfClass:[DTSpringBackController class]])
			return (DTSpringBackController *)nextResponder;
	
	nextResponder = self.parentViewController;
	
	NSLog(@"%@:%s %@", self, _cmd, nextResponder);
	
	if ([nextResponder isKindOfClass:[DTSpringBackController class]])
		return (DTSpringBackController *)nextResponder;
	
	while (nextResponder = [nextResponder nextResponder]) {
		NSLog(@"%@:%s %@", self, _cmd, nextResponder);
		if ([nextResponder isKindOfClass:[DTSpringBackController class]])
			return (DTSpringBackController *)nextResponder;
	}
	
	
	return nil;
}

- (id)initWithResurrector:(DTSpringBackEncoder *)resurrector {
	
	if (!(self = [self init])) return nil;
	
	self.title = [resurrector objectForKey:@"title"];
	
	UIViewController *mvc = [resurrector objectForKey:@"modalViewController"];
	if (mvc) {
		NSLog(@"%@:%s MODAL EXISTS", self, _cmd);
		NSLog(@"%@:%s %@", self, _cmd, mvc);
		[resurrector viewController:self unpackedModalViewController:mvc];
	}
	
	return self;
}

- (void)encodeToResurrector:(DTSpringBackEncoder *)resurrector {
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

@end
