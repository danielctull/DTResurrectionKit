//
//  DTSpringBackSaveViewController.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 16.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTSpringBackSaveViewController.h"
#import "UIViewController+DTSpringBack.h"

@implementation DTSpringBackSaveViewController

@synthesize textField;

- (id)initWithViewController:(UIViewController *)vc {
	if (!(self = [self initWithNibName:@"DTSpringBackSaveView" bundle:nil])) return nil;
	
	vcToSave = [vc retain];
	
	return self;
}

- (void)dealloc {
	[vcToSave release];
	[super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"SpringBack";
	
	if ([self.textField canBecomeFirstResponder]) [self.textField becomeFirstResponder];

	UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
	self.navigationItem.leftBarButtonItem = left;
	[left release];

	UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
	self.navigationItem.rightBarButtonItem = right;
	[right release];
}

- (void)cancel:(id)sender {
	[self.parentViewController swizzledDismissModalViewControllerAnimated:YES];
}

- (void)save:(id)sender {
	
	NSString *archivePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:DTSpringBackPathBase];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if (![fileManager fileExistsAtPath:archivePath])
		[fileManager createDirectoryAtPath:archivePath withIntermediateDirectories:YES attributes:nil error:nil];
	
	archivePath = [archivePath stringByAppendingPathComponent:DTSpringBackPathDebug];
	
	if (![fileManager fileExistsAtPath:archivePath])
		[fileManager createDirectoryAtPath:archivePath withIntermediateDirectories:YES attributes:nil error:nil];
	
	archivePath = [archivePath stringByAppendingPathComponent:self.textField.text];
	
	DTSpringBackArchiver *resurrector = [[DTSpringBackArchiver alloc] init];
	
	
	
	NSDictionary *dict = [resurrector deconstructWithRootObject:vcToSave];
	[resurrector release];
	[dict writeToFile:archivePath atomically:NO];
	NSLog(@"%@:%s Finish: %@", self, _cmd, dict);
	
	[self.parentViewController swizzledDismissModalViewControllerAnimated:YES];
}

@end
