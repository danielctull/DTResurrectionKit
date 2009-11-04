//
//  UIViewController+DTResurrectionKit.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTResurrectionController.h"

@interface UIViewController (DTResurrectionKit)


- (void)swizzledPresentModalViewController:(UIViewController *)aViewController animated:(BOOL)animated;

- (DTResurrectionController *)resurrectionController;
- (UIViewController *)newResurrectableViewControllerWithClass:(Class)aClass selector:(SEL)aSelector objects:(NSArray *)someObjects;
- (UIViewController *)resurrectableViewControllerWithClass:(Class)aClass selector:(SEL)aSelector objects:(NSArray *)someObjects;

@end
