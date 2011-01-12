//
//  DTResurrectionController.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTResurrectionKit.h"
//#import "DTResurrectionKitLoadViewController.h"
//#import "DTResurrectionKitSaveViewController.h"

#import <QuartzCore/QuartzCore.h>

#import <objc/runtime.h>
#import <objc/message.h>

NSString *const DTResurrectionKitPathBase = @"DTResurrectionKit";
NSString *const DTResurrectionKitPathVersion = @"Version";
NSString *const DTResurrectionKitPathDebug = @"Debug";

@interface DTResurrectionController ()
- (BOOL)canResurrect;
- (void)deconstructStack;
- (void)resurrectStack;
- (void)saveCurrentImage;
- (void)applicationWillGoAway:(id)sender;
@end

@implementation DTResurrectionController

@synthesize hasResurrected, debugMode;

- (id)init {
	
	if (!(self = [super init])) return nil;
	
	self.position = DCTContentBarPositionNone;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillGoAway:) name:UIApplicationWillTerminateNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillGoAway:) name:UIApplicationDidEnterBackgroundNotification object:nil];
	
	NSString *pathComponent = [NSString stringWithFormat:@"%@%@", DTResurrectionKitPathVersion, [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
	archivePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:DTResurrectionKitPathBase];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if (![fileManager fileExistsAtPath:archivePath])
		[fileManager createDirectoryAtPath:archivePath withIntermediateDirectories:YES attributes:nil error:nil];
		
	//[fileManager createDirectoryAtPath:archivePath attributes:nil];
	
	archivePath = [[archivePath stringByAppendingPathComponent:pathComponent] retain];
	
	
	
	if ([self canResurrect]) { // ACCESS FILE SYSTEM TO LOOK FOR STORED PLIST FOR RESURRECTION
		hasResurrected = YES;
		[self resurrectStack];
	}
	
	return self;	
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[modalViewControllerParents release];
	[modalViewControllerChildren release];
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
	
	if (self.debugMode && !self.barView) [[NSBundle mainBundle] loadNibNamed:@"DTResurrectionKitDebugView" owner:self options:nil];
	
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
	/*
	NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"IMAGETEST"];
	
	UIImage *i = [[UIImage alloc] initWithContentsOfFile:path];
	
	NSLog(@"%@:%s %@", self, _cmd, i);
	
	UIImageView *iv = [[UIImageView alloc] initWithImage:i];
	NSLog(@"%@:%s %@", self, _cmd, iv);
	[i release];
	
	[self.view addSubview:iv];
	
	[iv release];
	*/
	if (!self.hasResurrected) return;
	
	if (hasResurrectedModalViewControllers) return;
	
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
	
	hasResurrectedModalViewControllers = YES;	
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
		
	DTResurrector *resurrector = [[DTResurrector alloc] init];
	@try {
		NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:archivePath];
		UIViewController<DTResurrection> *vc = [resurrector resurrect:dict];
		modalViewControllerParents = [resurrector.modalViewControllerParents retain];
		modalViewControllerChildren = [resurrector.modalViewControllerChildren retain];
		self.viewController = vc;
	}
	@catch (NSException * exception) {
		//NSLog(@"Caught %@: %@", [exception name], [exception reason]);
	}
	@finally {
		[resurrector release];
		if (!self.viewController) hasResurrected = NO;
	}
	
	//NSLog(@"%@:%s Finish", self, _cmd);
}

- (void)setDebugMode:(BOOL)aBool {
	debugMode = aBool;
	[UIApplication sharedApplication].statusBarHidden = aBool;
}

- (BOOL)canResurrect {
	//return NO;
	return [[NSFileManager defaultManager] fileExistsAtPath:archivePath];
}

- (void)deconstructStack {
	//NSLog(@"%@:%s Start", self, _cmd);
	
	DTResurrector *resurrector = [[DTResurrector alloc] init];
	@try {
		NSDictionary *dict = [resurrector deconstructWithRootObject:self.viewController];
		[dict writeToFile:archivePath atomically:YES];
		NSLog(@"%@:%@ Finish: %@", self, NSStringFromSelector(_cmd), dict);
	}
	@catch (NSException *exception) {
		//NSLog(@"Caught %@: %@", [exception name], [exception reason]);
	}
	@finally {
		[resurrector release];
	}
}

- (void)saveCurrentImage {
	NSString *imageSavePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"IMAGETEST"];
	
	UIGraphicsBeginImageContext(self.view.bounds.size);
	[self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(viewImage)];
	
	[imageData writeToFile:imageSavePath atomically:YES];
}

- (void)applicationWillGoAway:(id)sender {
	[self deconstructStack];
	//[self saveCurrentImage];
}

/*
- (IBAction)loadResurrection:(id)sender {
	DTResurrectionKitLoadViewController *lvc = [[DTResurrectionKitLoadViewController alloc] initWithresurrectionController:self];
	[self swizzledPresentModalViewController:lvc animated:YES];
	[lvc release];
}

- (IBAction)saveResurrection:(id)sender {
	DTResurrectionKitSaveViewController *lvc = [[DTResurrectionKitSaveViewController alloc] initWithViewController:self.viewController];
	[self swizzledPresentModalViewController:lvc animated:YES];
	[lvc release];
}*/

@end
