//
//  DTResurrector.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 06.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTStack.h"

@protocol DTResurrection;


/** When SpringBack is prompted to save it will ask every object in the object graph to save neccessary data
 using the -encodeToResurrector method defined in the DTResurrectionKit protocol. When asked, objects can store any 
 object they wish, as long as it itself adheres to the DTResurrectionKit protocol or is one of the core objects:
 NSString, NSData, NSDate or NSNumber.
 
 Once passed to the encoder, it will then ask any non-core-object to save its data. In this reccursive fashion,
 the whole object graph will be included and can be restored later on.
 
 The encoder stores objects as a flat structure, linking objects by an internal reference. In this way objects
 will only be asked to save themselves once. This means not only is the resulting file on disk is small because 
 objects are not duplicated, but all the original connections are preserved, so that two objects referencing 
 another will both still be referencing the same object after restoration.
 */
@interface DTResurrector : NSObject {

	NSMutableDictionary *mainDictionary;
	
	NSMutableDictionary *currentDict;
	
	DTStack *encodingStack;
	NSDictionary *currentlyEncodingObject;
	NSString *currentlyEncodingObjectsKey;
	NSMutableDictionary *objectDictionary;
	
	
	NSArray *modalViewControllerParents, *modalViewControllerChildren;
}

@property (nonatomic, retain, readonly) NSArray *modalViewControllerParents, *modalViewControllerChildren;

- (void)viewController:(UIViewController *)parentVC unpackedModalViewController:(UIViewController *)childVC;


- (BOOL)objectIsCoreObject:(id)object;

/** @name Convert graph hierarchy
 @{
 */
/** @brief Encodes the graph hierarchy starting at the given object.
 
 @param object The root object of the graph.
 return A dictionary representing the object graph.
 */
- (NSDictionary *)deconstructWithRootObject:(NSObject<DTResurrection> *)object;

/** @brief Restores a graph hierarchy using a dictionary representation.
 
 @param dictionary A dictionary representing the object graph.
 return The root object of the graph.
 */
- (id)resurrect:(NSDictionary *)dictionary;


/**
 @}
 */

/** @name Storing values
 @{
 */

/** @brief Use to save metadata about the object.
  
 @param object The object to be saved.
 @param key The key to identify the object.
 */
- (void)setObject:(id)object forKey:(NSString *)key;

/** @brief Use to retrive metadata about the object.
 
 @param key The key to identify the object.
 */
- (id)objectForKey:(NSString *)key;

/**
 @}
 */

@end
