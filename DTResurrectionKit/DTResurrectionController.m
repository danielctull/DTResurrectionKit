//
//  DTResurrectionController.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTResurrectionController.h"
#import "UIViewController+DTResurrectionKit.h"
#import "UINavigationController+DTResurrectionKit.h"

#import "NSObject+DTMethodSwizzling.h"

@implementation DTResurrectionController

- (id)init {
	
	if (!(self = [super init])) return nil;
	
	[UIViewController swizzleMethod:@selector(presentModalViewController:animated:) withMethod:@selector(swizzledPresentModalViewController:animated:)];
	[UINavigationController swizzleMethod:@selector(pushViewController:animated:) withMethod:@selector(swizzledPushViewController:animated:)];
	[UINavigationController swizzleMethod:@selector(popViewControllerAnimated:) withMethod:@selector(swizzledPopViewControllerAnimated:)];
		
	return self;	
}

- (void)addResurrectableViewControllerWithCreatingViewController:(UIViewController *)creatingViewController
														theClass:(Class)aClass
														selector:(SEL)aSelector
														 objects:(NSArray *)someObjects {}

@end
