//
//  DTResurrectionKitAppDelegate.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright Daniel Tull 2009. All rights reserved.
//

#import "DTResurrectionKitAppDelegate.h"
#import "DTModalTestViewController.h"

@implementation DTResurrectionKitAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	resurrectionController = [[DTResurrectionController alloc] init];
	
	//resurrectionController.debugMode = YES;
	
	// If ResurrectionKit hasn't managed to resurrect, we need to set up ourselves.
	if (!resurrectionController.hasSprungBack) {
		
		NSLog(@"MANUAL SETUP");
		
		UIViewController *vc1 = [[UIViewController alloc] init];
		vc1.title = @"Test1";
		UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
		[vc1 release];
		
		UIViewController *vc2 = [[UIViewController alloc] init];
		vc2.title = @"Test2";
		UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
		[vc2 release];
		
		DTModalTestViewController *vc3 = [[DTModalTestViewController alloc] init];
		vc3.title = @"Test3";
		UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
		[vc3 release];
		
		UITabBarController *tabs = [[UITabBarController alloc] init];
		tabs.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nav3, nil];
		
		[nav1 release];
		[nav2 release];
		[nav3 release];
		resurrectionController.viewController = tabs;
		[tabs release];
	}
	
	[window addSubview:resurrectionController.view];
    [window makeKeyAndVisible];
}

- (void)dealloc {
	[resurrectionController release];
    [window release];
    [super dealloc];
}


@end
