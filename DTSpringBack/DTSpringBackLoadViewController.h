//
//  DTSpringBackLoadViewController.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 16.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTSpringBackController.h"

@interface DTSpringBackLoadViewController : UITableViewController {
	NSArray *items;
	DTSpringBackController *springBackController;
	NSString *archivePath;
}

@end
