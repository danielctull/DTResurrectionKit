//
//  DTStack.h
//  DTFoundation
//
//  Created by Daniel Tull on 05.04.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 Specifies the type of connection to use.
 */
typedef enum {
	DTConnectionTypeGet = 0,	/*!< Uses a GET connection. */
	DTConnectionTypePost,		/*!< Uses a POST connection. */
	DTConnectionTypePut,		/*!< Uses a PUT connection. */
	DTConnectionTypeDelete,		/*!< Uses a DELETE connection. */
	DTConnectionTypeOptions,	/*!< Uses a OPTIONS connection. */
	DTConnectionTypeHead,		/*!< Uses a HEAD connection. */
	DTConnectionTypeTrace,		/*!< Uses a TRACE connection. */
	DTConnectionTypeConnect		/*!< Uses a CONNECT connection. */
} DTConnectionType;

/** This represents a stack (last in, first out) data structure in computer science. It has the
 push and pop operations usually found in stacks, plus a few other methods
 to make it more useful.
 */
@interface DTStack : NSObject {
	NSMutableArray *stack;
}

/** @name Standard stack operations
 @{
 */

/** @brief The number of items on the stack.
 
 @return The number of items on the stack.
 */
- (NSUInteger)count;

/** @brief Pushes the given object onto the top of the stack.
 
 @param object The object to be pushed onto the stack.
 */
- (void)push:(id)object;

/** @brief Removes the top object from the stack.
 
 @return The object that has just been popped off the top of the stack.
 */
- (id)pop;

/** @brief Returns the top object without popping it from the stack.
 
 @return The top object on the stack.
 */
- (id)top;


/**
 @}
 */


- (id)topObject;

/** @name Extra functionality
 @{
 */


/** @brief Returns an NSArray of all the objects in the stack.
 
 @return An array of all the objects in the stack.
 */
- (NSArray *)allObjects;

/** @brief Pops the stack until it reaches the given object.
 
 @param object The object to pop to in the stack.
 @return An array of all objects that have been removed from the stack.
 */
- (NSArray *)popToObject:(id)object;

/** @brief Pops the stack until it has only one item left.
 
 @return An array of all objects that have been removed from the stack.
 */
- (NSArray *)popToRootObject;

/**
 @}
 */

@end
