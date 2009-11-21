//
//  DTSpringBackEncoder.h
//  DTSpringBack
//
//  Created by Daniel Tull on 06.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTStack.h"

@protocol DTSpringBack;

@interface DTSpringBackEncoder : NSObject {

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

- (void)setObject:(id)anObject forKey:(NSString *)aKey;
- (id)objectForKey:(NSString *)key;

- (BOOL)objectIsCoreObject:(id)object;

@end
