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

#import <objc/runtime.h>
#import <objc/message.h>

NSString *const DTSpringBackPathBase = @"DTSpringBack";
NSString *const DTSpringBackPathVersion = @"Version";
NSString *const DTSpringBackPathDebug = @"Debug";

@interface DTSpringBackController ()
- (BOOL)canResurrect;
- (void)deconstructStack;
- (void)resurrectStack;
@end

@implementation DTSpringBackController

@synthesize hasSprungBack, debugMode;

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
	
	if (self.debugMode) {
		Method myReplacementMethod = class_getInstanceMethod([UIViewController class], @selector(swizzledPresentModalViewController:animated:));
		Method originalMethod = class_getInstanceMethod([UIViewController class], @selector(presentModalViewController:animated:));
		method_exchangeImplementations(myReplacementMethod, originalMethod);
		Method dismissReplacementMethod = class_getInstanceMethod([UIViewController class], @selector(swizzledDismissModalViewControllerAnimated:));
		Method dismissOriginalMethod = class_getInstanceMethod([UIViewController class], @selector(dismissModalViewControllerAnimated:));
		method_exchangeImplementations(dismissReplacementMethod, dismissOriginalMethod);
	
		[self resurrectStack];
	}
	
	if (self.debugMode && !self.barView) [[NSBundle mainBundle] loadNibNamed:@"DTSpringBackDebugView" owner:self options:nil];
	
	[super viewDidLoad];
	
	if (self.debugMode) [self.viewController.view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {	
	UIView *v = (UIView *)object;
		
	if (v.frame.size.height != self.contentView.bounds.size.height)
		v.frame = self.contentView.bounds;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	if (!self.hasSprungBack) return;
	
	if (hasSprungBackModalViewControllers) return;
	
	NSMutableArray *parents = [modalViewControllerParents mutableCopy];
	NSMutableArray *children = [modalViewControllerChildren mutableCopy];
	
	while ([parents count] > 0) {
		
		UIViewController *vc = [parents lastObject];
		
		while (![vc isFrontViewController])
			vc = vc.frontViewController;
		
		UIViewController *pushVC = [children lastObject];
		
		[vc presentModalViewController:pushVC animated:NO];
		
		[parents removeLastObject];
		[children removeLastObject];	
	}
	
	[parents release];
	[children release];
	
	hasSprungBackModalViewControllers = YES;	
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
	@try {
		NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:archivePath];
		UIViewController<DTSpringBack> *vc = [resurrector resurrect:dict];
		modalViewControllerParents = [resurrector.modalViewControllerParents retain];
		modalViewControllerChildren = [resurrector.modalViewControllerChildren retain];
		self.viewController = vc;
	}
	@catch (NSException * exception) {
		//NSLog(@"Caught %@: %@", [exception name], [exception reason]);
	}
	@finally {
		[resurrector release];
		if (!self.viewController) hasSprungBack = NO;
	}
	
	//NSLog(@"%@:%s Finish", self, _cmd);
}

- (void)setDebugMode:(BOOL)aBool {
	debugMode = aBool;
	[[UIApplication sharedApplication] setStatusBarHidden:aBool animated:NO];
}

- (BOOL)canResurrect {
	//return NO;
	return [[NSFileManager defaultManager] fileExistsAtPath:archivePath];
}

- (void)deconstructStack {
	//NSLog(@"%@:%s Start", self, _cmd);
	
	DTSpringBackEncoder *resurrector = [[DTSpringBackEncoder alloc] init];
	@try {
		NSDictionary *dict = [resurrector deconstructWithRootObject:self.viewController];
		[dict writeToFile:archivePath atomically:YES];
	}
	@catch (NSException *exception) {
		//NSLog(@"Caught %@: %@", [exception name], [exception reason]);
	}
	@finally {
		[resurrector release];
	}
	
	//NSLog(@"%@:%s Finish: %@", self, _cmd, dict);
}

- (void)applicationWillTerminate:(id)sender {
	[self deconstructStack];
}


- (IBAction)loadSpringBack:(id)sender {
	DTSpringBackLoadViewController *lvc = [[DTSpringBackLoadViewController alloc] initWithSpringBackController:self];
	[self swizzledPresentModalViewController:lvc animated:YES];
	[lvc release];
}

- (IBAction)saveSpringBack:(id)sender {
	DTSpringBackSaveViewController *lvc = [[DTSpringBackSaveViewController alloc] initWithViewController:self.viewController];
	[self swizzledPresentModalViewController:lvc animated:YES];
	[lvc release];
}

@end
