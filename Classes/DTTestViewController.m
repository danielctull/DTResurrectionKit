//
//  DTTestViewController.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 16.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTTestViewController.h"


@implementation DTTestViewController

- (id)init {
	return [self initWithNibName:@"DTTestView" bundle:nil];
}

- (IBAction)presentVC:(id)sender {
	UIViewController *vc4 = [[UIViewController alloc] init];
	vc4.title = @"Test4";
	UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
	[vc4 release];
	
	[self presentModalViewController:nav4 animated:YES];
	
	nav4.view.frame = self.view.bounds;
	
	[nav4 release];
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
