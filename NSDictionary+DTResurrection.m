//
//  NSDictionary+DTResurrection.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 09.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "NSDictionary+DTResurrection.h"


@implementation NSDictionary (DTResurrection)

- (id)initWithResurrector:(DTResurrector *)resurrector {
	
	NSInteger amount = [[resurrector objectForKey:@"amount"] integerValue];
	
	NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
	
	for (NSInteger i = 0; i < amount; i++)
		[tempDict setObject:[resurrector objectForKey:[NSString stringWithFormat:@"object%i", i]] forKey:[resurrector objectForKey:[NSString stringWithFormat:@"key%i", i]]];
		
	self = [self initWithDictionary:tempDict];
	
	[tempDict release];
	
	return self;
}

- (void)encodeToResurrector:(DTResurrector *)resurrector {
	
	[resurrector setObject:[NSNumber numberWithInt:[self count]] forKey:@"amount"];
	
	for (NSUInteger i = 0; i < [self count]; i++) {
		id key = [[self allKeys] objectAtIndex:i];
		[resurrector setObject:key forKey:[NSString stringWithFormat:@"key%i", i]];
		[resurrector setObject:[self objectForKey:key] forKey:[NSString stringWithFormat:@"object%i", i]];
	}
}
@end
