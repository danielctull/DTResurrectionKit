//
//  NSArray+DTResurrection.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 09.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "NSArray+DTResurrection.h"


@implementation NSArray (DTResurrection)

- (id)initWithResurrector:(DTResurrector *)resurrector {
	
	NSInteger amount = [[resurrector objectForKey:@"amount"] integerValue];
	
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	
	for (NSInteger i = 0; i < amount; i++)
		[tempArray addObject:[resurrector objectForKey:[NSString stringWithFormat:@"%i", i]]];
	
	self = [self initWithArray:tempArray];
	
	[tempArray release];
	
	return self;
}

- (void)encodeToResurrector:(DTResurrector *)resurrector {
	
	[resurrector setObject:[NSNumber numberWithInt:[self count]] forKey:@"amount"];
	
	for (NSInteger i = 0; i < [self count]; i++)
		[resurrector setObject:[self objectAtIndex:i] forKey:[NSString stringWithFormat:@"%i", i]];	
}


@end
