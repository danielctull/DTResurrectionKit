//
//  DTResurrector.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 06.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTResurrector.h"
#import "DTResurrectionController.h"

@interface DTResurrector ()

- (NSString *)uniqueToken;

@end


@implementation DTResurrector

- (NSDictionary *)deconstructWithRootObject:(NSObject<DTResurrection> *)object {
	NSLog(@"%@:%s:%@", self, _cmd, object);
	mainDictionary = [[NSMutableDictionary alloc] init];
	encodingStack = [[DTStack alloc] init];
	objectDictionary = [[NSMutableDictionary alloc] init];
	
	NSString *token = [NSString stringWithFormat:@"DTResurectionRelatedObject:%@", [self uniqueToken]];
	
	
	[objectDictionary setObject:object forKey:token];
	
	[mainDictionary setObject:token forKey:@"DTResurectionRootObject"];
	
	
	NSLog(@"%@:%s 1", self, _cmd);
	NSMutableDictionary *objectDict = [[NSMutableDictionary alloc] init];
	[objectDict setObject:NSStringFromClass([object class]) forKey:@"class"];
	[encodingStack push:objectDict];
	
	NSLog(@"%@:%s 2", self, _cmd);
	[mainDictionary setObject:objectDict forKey:token];
	[objectDict release];
	
	NSLog(@"%@:%s 3", self, _cmd);
	[object encodeToResurrector:self];
	
	[encodingStack pop];
	[encodingStack release];
	[objectDictionary release];
	
	return [mainDictionary autorelease];
}

- (void)setObject:(id)anObject forKey:(NSString *)aKey {
	
	NSLog(@"%@:%s :%@ :%@ %@", self, _cmd, anObject, aKey, [anObject class]);
	
	NSMutableDictionary *parentObject = [encodingStack topObject];
	
	
	NSLog(@"Parent Dict: %@", parentObject);
	
	if ([[objectDictionary allValues] containsObject:anObject]) { // To prevent infinite loop by two objects referencing each other.
		
		NSEnumerator *enumerator = [objectDictionary keyEnumerator];
		NSString *testToken;
		
		while (testToken = [enumerator nextObject])
			if ([[objectDictionary objectForKey:testToken] isEqual:anObject])
				break;
		
		[parentObject setObject:testToken forKey:aKey];
		return;
	}
/*
	if ([anObject isKindOfClass:[NSArray class]]) {
		
		NSMutableArray *mutarray = [[NSMutableArray alloc] init];
		for (NSObject<DTResurrection> *o in anObject) {
			
			[o encodeToResurrector:self]
			[mutarray addObject:];
			
		
		}
			
			
		[parentObject setObject:mutarray forKey:aKey];
	
	}*/
	
	if ([self objectIsCoreObject:anObject]) { // If the object is a NSString, NSNumber, NSData
		
		NSLog(@"%@:%s CORE CORE CORE", self, _cmd);
		
		
		[parentObject setObject:anObject forKey:aKey];
		return;
	}
	
	NSString *token = [NSString stringWithFormat:@"DTResurectionRelatedObject:%@", [self uniqueToken]];
	
	[objectDictionary setObject:anObject forKey:token];
	
	NSMutableDictionary *objectDict = [[NSMutableDictionary alloc] init];
	
	[mainDictionary setObject:objectDict forKey:token];
	
	if ([anObject isKindOfClass:[NSArray class]])
		[objectDict setObject:@"NSArray" forKey:@"class"];
	else
		[objectDict setObject:NSStringFromClass([anObject class]) forKey:@"class"];
	
	[encodingStack push:objectDict];
	[objectDict release];
	
	if ([anObject respondsToSelector:@selector(encodeToResurrector:)]) {
		[parentObject setObject:token forKey:aKey];
		[anObject encodeToResurrector:self];
	}
	
	[encodingStack pop];
}


- (id)resurrect:(NSDictionary *)aDictionary {
	
	NSLog(@"%@:%s %@", self, _cmd, aDictionary);
	
	mainDictionary = [aDictionary retain];
	encodingStack = [[DTStack alloc] init];
	objectDictionary = [[NSMutableDictionary alloc] init];
	
	NSString *token = [mainDictionary objectForKey:@"DTResurectionRootObject"];
	
	NSMutableDictionary *objectDict = [mainDictionary objectForKey:token];
	
	[encodingStack push:objectDict];
	
	Class objectClass = NSClassFromString([objectDict objectForKey:@"class"]);
	
	
	[encodingStack push:objectDict];
	
	NSObject<DTResurrection> *returnObject = [[objectClass alloc] initWithResurrector:self];	
	
	[encodingStack pop];
	
	[encodingStack release];
	[mainDictionary release];
	[objectDictionary release];
	
	return (id)([returnObject autorelease]);	
}

- (id)objectForKey:(NSString *)key {
	
	NSLog(@"%@:%s%@", self, _cmd, key);
	
	NSMutableDictionary *parentObject = [encodingStack topObject];
	
	NSObject *object = [parentObject objectForKey:key];
	
	if ([self objectIsCoreObject:object]) {
		if ([object isKindOfClass:[NSString class]]) {
			NSString *string = (NSString *)object;
			if (![string hasPrefix:@"DTResurectionRelatedObject:"])
				return string;
		} else {
			return object;
		}
	}
	
	NSString *token = (NSString *)object;
	
	NSObject<DTResurrection> *returnObject;
	
	if (returnObject = [objectDictionary objectForKey:token])
		return returnObject;
		
	NSDictionary *objectDict = [mainDictionary objectForKey:token];
	
	Class objectClass = NSClassFromString([objectDict objectForKey:@"class"]);
	
	[encodingStack push:objectDict];
	
	returnObject = [objectClass alloc];
	
	[objectDictionary setObject:returnObject forKey:token];
		
	returnObject = [returnObject initWithResurrector:self];	
	
	[encodingStack pop];
	
	return [returnObject autorelease];	
}

- (BOOL)objectIsCoreObject:(id)object {
	
	if ([object isKindOfClass:[NSNumber class]] || [object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSData class]])
		return YES;
	
	return NO;
}

- (NSString *)uniqueToken {
	CFUUIDRef uuidObj = CFUUIDCreate(nil);
	NSString *token = (NSString *)CFUUIDCreateString(nil, uuidObj);
	CFRelease(uuidObj);
	return token;
}

@end
