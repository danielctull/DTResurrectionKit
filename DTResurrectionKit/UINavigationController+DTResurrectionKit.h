//
//  UINavigationController+DTResurrectionKit.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (DTResurrectionKit)
- (void)swizzledPushViewController:(UIViewController *)aViewController animated:(BOOL)animated;
- (void)swizzledPopViewControllerAnimated:(BOOL)animated;
@end
