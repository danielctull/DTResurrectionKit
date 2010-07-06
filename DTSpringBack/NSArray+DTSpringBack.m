//
//  NSArray+DTSpringBack.m
//  DTSpringBack
//
//  Created by Daniel Tull on 09.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "NSArray+DTSpringBack.h"


@implementation NSArray (DTSpringBack)

- (id)initWithArchiver:(DTResurrector *)archiver {
	
	NSInteger amount = [[archiver objectForKey:@"amount"] integerValue];
	
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	
	for (NSInteger i = 0; i < amount; i++)
		[tempArray addObject:[archiver objectForKey:[NSString stringWithFormat:@"%i", i]]];
	
	self = [self initWithArray:tempArray];
	
	[tempArray release];
	
	return self;
}

- (void)encodeToArchiver:(DTResurrector *)archiver {
	
	[archiver setObject:[NSNumber numberWithInt:[self count]] forKey:@"amount"];
	
	for (NSInteger i = 0; i < [self count]; i++)
		[archiver setObject:[self objectAtIndex:i] forKey:[NSString stringWithFormat:@"%i", i]];	
}


@end
