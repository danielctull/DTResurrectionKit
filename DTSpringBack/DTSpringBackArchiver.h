//
//  DTSpringBackArchiver.h
//  DTSpringBack
//
//  Created by Daniel Tull on 06.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTStack.h"

@protocol DTSpringBack;


/** When SpringBack is prompted to save it will ask every object in the object graph to save neccessary data
 using the -encodeToArchiver method defined in the DTSpringBack protocol. When asked, objects can store any 
 object they wish, as long as it itself adheres to the DTSpringBack protocol or is one of the core objects:
 NSString, NSData, NSDate or NSNumber.
 
 Once passed to the encoder, it will then ask any non-core-object to save its data. In this reccursive fashion,
 the whole object graph will be included and can be restored later on.
 
 The encoder stores objects as a flat structure, linking objects by an internal reference. In this way objects
 will only be asked to save themselves once. This means not only is the resulting file on disk is small because 
 objects are not duplicated, but all the original connections are preserved, so that two objects referencing 
 another will both still be referencing the same object after restoration.
 */
@interface DTSpringBackArchiver : NSObject {

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

- (NSDictionary *)deconstructWithRootObject:(NSObject<DTSpringBack> *)object;
- (id)resurrect:(NSDictionary *)aDictionary;



- (BOOL)objectIsCoreObject:(id)object;


/** @brief Uses to save metadata about the object.
  
 @param object The object to be saved.
 @param key The key to identify the object.
 */
- (void)setObject:(id)object forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

@end
