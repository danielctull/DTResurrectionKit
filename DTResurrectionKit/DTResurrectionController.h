//
//  DTResurrectionController.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTResurrectionKit.h"
#import "DTContentController.h"

extern NSString *const DTResurrectionKitPathBase;
extern NSString *const DTResurrectionKitPathVersion;
extern NSString *const DTResurrectionKitPathDebug;

/** The resurrection controller is a view controller subclass that easily enables
 resurrection behaviour in your application.
 */
@interface DTResurrectionController : DTContentController {
	//UIViewController<DTResurrection> *viewController;
	NSString *archivePath;
	BOOL hasSprungBack;
	BOOL debugMode;
	
	BOOL hasSprungBackModalViewControllers;
	
	NSArray *modalViewControllerParents, *modalViewControllerChildren;
	
}

@property (nonatomic, assign) BOOL hasSprungBack;
@property (nonatomic, assign) BOOL debugMode;
//@property (nonatomic, retain) UIViewController<DTResurrection> *viewController;

- (IBAction)loadResurrection:(id)sender;
- (IBAction)saveResurrection:(id)sender;
- (void)resurrectWithArchivePath:(NSString *)path;

@end
