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

- (id)initWithResurrector:(DTResurrector *)resurrector {
	
	if (!(self = [self init])) return nil;
	
	self.title = [resurrector objectForKey:@"title"];
	
	return self;
}

- (void)encodeToResurrector:(DTResurrector *)resurrector {
	[resurrector setObject:self.title forKey:@"title"];
}

@end
