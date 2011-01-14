//
//  DTResurrector.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 06.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCTStack.h"

@protocol DTResurrection;


/** When DTResurrectionKit is prompted to save it will ask every object in the object graph to save neccessary data
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
	
	DCTStack *encodingStack;
	NSDictionary *currentlyEncodingObject;
	NSString *currentlyEncodingObjectsKey;
	NSMutableDictionary *objectDictionary;
	
	
	NSArray *modalViewControllerParents, *modalViewControllerChildren;
}

@property (nonatomic, retain, readonly) NSArray *modalViewControllerParents;
@property (nonatomic, retain, readonly) NSArray *modalViewControllerChildren;

- (void)viewController:(UIViewController *)parentVC unpackedModalViewController:(UIViewController *)childVC;

/** Used to test if an the given object is a core object within resurrection kit.
 
 Core objects in the system are currently members of the classes NSNumber, NSString, NSData and NSDate.
 If you want to store any other type of object, you will need to implement the initWithResurrector: and
 encodeToResurrector: methods from the DTResurrection protocol.
 
 The reason the list of core objects is not the same as any object that conforms to NSCoding is that the 
 resurrection system keeps a reference of the objects it is saving, and if it comes across the same object
 again, it won't need to query it again, and instead will use the existing refernce.
 
 @param object The object to test.
 @return YES if the object is a core object, NO if not. 
 */
- (BOOL)objectIsCoreObject:(id)object;

/// @name Convert graph hierarchy

/** Encodes the graph hierarchy starting at the given object.
 
 @param object The root object of the graph.
 
 @return A dictionary representing the object graph.
 */
- (NSDictionary *)deconstructWithRootObject:(NSObject<DTResurrection> *)object;

/** @brief Restores a graph hierarchy using a dictionary representation.
 
 @param dictionary A dictionary representing the object graph.
 @return The root object of the graph.
 */
- (id)resurrect:(NSDictionary *)dictionary;


/// @name Storing values

/** Use to save metadata about the object.
  
 @param object The object to be saved.
 @param key The key to identify the object.
 */
- (void)setObject:(id)object forKey:(NSString *)key;



/** Use to retrive metadata about the object.
 
 @param key The key to identify the object.
 */
- (id)objectForKey:(NSString *)key;

@end
