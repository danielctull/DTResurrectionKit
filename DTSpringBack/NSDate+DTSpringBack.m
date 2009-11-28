//
//  NSDate+DTSpringBack.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 28.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "NSDate+DTSpringBack.h"

@implementation NSDate (DTSpringBack)

- (id)initWithResurrector:(DTSpringBackEncoder *)resurrector {
	return [self initWithTimeIntervalSinceReferenceDate:[[resurrector objectForKey:@"interval"] doubleValue]];
}

- (void)encodeToResurrector:(DTSpringBackEncoder *)resurrector {
	[resurrector setObject:[NSNumber numberWithDouble:[self timeIntervalSinceReferenceDate]] forKey:@"interval"];	
}

@end
