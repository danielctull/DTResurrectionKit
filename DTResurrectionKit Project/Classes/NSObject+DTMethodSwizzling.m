//
//  NSObject+DTMethodSwizzling.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "NSObject+DTMethodSwizzling.h"


@implementation NSObject (DTMethodSwizzling)

+ (void)swizzleMethod:(SEL)originalSelector withMethod:(SEL)newSelector {

	method_exchangeImplementations(class_getInstanceMethod(self, originalSelector),
								   class_getInstanceMethod(self, newSelector) 
								   );
}

@end
