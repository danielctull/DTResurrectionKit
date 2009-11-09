//
//  DTResurrector.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 06.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTStack.h"

@protocol DTResurrection;

@interface DTResurrector : NSObject {

	NSMutableDictionary *mainDictionary;
	
	NSMutableDictionary *currentDict;
	
	DTStack *encodingStack;
	NSDictionary *currentlyEncodingObject;
	NSString *currentlyEncodingObjectsKey;
	NSMutableDictionary *objectDictionary;
	
	
	
	
	
	
}

- (NSDictionary *)deconstructWithRootObject:(NSObject<DTResurrection> *)object;
- (id)resurrect:(NSDictionary *)aDictionary;

- (void)setObject:(id)anObject forKey:(NSString *)aKey;
- (id)objectForKey:(NSString *)key;
- (BOOL)objectIsCoreObject:(id)object;

@end
