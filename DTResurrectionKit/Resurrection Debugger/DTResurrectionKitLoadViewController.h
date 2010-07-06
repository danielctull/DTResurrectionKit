//
//  DTResurrectionKitLoadViewController.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 16.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTResurrectionController.h"

@interface DTResurrectionKitLoadViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	NSArray *items;
	DTResurrectionController *springBackController;
	NSString *archivePath;
	UITableView *tableView;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (id)initWithSpringBackController:(DTResurrectionController *)sbc;
- (IBAction)cancel:(id)sender;
@end
