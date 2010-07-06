//
//  DTResurrectionController.h
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

/** The SpringBack controller is a view controller subclass that easily enables
 SpringBack behaviour in your application.
 */
@interface DTResurrectionController : DTContentController {
	//UIViewController<DTSpringBack> *viewController;
	NSString *archivePath;
	BOOL hasSprungBack;
	BOOL debugMode;
	
	BOOL hasSprungBackModalViewControllers;
	
	NSArray *modalViewControllerParents, *modalViewControllerChildren;
	
}

@property (nonatomic, assign) BOOL hasSprungBack;
@property (nonatomic, assign) BOOL debugMode;
//@property (nonatomic, retain) UIViewController<DTSpringBack> *viewController;

- (IBAction)loadSpringBack:(id)sender;
- (IBAction)saveSpringBack:(id)sender;
- (void)resurrectWithArchivePath:(NSString *)path;

@end
