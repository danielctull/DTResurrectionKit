//
//  DTSpringBackUITabBarControllerTests.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 11.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTSpringBackUITabBarControllerTests.h"
#import "DTSpringBack.h"

@implementation DTSpringBackUITabBarControllerTests

- (void)testReconstruct {
	/*UIViewController *vc1 = [[UIViewController alloc] init];
	vc1.title = @"1";
	
	UIViewController *vc2 = [[UIViewController alloc] init];
	vc2.title = @"2";
	
	NSArray *vcArray = [NSArray arrayWithObjects:vc1, vc2, nil];
	
	UITabBarController *tbc = [[UITabBarController alloc] init];
	//tbc.viewControllers = vcArray;
	/*
	DTSpringBackArchiver *resurrector = [[DTSpringBackArchiver alloc] init];
	NSDictionary *dict = [resurrector deconstructWithRootObject:tbc];
	[resurrector release];
	
	DTSpringBackArchiver *anotherResurrector = [[DTSpringBackArchiver alloc] init];
	UITabBarController<DTSpringBack> *resurrectedTBC = [anotherResurrector resurrect:dict];
	[anotherResurrector release];
	
	NSLog(@"%@:%s", self, _cmd);
	
	BOOL firstEqual = [[[vcArray objectAtIndex:0] title] isEqualToString:[[resurrectedTBC viewControllers] objectAtIndex:0]];
	BOOL secondEqual = [[[vcArray objectAtIndex:1] title] isEqualToString:[[resurrectedTBC viewControllers] objectAtIndex:1]];
	NSLog(@"%@:%s1", self, _cmd);	
	//STAssertTrue([resurrectedTBC.viewControllers count] == 2,
	//			 @"Resurrected Tab Controller has wrong number of child view controllers.");
	
	STAssertTrue(firstEqual, @"View controllers' titles are not equal.");
	STAssertTrue(secondEqual, @"View controllers' titles are not equal.");
	NSLog(@"%@:%s2", self, _cmd);
	STAssertTrue([[[vcArray objectAtIndex:1] title] isEqualToString:[[resurrectedTBC viewControllers] objectAtIndex:0]]
				 && [[[vcArray objectAtIndex:0] title] isEqualToString:[[resurrectedTBC viewControllers] objectAtIndex:1]],
				 @"View controllers in the tab bar are in the wrong order.");*/
}

@end
