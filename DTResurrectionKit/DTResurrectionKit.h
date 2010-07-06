//
//  DTResurrectionKit.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 09.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

@class DTResurrector;

/** The DTResurrectionKit protocol should be adopted by any class wanting to be saved to and restored
 from the SpringBack system.
 */
@protocol DTResurrection
/** @brief Initialiser DTResurrectionKit uses to restore the object.
 
 As shown in DTResurrector, you can save 
 
 @param resurrector The resurrector doing the restoration.
 */
- (id)initWithResurrector:(DTResurrector *)resurrector;

/** @brief Method DTResurrectionKit uses to save the object metadata.
 
 @param resurrector The resurrector doing the saving.
 */
- (void)encodeToResurrector:(DTResurrector *)resurrector;
@end

#import "DTResurrector.h"
#import "DTResurrectionController.h"

#import "UITabBarController+DTResurrection.h"
#import "UIViewController+DTResurrection.h"
#import "UINavigationController+DTResurrection.h"
#import "NSArray+DTResurrection.h"
#import "NSDictionary+DTResurrection.h"