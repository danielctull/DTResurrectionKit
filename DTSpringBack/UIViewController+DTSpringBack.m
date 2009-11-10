//
//  UIViewController+DTSpringBack.m
//  DTSpringBack
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "UIViewController+DTSpringBack.h"

@implementation UIViewController (DTSpringBack)

- (DTSpringBackController *)springBackController {
	UIResponder *nextResponder = self;
	
	while (nextResponder = [nextResponder nextResponder])
		if ([nextResponder isKindOfClass:[DTSpringBackController class]])
			return (DTSpringBackController *)nextResponder;
	
	return nil;
}

- (id)initWithResurrector:(DTSpringBackEncoder *)resurrector {
	
	NSLog(@"%@:%s", self, _cmd);
	
	if (!(self = [self init])) return nil;
	
	self.title = [resurrector objectForKey:@"title"];
	
	return self;
}

- (void)encodeToResurrector:(DTSpringBackEncoder *)resurrector {
	NSLog(@"%@:%s", self, _cmd);
	[resurrector setObject:self.title forKey:@"title"];
}

@end
