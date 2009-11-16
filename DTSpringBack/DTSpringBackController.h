//
//  DTSpringBackController.h
//  DTSpringBack
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTSpringBack.h"
#import "DTContentController.h"

extern NSString *const DTSpringBackPathBase;
extern NSString *const DTSpringBackPathVersion;
extern NSString *const DTSpringBackPathDebug;

@interface DTSpringBackController : DTContentController {
	UIViewController<DTSpringBack> *viewController;
	NSString *archivePath;
	BOOL hasSprungBack;
	BOOL debugMode;
}

@property (nonatomic, assign) BOOL hasSprungBack, debugMode;
@property (nonatomic, retain) UIViewController<DTSpringBack> *viewController;

- (IBAction)loadSpringBack:(id)sender;
- (IBAction)saveSpringBack:(id)sender;
- (void)resurrectWithArchivePath:(NSString *)path;

@end
