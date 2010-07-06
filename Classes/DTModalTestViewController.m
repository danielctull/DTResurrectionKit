//
//  DTModalTestViewController.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 22.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTModalTestViewController.h"
#import "DTSpringBack.h"

@implementation DTModalTestViewController

@synthesize count;

- (id)init {
	NSLog(@"%@:%s", self, _cmd);
	return [self initWithNibName:@"DTTestView" bundle:nil];
}

- (id)initWithResurrector:(DTResurrector *)resurrector {
	
	if (!(self = [super initWithResurrector:resurrector])) return nil;
	
	count = [[resurrector objectForKey:@"count"] integerValue];
	
	return self;
}

- (void)encodeToResurrector:(DTResurrector *)resurrector {
	[super encodeToResurrector:resurrector];
	[resurrector setObject:[NSNumber numberWithInteger:self.count] forKey:@"count"];
}

- (void)setCount:(NSInteger)anInteger {
	count = anInteger;
	self.title = [NSString stringWithFormat:@"Modal #%i", count];
}

- (IBAction)presentVC:(id)sender {
	NSLog(@"%@:%s", self, _cmd);
	DTModalTestViewController *vc = [[DTModalTestViewController alloc] init];
	vc.count = self.count + 1;
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
	[vc release];
	[self presentModalViewController:nav animated:YES];
	[nav release];
}

- (void)viewDidLoad {
	
	UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
	self.navigationItem.leftBarButtonItem = cancel;
	[cancel release];
	
    [super viewDidLoad];
}

- (void)cancel:(id)sender {
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}




@end
