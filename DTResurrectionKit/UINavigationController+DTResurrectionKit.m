//
//  UINavigationController+DTResurrectionKit.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "UINavigationController+DTResurrectionKit.h"


@implementation UINavigationController (DTResurrectionKit)

- (void)swizzledPushViewController:(UIViewController *)aViewController animated:(BOOL)animated {
	[self swizzledPushViewController:aViewController animated:animated];
}

- (void)swizzledPopViewControllerAnimated:(BOOL)animated {
	[self swizzledPopViewControllerAnimated:animated];
}

@end
