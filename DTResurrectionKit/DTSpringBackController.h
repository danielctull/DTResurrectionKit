//
//  DTSpringBackController.h
//  DTSpringBack
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTSpringBack.h"

@interface DTSpringBackController : UIViewController {
	UIViewController<DTSpringBack> *viewController;
	NSString *archivePath;
	BOOL hasSprungBack;
}

@property (nonatomic, assign) BOOL hasSprungBack;
@property (nonatomic, retain) UIViewController<DTSpringBack> *viewController;

@end
