//
//  DTStack.m
//  DTFoundation
//
//  Created by Daniel Tull on 05.04.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTStack.h"

@implementation DTStack

- (id)init {
	
	if (!(self = [super init])) return nil;
	
	stack = [[NSMutableArray alloc] init];
	
	return self;
}

- (void)dealloc {
	[stack release];
	[super dealloc];
}

- (NSUInteger)count {
	return [stack count];
}

- (void)push:(id)object {
	[stack addObject:object];
}

- (id)pop {
	id object = [[stack lastObject] retain];
	[stack removeLastObject];
	return [object autorelease];
}

- (id)topObject {
	return [self top];
}

- (id)top {
	return [[[stack lastObject] retain] autorelease];
}

- (NSArray *)allObjects {
	return [[stack retain] autorelease];
}

- (NSArray *)popToObject:(id)object {
	
	NSMutableArray *returnArray = [[NSMutableArray alloc] init];
	
	while (![[self topObject] isEqual:object]) {
		[returnArray addObject:[self pop]];
	}
	return [returnArray autorelease];
}

- (NSArray *)popToRootObject {
	return [self popToObject:[stack objectAtIndex:0]];
}



@end
