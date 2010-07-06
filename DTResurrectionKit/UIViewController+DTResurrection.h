//
//  UIViewController+DTResurrection.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTResurrectionKit.h"

@class DTResurrectionController;

/** Adds the methods for the SpringBack protocol to UIViewController and adds methods for finding the root 
 SpringBack controller and the front most view controller.
 */
@interface UIViewController (DTResurrection) <DTResurrection>
@property (readonly) DTResurrectionController *resurrectionController;
@property (readonly) UIViewController *frontViewController;
- (BOOL)isFrontViewController;

// USED ONLY IN DEBUG MODE
- (void)swizzledPresentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated;
- (void)swizzledDismissModalViewControllerAnimated:(BOOL)animated;
@end
