//
//  DTResurrectionController.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTResurrectionKit.h"
#import "DCTContentViewController.h"

extern NSString *const DTResurrectionKitPathBase;
extern NSString *const DTResurrectionKitPathVersion;
extern NSString *const DTResurrectionKitPathDebug;

/** The resurrection controller is a view controller subclass that easily enables
 resurrection behaviour in your application.
 */
@interface DTResurrectionController : DCTContentViewController {
	NSString *archivePath;
	BOOL hasResurrected;
	BOOL debugMode;
	
	BOOL hasResurrectedModalViewControllers;
	
	NSArray *modalViewControllerParents, *modalViewControllerChildren;
	
}

/**  
 */
@property (nonatomic, assign) BOOL hasResurrected;


/** 
 */
@property (nonatomic, assign) BOOL debugMode;

//- (IBAction)loadResurrection:(id)sender;
//- (IBAction)saveResurrection:(id)sender;

/**
 
 
 */
- (void)resurrectWithArchivePath:(NSString *)path;

@end
