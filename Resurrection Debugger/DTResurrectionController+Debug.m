//
//  DTResurrectionController+Debug.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 07.12.2010.
//  Copyright 2010 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTResurrectionController+Debug.h"
#import "DTResurrectionKitLoadViewController.h"
#import "DTResurrectionKitSaveViewController.h"

@implementation DTResurrectionController (Debug)

- (IBAction)loadResurrection:(id)sender {
	DTResurrectionKitLoadViewController *lvc = [[DTResurrectionKitLoadViewController alloc] initWithresurrectionController:self];
	[self swizzledPresentModalViewController:lvc animated:YES];
	[lvc release];
}

- (IBAction)saveResurrection:(id)sender {
	DTResurrectionKitSaveViewController *lvc = [[DTResurrectionKitSaveViewController alloc] initWithViewController:self.viewController];
	[self swizzledPresentModalViewController:lvc animated:YES];
	[lvc release];
}

@end
