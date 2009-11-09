//
//  DTResurrectionController.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTResurrectionKit.h"

@interface DTResurrectionController : UIViewController {
	UIViewController<DTResurrection> *viewController;
	NSString *archivePath;
	BOOL hasResurrected;
}

@property (nonatomic, assign) BOOL hasResurrected;
@property (nonatomic, retain) UIViewController<DTResurrection> *viewController;

@end
