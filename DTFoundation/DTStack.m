//
//  DTStack.m
//  DTKit
//
//  Created by Daniel Tull on 05.04.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTStack.h"


@implementation DTStack

- (id)init {
	
	if (!(self = [super init])) return nil;
	
	queue = [[NSMutableArray alloc] init];
	
	return self;
}

- (void)dealloc {
	[queue release];
	[super dealloc];
}

- (NSUInteger)count {
	return [queue count];
}

- (void)push:(id)object {
	[queue addObject:object];
}

- (id)pop {
	id object = [[queue lastObject] retain];
	[queue removeLastObject];
	return [object autorelease];
}

- (NSArray *)allObjects {
	return [[queue retain] autorelease];
}

- (NSArray *)popToObject:(id)object {
	
	NSMutableArray *returnArray = [[NSMutableArray alloc] init];
	
	while (![[self topObject] isEqual:object]) {
		[returnArray addObject:[self pop]];
	}
	return [returnArray autorelease];
}

- (NSArray *)popToRootObject {
	return [self popToObject:[queue objectAtIndex:0]];
}

- (id)topObject {
	return [[[queue lastObject] retain] autorelease];
}

@end
