//
//  DTSpringBack.h
//  DTSpringBack
//
//  Created by Daniel Tull on 09.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

@class DTResurrector;

/** The DTSpringBack protocol should be adopted by any class wanting to be saved to and restored
 from the SpringBack system.
 */
@protocol DTSpringBack
/** @brief Initialiser SpringBack uses to restore the object.
 
 As shown in DTSpring, you can save 
 
 @param resurrector The resurrector doing the restoration.
 */
- (id)initWithResurrector:(DTResurrector *)resurrector;

/** @brief Method SpringBack uses to save the object metadata.
 
 @param resurrector The resurrector doing the saving.
 */
- (void)encodeToResurrector:(DTResurrector *)resurrector;
@end

#import "DTResurrector.h"
#import "DTResurrectionController.h"

#import "UITabBarController+DTSpringBack.h"
#import "UIViewController+DTSpringBack.h"
#import "UINavigationController+DTSpringBack.h"
#import "NSArray+DTSpringBack.h"
#import "NSDictionary+DTSpringBack.h"