//
//  NSObject+DTMethodSwizzling.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (DTMethodSwizzling)

+ (void)swizzleMethod:(SEL)originalSelector withMethod:(SEL)newSelector;

@end
