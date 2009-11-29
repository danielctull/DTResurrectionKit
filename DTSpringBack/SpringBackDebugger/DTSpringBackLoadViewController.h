//
//  DTSpringBackLoadViewController.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 16.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTSpringBackController.h"

@interface DTSpringBackLoadViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	NSArray *items;
	DTSpringBackController *springBackController;
	NSString *archivePath;
	UITableView *tableView;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (id)initWithSpringBackController:(DTSpringBackController *)sbc;
- (IBAction)cancel:(id)sender;
@end
