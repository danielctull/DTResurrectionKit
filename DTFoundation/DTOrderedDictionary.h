//
//  DTOrderedDictionary.h
//  DTKit
//
//  Created by Daniel Tull on 21.05.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DTOrderedDictionary : NSMutableDictionary {
	
	NSMutableDictionary *superDictionary;
	NSArray *sortedKeys;
	SEL sortSelector;
}

@property (nonatomic, copy) NSArray *sortedKeys;

- (id)initWithSortSelector:(SEL)aSelector;

@end
