//
//  DTSortedArray.h
//  DTFoundation
//
//  Created by Daniel Tull on 21.05.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DTSortedArray : NSObject {
	NSMutableArray *array;
	SEL sortSelector;
}

- (id)initWithSortSelector:(SEL)aSelector;
- (void)addObject:(id)anObject;
- (void)addObjectsFromArray:(NSArray *)otherArray;

@end
