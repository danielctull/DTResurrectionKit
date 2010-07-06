//
//  NSDictionary+DTSpringBack.m
//  DTSpringBack
//
//  Created by Daniel Tull on 09.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "NSDictionary+DTSpringBack.h"


@implementation NSDictionary (DTSpringBack)

- (id)initWithArchiver:(DTResurrector *)archiver {
	
	NSInteger amount = [[archiver objectForKey:@"amount"] integerValue];
	
	NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
	
	for (NSInteger i = 0; i < amount; i++)
		[tempDict setObject:[archiver objectForKey:[NSString stringWithFormat:@"object%i", i]] forKey:[archiver objectForKey:[NSString stringWithFormat:@"key%i", i]]];
		
	self = [self initWithDictionary:tempDict];
	
	[tempDict release];
	
	return self;
}

- (void)encodeToArchiver:(DTResurrector *)archiver {
	
	[archiver setObject:[NSNumber numberWithInt:[self count]] forKey:@"amount"];
	
	for (NSInteger i = 0; i < [self count]; i++) {
		id key = [[self allKeys] objectAtIndex:i];
		[archiver setObject:key forKey:[NSString stringWithFormat:@"key%i", i]];
		[archiver setObject:[self objectForKey:key] forKey:[NSString stringWithFormat:@"object%i", i]];
	}
}
@end
