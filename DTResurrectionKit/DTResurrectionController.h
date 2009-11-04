//
//  DTResurrectionController.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTResurrectionController : UIViewController {
}

- (void)addResurrectableViewControllerWithCreatingViewController:(UIViewController *)creatingViewController
														theClass:(Class)aClass
														selector:(SEL)aSelector
														 objects:(NSArray *)someObjects;


@end
