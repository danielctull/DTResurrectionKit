//
//  DTResurrector.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 06.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTResurrector.h"
#import "DTResurrectionController.h"

NSString *const DTResurrectionObjectString = @"DTResurrectionObject";
NSString *const DTResurrectionRootObjectString = @"DTResurrectionRootObject";

NSString *const DTResurrectionKitPropertyClass = @"class";

@interface DTResurrector ()
@property (nonatomic, retain, readwrite) NSArray *modalViewControllerParents, *modalViewControllerChildren;
- (NSString *)generateToken;
- (NSString *)uniqueString;
@end


@implementation DTResurrector

@synthesize modalViewControllerParents, modalViewControllerChildren;

- (id)init {
	if (!(self = [super init])) return nil;
	
	modalViewControllerParents = [[NSArray alloc] init];
	modalViewControllerChildren = [[NSArray alloc] init];
	
	return self;
}

- (void)dealloc {
	[modalViewControllerParents release];
	[modalViewControllerChildren release];
	[super dealloc];
}

- (void)viewController:(UIViewController *)parentVC unpackedModalViewController:(UIViewController *)childVC {
	//NSLog(@"%@:%s", self, _cmd);
	self.modalViewControllerParents = [self.modalViewControllerParents arrayByAddingObject:parentVC];
	self.modalViewControllerChildren = [self.modalViewControllerChildren arrayByAddingObject:childVC];	
	//NSLog(@"\n%@\n%@", modalViewControllerParents, modalViewControllerChildren);
}


- (NSDictionary *)deconstructWithRootObject:(NSObject<DTResurrection> *)object {
	
	mainDictionary = [[NSMutableDictionary alloc] init];
	encodingStack = [[DCTStack alloc] init];
	objectDictionary = [[NSMutableDictionary alloc] init];
	
	NSString *token = [self generateToken];
	
	[objectDictionary setObject:object forKey:token];
	
	[mainDictionary setObject:token forKey:DTResurrectionRootObjectString];
	
	NSMutableDictionary *objectDict = [[NSMutableDictionary alloc] init];
	[objectDict setObject:NSStringFromClass([object class]) forKey:DTResurrectionKitPropertyClass];
	[encodingStack push:objectDict];
	
	[mainDictionary setObject:objectDict forKey:token];
	[objectDict release];
	
	[object encodeToResurrector:self];
	
	[encodingStack pop];
	[encodingStack release];
	[objectDictionary release];
	
	return [mainDictionary autorelease];
}

- (void)setObject:(id)object forKey:(NSString *)aKey {
	
	NSMutableDictionary *parentObject = [encodingStack topObject];
	
	if ([[objectDictionary allValues] containsObject:object]) { // To prevent infinite loop by two objects referencing each other.
		
		NSEnumerator *enumerator = [objectDictionary keyEnumerator];
		NSString *testToken;
		
		while (testToken = [enumerator nextObject])
			if ([[objectDictionary objectForKey:testToken] isEqual:object])
				break;
		
		[parentObject setObject:testToken forKey:aKey];
		return;
	}
	
	if ([self objectIsCoreObject:object]) { // If the object is a NSString, NSNumber, NSData
		[parentObject setObject:object forKey:aKey];
		return;
	}
	
	NSString *token = [self generateToken];
	
	
	//NSLog(@"%@:%s %@ %@", self, _cmd, aKey, object);
	
	[objectDictionary setObject:object forKey:token];
	
	NSMutableDictionary *objectDict = [[NSMutableDictionary alloc] init];
	
	[mainDictionary setObject:objectDict forKey:token];
	
	if ([object isKindOfClass:[NSArray class]])
		[objectDict setObject:@"NSArray" forKey:DTResurrectionKitPropertyClass];
	else if ([object isKindOfClass:[NSDictionary class]])
		[objectDict setObject:@"NSDictionary" forKey:DTResurrectionKitPropertyClass];
	else
		[objectDict setObject:NSStringFromClass([object class]) forKey:DTResurrectionKitPropertyClass];
	
	[encodingStack push:objectDict];
	[objectDict release];
	
	if ([object respondsToSelector:@selector(encodeToResurrector:)]) {
		[parentObject setObject:token forKey:aKey];
		[object encodeToResurrector:self];
	}
	
	[encodingStack pop];
}


- (id)resurrect:(NSDictionary *)aDictionary {
	
	NSString *token = [aDictionary objectForKey:DTResurrectionRootObjectString];
	
	if (!token) return nil;	
	
	mainDictionary = [aDictionary retain];
	encodingStack = [[DCTStack alloc] init];
	objectDictionary = [[NSMutableDictionary alloc] init];
	
	NSMutableDictionary *objectDict = [mainDictionary objectForKey:token];
		
	[encodingStack push:objectDict];
	
	Class objectClass = NSClassFromString([objectDict objectForKey:DTResurrectionKitPropertyClass]);
	
	
	[encodingStack push:objectDict];
	
	NSObject<DTResurrection> *returnObject = [[objectClass alloc] initWithResurrector:self];	
	
	[encodingStack pop];
	
	[encodingStack release];
	[mainDictionary release];
	[objectDictionary release];
	
	return (id)([returnObject autorelease]);	
}

- (id)objectForKey:(NSString *)key {
	
	NSMutableDictionary *parentObject = [encodingStack topObject];
	
	NSObject *object = [parentObject objectForKey:key];
	
	if (!object) return nil;
	
	if ([self objectIsCoreObject:object]) {
		if ([object isKindOfClass:[NSString class]]) {
			NSString *string = (NSString *)object;
			if (![string hasPrefix:DTResurrectionObjectString])
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
	
	Class objectClass = NSClassFromString([objectDict objectForKey:DTResurrectionKitPropertyClass]);
	
	[encodingStack push:objectDict];
	
	returnObject = [objectClass alloc];
	
	[objectDictionary setObject:returnObject forKey:token];
		
	returnObject = [returnObject initWithResurrector:self];	
	
	[encodingStack pop];
	
	return [returnObject autorelease];	
}

- (BOOL)objectIsCoreObject:(id)object {
	
	if ([object isKindOfClass:[NSNumber class]] || [object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSData class]] || [object isKindOfClass:[NSDate class]])
		return YES;
	
	return NO;
}

- (NSString *)generateToken {
	return [NSString stringWithFormat:@"%@:%@", DTResurrectionObjectString, [self uniqueString]];
}

- (NSString *)uniqueString {
	CFUUIDRef uuidObj = CFUUIDCreate(nil);
	CFStringRef uniqueString = CFUUIDCreateString(nil, uuidObj);
	NSString *string = [(NSString *)uniqueString retain];
	CFRelease(uniqueString);
	CFRelease(uuidObj);
	return [string autorelease];
}

@end
