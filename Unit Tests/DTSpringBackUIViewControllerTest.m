//
//  DTSpringBackUIViewControllerTest.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 11.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTSpringBackUIViewControllerTest.h"
#import "DTSpringBack.h"

@implementation DTSpringBackUIViewControllerTest                       // all code under test must be linked into the Unit Test bundle

- (void)testReconstruct {
	UIViewController *vc = [[UIViewController alloc] init];
	vc.title = @"test";
	
	DTSpringBackArchiver *resurrector = [[DTSpringBackArchiver alloc] init];
	NSDictionary *dict = [resurrector deconstructWithRootObject:vc];
	[resurrector release];
	
	DTSpringBackArchiver *anotherResurrector = [[DTSpringBackArchiver alloc] init];
	UIViewController<DTSpringBack> *resurrectedVC = [anotherResurrector resurrect:dict];
	[anotherResurrector release];
	STAssertTrue([vc.title isEqualToString:resurrectedVC.title], @"Title is not equal when resurrected.");
}

@end
