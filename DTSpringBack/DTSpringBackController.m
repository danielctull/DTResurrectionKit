//
//  DTSpringBackController.m
//  DTSpringBack
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTSpringBackController.h"
#import "DTSpringBackLoadViewController.h"
#import "DTSpringBackSaveViewController.h"
#import "UIViewController+DTSpringBack.h"

NSString *const DTSpringBackPathBase = @"DTSpringBack";
NSString *const DTSpringBackPathVersion = @"Version";
NSString *const DTSpringBackPathDebug = @"Debug";

@interface DTSpringBackController ()
- (BOOL)canResurrect;
- (void)deconstructStack;
- (void)resurrectStack;
@end

@implementation DTSpringBackController

@synthesize hasSprungBack, debugMode, viewController;
/*
- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated {
	NSLog(@"%@:%s", self, _cmd);
	//[super presentModalViewController:modalViewController animated:animated];
	
	[modalViewController retain];
	
	
	//[self.contentView addSubview:modalViewController.view];
	
	[self.contentView insertSubview:modalViewController.view atIndex:100000];
	modalViewController.view.frame = CGRectMake(0, self.view.bounds.size.height, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
	
	NSLog(@"%@:%s %@", self, _cmd, self.contentView);
	
	if (animated) [UIView beginAnimations:@"modal" context:NULL];
	modalViewController.view.frame = self.contentView.bounds;
	if (animated) [UIView commitAnimations];
	
	
	
	
}
*/
- (id)init {
	
	if (!(self = [super init])) return nil;
		
	self.position = DTBarPositionTop;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:nil];
	
	NSString *pathComponent = [NSString stringWithFormat:@"%@%@", DTSpringBackPathVersion, [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
	archivePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:DTSpringBackPathBase];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if (![fileManager fileExistsAtPath:archivePath])
		[fileManager createDirectoryAtPath:archivePath attributes:nil];
	
	archivePath = [[archivePath stringByAppendingPathComponent:pathComponent] retain];
	
	if ([self canResurrect]) { // ACCESS FILE SYSTEM TO LOOK FOR STORED PLIST FOR RESURRECTION
		hasSprungBack = YES;
		[self resurrectStack];
	}
	
	return self;	
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[modalViewControllerParents release];
	[modalViewControllerChildren release];
	[viewController release];
	[archivePath release];
	[super dealloc];
}

- (void)viewDidLoad {
	
	[self resurrectStack];
	
	if (self.debugMode && !self.barView) [[NSBundle mainBundle] loadNibNamed:@"DTSpringBackDebugView" owner:self options:nil];
	
	[super viewDidLoad];
	
	self.viewController.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.viewController.view.frame = self.contentView.bounds;
	[self.contentView addSubview:self.viewController.view];
	/*
	for (NSInteger i = 0; i < [modalViewControllerParents count]; i++) {
		NSLog(@"present %@ %@", [modalViewControllerParents objectAtIndex:i], [modalViewControllerChildren objectAtIndex:i]);
		[[modalViewControllerParents objectAtIndex:i] presentModalViewController:[modalViewControllerChildren objectAtIndex:i] animated:NO];
	}*/
	
	
	
	
}

- (void)viewDidAppear:(BOOL)animated {
	
	
	for (NSInteger i = 0; i < [modalViewControllerParents count]; i++) {
		
		UIViewController *vc = [modalViewControllerParents objectAtIndex:i];
		
		while (![vc isFrontViewController])
			vc = vc.frontViewController;
		
		UIViewController *pushVC = [modalViewControllerChildren objectAtIndex:i];
		
		[vc presentModalViewController:pushVC animated:NO];
	}
}

- (void)resurrectWithArchivePath:(NSString *)path {
	[archivePath release];
	archivePath = [path copy];
	[self resurrectStack];
	self.contentView = nil;
	self.view = nil;
}

- (void)resurrectStack {
	//NSLog(@"%@:%s Start", self, _cmd);
	DTSpringBackEncoder *resurrector = [[DTSpringBackEncoder alloc] init];
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:archivePath];
	UIViewController<DTSpringBack> *vc = [resurrector resurrect:dict];
	modalViewControllerParents = [resurrector.modalViewControllerParents retain];
	modalViewControllerChildren = [resurrector.modalViewControllerChildren retain];
	[resurrector release];
	
	if (!vc) hasSprungBack = NO;
	
	self.viewController = vc;
	//NSLog(@"%@:%s Finish", self, _cmd);
}

- (BOOL)canResurrect {
	//return NO;
	return [[NSFileManager defaultManager] fileExistsAtPath:archivePath];
}

- (void)deconstructStack {
	//NSLog(@"%@:%s Start", self, _cmd);
	DTSpringBackEncoder *resurrector = [[DTSpringBackEncoder alloc] init];
	NSDictionary *dict = [resurrector deconstructWithRootObject:self.viewController];
	[resurrector release];
	[dict writeToFile:archivePath atomically:NO];
	//NSLog(@"%@:%s Finish: %@", self, _cmd, dict);
}

- (void)applicationWillTerminate:(id)sender {
	[self deconstructStack];
}


- (IBAction)loadSpringBack:(id)sender {
	DTSpringBackLoadViewController *lvc = [[DTSpringBackLoadViewController alloc] initWithSpringBackController:self];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lvc];
	[self presentModalViewController:nav animated:YES];
	[lvc release];
	[nav release];
}

- (IBAction)saveSpringBack:(id)sender {
	DTSpringBackSaveViewController *lvc = [[DTSpringBackSaveViewController alloc] initWithViewController:self.viewController];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lvc];
	[self presentModalViewController:nav animated:YES];
	[lvc release];
	[nav release];
}

@end
