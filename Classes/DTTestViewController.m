//
//  DTTestViewController.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 16.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTTestViewController.h"
#import "DTModalTestViewController.h"

@implementation DTTestViewController

- (id)init {
	return [self initWithNibName:@"DTTestView" bundle:nil];
}

- (IBAction)presentVC:(id)sender {
	DTModalTestViewController *vc = [[DTModalTestViewController alloc] init];
	vc.count = 0;
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
	[vc release];
	[self presentModalViewController:nav animated:YES];
	[nav release];
}



@end
