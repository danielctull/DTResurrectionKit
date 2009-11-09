//
//  DTResurrectionController.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTResurrectionController.h"

@interface DTResurrectionController ()
- (BOOL)canResurrect;
- (void)resurrectStack;
@end


@implementation DTResurrectionController

@synthesize hasResurrected, viewController;

- (id)init {
	
	if (!(self = [super init])) return nil;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:nil];
	
	NSString *pathComponent = [NSString stringWithFormat:@"DTResurrection_%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
	archivePath = [[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:pathComponent] retain];
	
	if ([self canResurrect]) { // ACCESS FILE SYSTEM TO LOOK FOR STORED PLIST FOR RESURRECTION
		hasResurrected = YES;
		[self resurrectStack];
	}
	
	return self;	
}

- (void)dealloc {
	[viewController release];
	[archivePath release];
	[super dealloc];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.view addSubview:self.viewController.view];
}

- (void)resurrectStack {
	DTResurrector *resurrector = [[DTResurrector alloc] init];
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:archivePath];
	UIViewController<DTResurrection> *vc = [resurrector resurrect:dict];
	[resurrector release];
	self.viewController = vc;
}

- (BOOL)canResurrect {
	//return NO;
	return [[NSFileManager defaultManager] fileExistsAtPath:archivePath];
}

- (void)applicationWillTerminate:(id)sender {
	NSLog(@"%@:%s%@ ---- START", self, _cmd);
	DTResurrector *resurrector = [[DTResurrector alloc] init];
	NSDictionary *dict = [resurrector deconstructWithRootObject:self.viewController];
	[resurrector release];
	
	NSLog(@"%@:%s%@", self, _cmd, dict);
	
	[dict writeToFile:archivePath atomically:NO];
}

@end
