//
//  DTSpringBackAppDelegate.m
//  DTSpringBack
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright Daniel Tull 2009. All rights reserved.
//

#import "DTSpringBackAppDelegate.h"
#import "DTModalTestViewController.h"

@implementation DTSpringBackAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	
	NSData *d = [NSData dataWithContentsOfFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"IMAGETEST"]];
	UIImage *i = [UIImage imageWithData:d];
	UIImageView *iv = [[UIImageView alloc] initWithImage:i];
	
	NSLog(@"%@:%s iv:%@", self, _cmd, iv);
	
	[window addSubview:iv];
	/*
	springBackController = [[DTSpringBackController alloc] init];
	
	if (!springBackController.hasSprungBack) {
		
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
		springBackController.viewController = tabs;
		[tabs release];
	}
	
	//springBackController.debugMode = YES;
	
	[window addSubview:springBackController.view];*/
	
    // Override point for customization after application launch
    [window makeKeyAndVisible];
}

- (void)dealloc {
	[springBackController release];
    [window release];
    [super dealloc];
}


@end
