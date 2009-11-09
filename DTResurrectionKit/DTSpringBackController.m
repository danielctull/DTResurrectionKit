//
//  DTSpringBackController.m
//  DTSpringBack
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTSpringBackController.h"

@interface DTSpringBackController ()
- (BOOL)canResurrect;
- (void)deconstructStack;
- (void)resurrectStack;
@end


@implementation DTSpringBackController

@synthesize hasSprungBack, viewController;

- (id)init {
	
	if (!(self = [super init])) return nil;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:nil];
	
	NSString *pathComponent = [NSString stringWithFormat:@"DTResurrection_%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
	archivePath = [[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:pathComponent] retain];
	
	if ([self canResurrect]) { // ACCESS FILE SYSTEM TO LOOK FOR STORED PLIST FOR RESURRECTION
		hasSprungBack = YES;
		[self resurrectStack];
	}
	
	return self;	
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[viewController release];
	[archivePath release];
	[super dealloc];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.viewController.view.frame = self.view.bounds;
	[self.view addSubview:self.viewController.view];
}

- (void)resurrectStack {
	NSLog(@"%@:%s Start", self, _cmd);
	DTSpringBackEncoder *resurrector = [[DTSpringBackEncoder alloc] init];
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:archivePath];
	UIViewController<DTSpringBack> *vc = [resurrector resurrect:dict];
	[resurrector release];
	
	if (!vc) hasSprungBack = NO;
	
	self.viewController = vc;
	NSLog(@"%@:%s Finish", self, _cmd);
}

- (BOOL)canResurrect {
	//return NO;
	return [[NSFileManager defaultManager] fileExistsAtPath:archivePath];
}

- (void)deconstructStack {
	NSLog(@"%@:%s Start", self, _cmd);
	DTSpringBackEncoder *resurrector = [[DTSpringBackEncoder alloc] init];
	NSDictionary *dict = [resurrector deconstructWithRootObject:self.viewController];
	[resurrector release];
	[dict writeToFile:archivePath atomically:NO];
	NSLog(@"%@:%s Finish: %@", self, _cmd, dict);
}

- (void)applicationWillTerminate:(id)sender {
	[self deconstructStack];
}

@end
