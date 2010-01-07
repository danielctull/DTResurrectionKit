//
//  DTTraversableDictionary.h
//  DTKit
//
//  Created by Daniel Tull on 21/05/2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTOrderedDictionary.h"

@interface DTTraversableDictionary : DTOrderedDictionary {
	id currentKey;
}

@property (nonatomic, retain) id currentKey;

- (id)firstObject;
- (id)lastObject;
- (id)nextObject;
- (id)previousObject;

@end
