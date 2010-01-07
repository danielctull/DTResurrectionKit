//
//  DTQueue.h
//  DTFoundation
//
//  Created by Daniel Tull on 05.04.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <Foundation/Foundation.h>

/** This represents a queue (first in, first out) data structure in computer science. It has the
 push and pop operations usually found in stacks, plus a few other methods
 to make it more useful.
 */
@interface DTQueue : NSObject {
	NSMutableArray *queue;
}

/** @name Standard queue operations
 @{
 */

/** @brief The number of items in the queue.
 
 @return The number of items in the queue.
 */
- (NSUInteger)count;

/** @brief Add an object to the end of the queue.
 
 @param object The object to add.
 */
- (void)enqueue:(id)object;
- (void)push:(id)object;

/** @brief Remove the object at the front of the queue and return it.
 
 @return The object at the front of the queue.
 */
- (id)dequeue;
- (id)pop;

/** @brief Return the object at the front of the queue without removing it from the queue.
 
 @return The object at the front of the queue.
 */
- (id)front;

/**
 @}
 */

@end
