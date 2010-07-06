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
 
 @param archiver The archiver doing the restoration.
 */
- (id)initWithArchiver:(DTResurrector *)archiver;

/** @brief Method SpringBack uses to save the object metadata.
 
 @param archiver The archiver doing the saving.
 */
- (void)encodeToArchiver:(DTResurrector *)archiver;
@end

#import "DTResurrector.h"
#import "DTSpringBackController.h"

#import "UITabBarController+DTSpringBack.h"
#import "UIViewController+DTSpringBack.h"
#import "UINavigationController+DTSpringBack.h"
#import "NSArray+DTSpringBack.h"
#import "NSDictionary+DTSpringBack.h"