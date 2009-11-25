//
//  UIViewController+DTSpringBack.h
//  DTSpringBack
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTSpringBack.h"

@class DTSpringBackController;

@interface UIViewController (DTSpringBack) <DTSpringBack>
@property (readonly) DTSpringBackController *springBackController;
@property (readonly) UIViewController *frontViewController;
- (BOOL)isFrontViewController;

// USED ONLY IN DEBUG MODE
- (void)swizzledPresentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated;
- (void)swizzledDismissModalViewControllerAnimated:(BOOL)animated;
@end
