//
//  DTModalTestViewController.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 22.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DTModalTestViewController : UIViewController {
	NSInteger count;
}

@property (nonatomic, assign) NSInteger count;

- (IBAction)presentVC:(id)sender;

@end
