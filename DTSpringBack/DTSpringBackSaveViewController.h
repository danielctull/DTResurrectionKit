//
//  DTSpringBackSaveViewController.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 16.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DTSpringBackSaveViewController : UIViewController {
	UITextField *textField;
	UIViewController *vcToSave;
}

@property (nonatomic, retain) IBOutlet UITextField *textField;

- (id)initWithViewController:(UIViewController *)vc;

@end
