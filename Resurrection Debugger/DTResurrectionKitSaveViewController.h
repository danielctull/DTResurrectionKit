//
//  DTResurrectionKitSaveViewController.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 16.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DTResurrectionKitSaveViewController : UIViewController {
	UITextField *textField;
	UIViewController *vcToSave;
}

@property (nonatomic, retain) IBOutlet UITextField *textField;

- (id)initWithViewController:(UIViewController *)vc;
- (void)cancel:(id)sender;
- (void)save:(id)sender;
@end
